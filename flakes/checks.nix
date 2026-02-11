{ self, ... }:
{
  perSystem =
    { config, pkgs, ... }:
    {
      checks = {
        inherit (config.packages) "9cc";

        test = pkgs.stdenv.mkDerivation {
          pname = "9cc-test";
          version = "0.1.0";

          src = self;

          buildInputs = [ pkgs.glibc.static ];

          buildPhase = ''
            make
            make test
          '';

          installPhase = "mkdir -p $out";
        };
      };
    };
}
