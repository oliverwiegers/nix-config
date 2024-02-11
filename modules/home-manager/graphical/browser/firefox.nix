{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.graphical.browser.firefox;
  nixIcon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
in {
  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      package = cfg.package;
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
            i-dont-care-about-cookies
            privacy-badger
            ublock-origin
            foxyproxy-standard
            hacktools
          ];

          search = {
            default = "Searx";
            force = true;

            order = [
              "Searx"
              "DuckDuckGo"
              "Google"
              "Github"
            ];

            engines = {
              "Bing".metaData.hidden = true;
              "Amazon.de".metaData.hidden = true;

              "Google".metaData.alias = "@g";
              "DuckDuckGo".metaData.alias = "@d";
              "Wikipedia (en)".metaData.alias = "@w";

              "Searx" = {
                definedAliases = ["@s"];
                icon = "${nixIcon}";
                iconUpdateURL = "https://search.hbubli.cc/favicon.ico";
                updateInterval = 24 * 60 * 60 * 1000; # every day

                urls = [
                  {
                    template = "https://search.hbubli.cc/search";
                    params = [
                      {
                        name = "q";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
              };

              "Github" = {
                definedAliases = ["@gh"];
                icon = "${nixIcon}";
                iconUpdateURL = "https://github.com/favicon.ico";
                updateInterval = 24 * 60 * 60 * 1000; # every day

                urls = [
                  {
                    template = "https://github.com/search?q={searchTerms}";
                  }
                ];
              };

              "Nix Packages" = {
                definedAliases = ["@np"];
                icon = "${nixIcon}";

                urls = [
                  {
                    template = "https://search.nixos.org/packages";
                    params = [
                      {
                        name = "type";
                        value = "packages";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
              };

              "Nix Manual" = {
                definedAliases = ["@nw"];
                icon = "${nixIcon}";

                urls = [
                  {
                    template = "https://nixos.org/manual/nix/stable/introduction?search={searchTerms}";
                  }
                ];
              };

              "NixOS Options" = {
                icon = "${nixIcon}";
                definedAliases = ["@no"];

                urls = [
                  {
                    template = "https://search.nixos.org/options";
                    params = [
                      {
                        name = "type";
                        value = "options";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
              };

              "NixOS Wiki" = {
                definedAliases = ["@nw"];
                icon = "${nixIcon}";

                urls = [
                  {
                    template = "https://nixos.wiki/index.php?search={searchTerms}";
                  }
                ];
              };

              "Home Manager Options" = {
                definedAliases = ["@ho"];
                icon = "${nixIcon}";

                urls = [
                  {
                    template = "https://mipmip.github.io/home-manager-option-search/?query={searchTerms}";
                  }
                ];
              };
            };
          };
        };
      };
    };

    programs.browserpass = {
      inherit (config.programs.firefox) enable;
      browsers = ["firefox"];
    };
  };
}
