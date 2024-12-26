{
  pkgs,
  lib,
  helpers,
  ...
}:
with lib; let
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
  imports = helpers.getConfigFilePaths ./. ++ helpers.getDirectoryPaths ./.;

  options = {
    os = {
      nixos = {
        enable = mkEnableOption "Enable nixos default settings for home-manager user.";
      };

      darwin = {
        enable = mkEnableOption "Enable darwin default settings for home-manager user.";
      };
    };
  };

  config = {
    home.packages = unstablePackages ++ inputsOverlayPackages;
  };
}
