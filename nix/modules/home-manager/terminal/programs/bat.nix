{
  lib,
  inputs,
  config,
  ...
}:
with lib;
let
  cfg = config.terminal.programs.bat;
in
{
  config = mkIf cfg.enable {
    programs = {
      bat = {
        enable = true;

        config =
          let
            themeName = if config.os.theme.name == "kanagawa" then "kanagawa" else config.os.theme.fullName;
          in
          {
            theme = themeName;
          };

        themes = {
          kanagawa = {
            src = inputs.kanagawa-nvim;
            file = "extras/tmTheme/kanagawa.tmTheme";
          };
        };
      };
    };
  };
}
