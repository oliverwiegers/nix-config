{
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.terminal.programs.btop;
in
{
  config = mkIf cfg.enable {
    programs = {
      btop = {
        enable = true;
        settings = {
          color_theme = "TTY";
        };
      };
    };
  };
}
