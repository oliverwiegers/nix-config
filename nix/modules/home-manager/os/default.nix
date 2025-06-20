{
  pkgs,
  lib,
  helpers,
  ...
}:
with lib;
let
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
    nerd-fonts.iosevka
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
  ];
in
{
  imports = helpers.getConfigFilePaths ./. ++ helpers.getDirectoryPaths ./.;

  options = {
    os = {
      nixos = {
        enable = mkEnableOption "Enable nixos default settings for home-manager user.";
      };

      darwin = {
        enable = mkEnableOption "Enable darwin default settings for home-manager user.";
      };

      theme = {
        name = mkOption {
          type = types.str;
          default = "kanagawa";
        };
        variant = mkOption {
          type = types.str;
          default = "wave";
        };
        fullName = mkOption {
          type = types.str;
          default = null;
        };
        colors = mkOption {
          type = types.attrs;
          default = null;
        };
      };
    };
  };

  config = {
    home.packages = unstablePackages ++ inputsOverlayPackages;
  };
}
