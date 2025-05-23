{
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.graphical.services.mako;
in
{
  config = mkIf cfg.enable {
    services = {
      mako = {
        enable = true;
        borderSize = 1;
        borderRadius = 3;
        width = 400;
        height = 150;
        margin = "20,20,20";
        padding = "20,20,20";
        defaultTimeout = 30000;
        font = "SauceCodPro Nerd Font";
        format = ''<b>%s</b>\n\n%b'';
        backgroundColor = "${config.os.theme.colors.background}";
        textColor = "${config.os.theme.colors.foreground}";
        borderColor = "${config.os.theme.colors.black}";
        progressColor = "${config.os.theme.colors.green}";
      };
    };
  };
}
