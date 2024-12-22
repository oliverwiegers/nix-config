{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.terminal.emulator.alacritty;
in {
  config = mkIf cfg.enable {
    programs = {
      alacritty = {
        enable = true;
        settings = {
          window = {
            decorations = "None";
          };
          env = {
            TERM = "screen-256color";
            #TERM = "xterm-256color";
          };
          scrolling = {
            history = 10000;
            multiplier = 3;
          };
          colors = {
            draw_bold_text_with_bright_colors = true;

            # Add gruvbox colors. pywal & alacritty do not work properly together on macos.
            # See here https://github.com/dylanaraps/pywal/wiki/Customization#alacritty-on-macos
            primary = {
              background = "#1d2021";
              foreground = "#d5c4a1";
            };

            cursor = {
              text = "#1d2021";
              cursor = "#d5c4a1";
            };

            vi_mode_cursor = {
              text = "#1d2021";
              cursor = "#d5c4a1";
            };

            search.matches = {
              foreground = "#1d2021";
              background = "#fbf1c7";
            };

            search.focused_match = {
              foreground = "CellBackground";
              background = "CellForeground";
            };

            line_indicator = {
              foreground = "None";
              background = "None";
            };

            footer_bar = {
              foreground = "#665c54";
              background = "#d5c4a1";
            };

            selection = {
              text = "CellBackground";
              background = "CellForeground";
            };

            normal = {
              black = "#1d2021";
              red = "#fb4934";
              green = "#b8bb26";
              yellow = "#fabd2f";
              blue = "#83a598";
              magenta = "#d3869b";
              cyan = "#8ec07c";
              white = "#d5c4a1";
            };

            bright = {
              black = "#665c54";
              red = "#fb4934";
              green = "#b8bb26";
              yellow = "#fabd2f";
              blue = "#83a598";
              magenta = "#d3869b";
              cyan = "#8ec07c";
              white = "#fbf1c7";
            };
          };
          font = {
            normal = {
              family = "SauceCodePro Nerd Font";
              style = "Regular";
            };
            bold = {
              family = "SauceCodePro Nerd Font";
              style = "Bold";
            };
            italic = {
              family = "SauceCodePro Nerd Font";
              style = "Italic";
            };

            inherit (cfg.font) size;
          };
        };
      };
    };
  };
}
