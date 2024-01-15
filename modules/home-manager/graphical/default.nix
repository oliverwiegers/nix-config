{lib, ...}:
with lib; {
  imports = [
    ./browser
    ./programs
    ./services
  ];

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
