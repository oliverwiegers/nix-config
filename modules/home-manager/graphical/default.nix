{
  pkgs,
  lib,
  helpers,
  ...
}:
with lib;
{
  imports = helpers.getConfigFilePaths ./. ++ helpers.getDirectoryPaths ./.;

  options = {
    graphical = {
      browser = {
        firefox = {
          enable = mkEnableOption "Enable Firefox browser.";
          package = mkOption {
            type = types.package;
            default = pkgs.firefox;
          };
        };
      };

      programs = {
        gtk = {
          enable = mkEnableOption "Enable GTK.";
        };

        rofi = {
          enable = mkEnableOption "Enable Rofi.";
        };

        zathura = {
          enable = mkEnableOption "Enable Zathura.";
        };
      };

      services = {
        mako = {
          enable = mkEnableOption "Enable Mako.";
        };
      };
    };
  };
}
