{...}: {
  programs = {
    alacritty = {
      enable = true;
      settings = {
        env = {
          TERM = "screen-256color";
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
          size = 11;
          scale_with_dpi = true;
        };
      };
    };
  };
}
