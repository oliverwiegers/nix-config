{ ... }:

{
  home = {
    file = {
      "hyprland.conf" = {
        source = ./hyprland.conf;
        target = ".config/hypr/hyprland.conf";
      };
    };
  };

  programs = {
    zsh = {
      loginExtra = "Hyprland";
    };
  };

  # TODO: Use flake or home-manager module when ready.
  # wayland = {
  #   windowManager = {
  #     hyprland = {
  #       enable = true;
  #       extraConfig = (builtins.readFile ./hyprland.conf);

  #       systemd = {
  #         enable = true;
  #       };
  #     };
  #   };
  # };
}
