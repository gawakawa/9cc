{ self, ... }:
{
  perSystem =
    { config, pkgs, ... }:
    {
      packages."9cc" = pkgs.stdenv.mkDerivation {
        pname = "9cc";
        version = "0.1.0";

        src = self;

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

      overlayAttrs = {
        inherit (config.packages) "9cc";
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
}
