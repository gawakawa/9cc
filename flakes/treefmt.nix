_: {
  perSystem = _: {
    treefmt = {
      programs = {
        nixfmt = {
          enable = true;
          includes = [ "*.nix" ];
        };
        clang-format = {
          enable = true;
          includes = [
            "*.c"
            "*.h"
          ];
        };
        asmfmt = {
          enable = true;
          includes = [
            "*.s"
            "*.S"
          ];
        };
        shfmt = {
          enable = true;
          includes = [ "*.sh" ];
        };
      };
    };
  };
}
