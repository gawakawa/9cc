{
  description = "C compiler in C";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    mcp-servers-nix.url = "github:natsukium/mcp-servers-nix";
  };

  outputs =
    inputs@{ flake-parts, self, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.flake-parts.flakeModules.easyOverlay
        inputs.treefmt-nix.flakeModule
      ];

      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];

      perSystem =
        {
          config,
          self',
          inputs',
          pkgs,
          system,
          ...
        }:
        let
          mcpConfig = inputs.mcp-servers-nix.lib.mkConfig pkgs {
            programs = {
              nixos.enable = true;
              serena.enable = true;
            };
          };
        in
        {
          packages."9cc" = pkgs.stdenv.mkDerivation {
            pname = "9cc";
            version = "0.1.0";

            src = ./.;

            buildInputs = [ pkgs.glibc.static ];

            buildPhase = ''
              make
            '';

            installPhase = ''
              mkdir -p $out/bin
              cp 9cc $out/bin/
            '';
          };

          packages.default = config.packages."9cc";

          packages.mcp-config = mcpConfig;

          overlayAttrs = {
            inherit (config.packages) "9cc";
          };

          devShells.default = pkgs.mkShell {
            inputsFrom = [ config.packages."9cc" ];

            shellHook = ''
              cat ${mcpConfig} > .mcp.json
              echo "Generated .mcp.json"
            '';
          };

          checks = {
            inherit (config.packages) "9cc";

            test = pkgs.stdenv.mkDerivation {
              pname = "9cc-test";
              version = "0.1.0";

              src = ./.;

              buildInputs = [ pkgs.glibc.static ];

              buildPhase = ''
                make
                make test
              '';

              installPhase = "mkdir -p $out";
            };
          };

          treefmt = {
            programs = {
              nixfmt.enable = true;
              asmfmt.enable = true;
              clang-format.enable = true;
              cmake-format.enable = true;
              shfmt.enable = true;
            };
          };
        };

      flake = {
        nixosModules."9cc" =
          { pkgs, ... }:
          {
            nixpkgs.overlays = [ self.overlays.default ];

            environment.systemPackages = [ pkgs."9cc" ];
          };
      };
    };
}
