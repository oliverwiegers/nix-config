{
  lib,
  inputs,
  config,
  ...
}:
with lib;
let
  cfg = config.terminal.emulator.alacritty;
in
{
  config = mkIf cfg.enable {
    programs = {
      alacritty = {
        enable = true;
        settings = {
          window = {
            decorations = "None";
          };
          scrolling = {
            history = 10000;
            multiplier = 3;
          };
          general = {
            import = [
              "${inputs.alacritty-theme}/themes/${config.os.theme.fullName}.toml"
            ];
          };
          # Monospace fonts will make icons smaller.
          font = {
            normal = {
              family = "Iosevka Nerd Font";
              style = "Regular";
            };
            bold = {
              family = "Iosevka Nerd Font";
              style = "Bold";
            };
            italic = {
              family = "Iosevka Nerd Font";
              style = "Italic";
            };

            inherit (cfg.font) size;
          };
        };
      };
    };
  };
}
