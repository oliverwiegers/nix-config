{lib, myLib, ...}:
with lib; {
  imports = myLib.getConfigFilePaths ./. ++ myLib.getDirectoryPaths ./.;

  options = {
    graphical = {
      browser = {
        firefox = {
          enable = mkEnableOption "Enable Firefox browser.";
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
