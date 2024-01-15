{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.terminal.programs.bat;
in {
  config = mkIf cfg.enable {
    programs = {
      bat = {
        enable = true;
        config = {
          theme = "gruvbox-dark";
        };
      };
    };
  };
}
