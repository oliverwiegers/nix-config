{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.graphical.programs.gtk;
in {
  config = mkIf cfg.enable {
    gtk = {
      enable = true;

      theme = {
        name = "gruvbox-dark";
        package = pkgs.gruvbox-dark-gtk;
      };

      iconTheme = {
        name = "gruvbox-dark";
        package = pkgs.gruvbox-dark-icons-gtk;
      };
    };
  };
}
