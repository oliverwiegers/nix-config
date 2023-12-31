{
  lib,
  outputs,
  pkgs,
  ...
}: let
  unstablePackages = with pkgs.unstable; [
    qt5.qtwayland
    qt6.qtwayland
    findutils
    libnotify
    neofetch
    nyxt
    ranger
    jq
    pass
    wl-clipboard
    pavucontrol
    ripgrep
    eza
    pywal
    nerdfonts
    signal-desktop
    imv
    gnumake
    brightnessctl
    ncdu
    urlscan
  ];

  neovimPackage = with pkgs.inputs.flim; [
    flim
  ];
in {
  imports = [
    ./features/zsh
    ./features/rofi
    ./features/firefox
    ./features/hyprland

    ./features/fzf.nix
    ./features/bat.nix
    ./features/gtk.nix
    ./features/git.nix
    ./features/ssh.nix
    ./features/mako.nix
    ./features/tmux.nix
    ./features/btop.nix
    ./features/direnv.nix
    ./features/zathura.nix
    ./features/newsboat.nix
    ./features/nix-index.nix
    ./features/alacritty.nix
    ./features/home-manager.nix
  ];

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      warn-dirty = false;
    };
  };

  # Reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  fonts.fontconfig.enable = true;

  home = {
    username = "oliverwiegers";
    homeDirectory = "/home/oliverwiegers";
    stateVersion = "23.05";

    packages = unstablePackages ++ neovimPackage;
  };
}
