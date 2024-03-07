{
  pkgs,
  lib,
  config,
  myLib,
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
    gnumake
    ncdu
    urlscan
    pre-commit
  ];

  neovimPackage = with pkgs.inputs.flim; [
    flim
  ];
in {
  imports = myLib.getConfigFilePaths ./. ++ myLib.getDirectoryPaths ./.;

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
