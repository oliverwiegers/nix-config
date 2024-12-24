{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.os;

  unstablePackages = with pkgs; [
    erdtree
    eza
    findutils
    gnumake
    gnused
    go
    jq
    ncdu
    neofetch
    nerd-fonts.sauce-code-pro
    pass
    pre-commit
    pywal
    ranger
    ripgrep
    testssl
    urlscan
    watch
    tree
  ];

  inputsOverlayPackages = with pkgs.inputs; [
    flim.flim
    dagger.dagger
  ];
in {
  imports = lib.getConfigFilePaths ./. ++ lib.getDirectoryPaths ./.;

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
    home.packages = unstablePackages ++ inputsOverlayPackages;
  };
}
