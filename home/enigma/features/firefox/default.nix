{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        id = 0;
        isDefault = true;
        settings = {
          # TODO: Add nix-colors
          #"devtools.theme" = "";
          "browser.fullscreen.autohide" = false;
          "privacy.donottrackheader.enabled" = true;
          "privacy.donottrackheader.value" = 1;
          "privacy.firstparty.isolate" = true;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "ui.key.menuAccessKeyFocuses" = false;
        };

        extensions = with pkgs.inputs.firefox-addons; [
          vimium
          browserpass
          bypass-paywalls-clean
          i-dont-care-about-cookies
          privacy-badger
          ublock-origin
        ];
      };
    };
  };

  programs.browserpass = {
    enable = config.programs.firefox.enable;
    browsers = [ "firefox" ];
  };
}
