{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.os;

  unstablePackages = with pkgs.unstable; [
    findutils
    neofetch
    ranger
    jq
    pass
    ripgrep
    eza
    pywal
    nerdfonts
    signal-desktop
    gnumake
    ncdu
    urlscan
  ];

  neovimPackage = with pkgs.inputs.flim; [
    flim
  ];
in {
  imports = [
    ./nixos
    ./darwin
  ];

  options = {
    os = {
      default = mkEnableOption "Enable default settings for home-manager user.";

      nixos = {
        enable = mkEnableOption "Enable nixos default settings for home-manager user.";
      };

      darwin = {
        enable = mkEnableOption "Enable darwin default settings for home-manager user.";
      };
    };
  };

  config = mkIf cfg.default {
    home.packages = unstablePackages ++ neovimPackage;
  };
}
