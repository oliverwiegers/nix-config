{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.workstation.wm;
in {
  config = mkIf cfg.enable {
    programs = {
      hyprland = {
        enable = true;
      };
    };

    services = {
      pipewire = {
        enable = true;

        wireplumber = {
          enable = true;
        };
      };
    };

    xdg = {
      portal = {
        enable = true;
        extraPortals = [pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk];
      };
    };
  };
}
