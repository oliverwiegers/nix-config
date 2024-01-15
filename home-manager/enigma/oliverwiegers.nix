{outputs, ...}: {
  imports = [
    ../../modules/home-manager
  ];

  home = {
    username = "oliverwiegers";
    homeDirectory = "/home/oliverwiegers";
    stateVersion = "23.05";
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  # Reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  fonts.fontconfig.enable = true;

  os = {
    default = true;
    nixos.enable = true;
  };

  terminal = {
    shell = {
      zsh.enable = true;
    };

    emulator = {
      alacritty.enable = true;
    };

    programs = {
      bat.enable = true;
      btop.enable = true;
      direnv.enable = true;
      fzf.enable = true;
      git.enable = true;
      home-manager.enable = true;
      newsboat.enable = true;
      nix.enable = true;
      ssh.enable = true;
      tmux.enable = true;
    };
  };

  graphical = {
    browser = {
      firefox.enable = true;
    };

    programs = {
      gtk.enable = true;
      rofi.enable = true;
      zathura.enable = true;
    };

    services = {
      mako.enable = true;
    };
  };

  wm = {
    hyprland.enable = true;
  };
}
