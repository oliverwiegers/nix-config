{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.os.nixos;
in {
  config = mkIf cfg.enable {
    home.packages = with pkgs.unstable; [
      qt5.qtwayland
      qt6.qtwayland
      libnotify
      wl-clipboard
      pavucontrol
      imv
      signal-desktop
      brightnessctl
    ];
  };
}
