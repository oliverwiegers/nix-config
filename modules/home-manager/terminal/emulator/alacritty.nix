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
            #TERM = "screen-256color";
            TERM = "xterm-256color";
          };
          scrolling = {
            history = 10000;
            multiplier = 3;
          };
          draw_bold_text_with_bright_colors = true;
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
            size = cfg.font.size;
            scale_with_dpi = true;
          };
        };
      };
    };
  };
}
