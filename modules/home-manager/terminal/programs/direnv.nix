{
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.terminal.programs.direnv;
in
{
  config = mkIf cfg.enable {
    programs = {
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };
  };
}
