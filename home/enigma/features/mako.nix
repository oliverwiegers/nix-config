{ ... }:

{
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
      # Gruvbox colors.
      backgroundColor = "#282828e0";
      textColor = "#ebdbb2";
      borderColor = "#ebdbb2";
      progressColor = "source #cc241d";
    };
  };
}
