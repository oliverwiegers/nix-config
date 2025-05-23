{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.graphical.programs.rofi;
in
{
  config = mkIf cfg.enable {
    programs = {
      rofi = {
        enable = true;
        package = pkgs.rofi-wayland-unwrapped;
        theme = ./gruvbox-material.rasi;

        extraConfig = {
          display-ssh = "";
          display-run = "";
          display-drun = "";
          display-window = "";
          display-combi = "";
          show-icons = true;
        };
      };
    };
  };
}
