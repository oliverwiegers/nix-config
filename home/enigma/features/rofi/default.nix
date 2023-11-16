{ pkgs, ... }:

{
  programs = {
    rofi = {
      enable = true;
      package = pkgs.rofi-wayland-unwrapped;
      theme = ./gruvbox-material.rasi;

      extraConfig = {
        display-ssh = "";
        display-run = "";
        display-drun = "";
        display-window = "";
        display-combi = "";
        show-icons = true;
      };
    };
  };
}
