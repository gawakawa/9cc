_: {
  perSystem =
    { config, pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        inputsFrom = [ config.packages."9cc" ];

        packages = config.pre-commit.settings.enabledPackages;

        shellHook = ''
          ${config.pre-commit.shellHook}
        '';
      };
    };
}
