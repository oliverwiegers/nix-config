{pkgs, ...}: let
  gruvbox-anime-headphons-girl = pkgs.fetchurl {
    # Source: https://www.reddit.com/r/unixporn/comments/17zy8b4/hyprland_gruvbox_gang/
    url = "https://wall.alphacoders.com/big.php?i=1333741";
    hash = "";
  };
in {
  programs = {
    wpaperd = {
      enable = true;
      settings = {
        default = {
          path = gruvbox-anime-headphons-girl;
        };
      };
    };
  };
}
