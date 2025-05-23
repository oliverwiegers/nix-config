{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.os.nixos;
in
{
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      qt5.qtwayland
      qt6.qtwayland
      libnotify
      wl-clipboard
      pavucontrol
      imv
      signal-desktop
      brightnessctl
      android-tools
      android-udev-rules
    ];
  };
}
