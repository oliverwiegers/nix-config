{
  outputs,
  helpers,
  ...
}:
with helpers; {
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

  fonts.fontconfig = enabled;

  os.nixos = enabled;

  terminal = {
    shell = {
      zsh = enabled;
    };

    emulator = {
      alacritty = {
        enable = true;
        font.size = 11;
      };
    };

    programs = {
      bat = enabled;
      btop = enabled;
      direnv = enabled;
      fzf = enabled;
      home-manager = enabled;
      newsboat = enabled;
      nix = enabled;
      tmux = enabled;
      terraform = enabled;

      ssh = {
        enable = true;
        matchBlocks = {
          kali = {
            user = "root";
            hostname = "10.5.0.5";
            extraOptions = {
              StrictHostKeyChecking = "no";
              RequestTTY = "yes";
              RemoteCommand = "tmux -L tmux new-session -As hacktheplanet";
              UserKnownHostsFile = "/dev/null";
            };
          };

          hackthebox = {
            user = "root";
            hostname = "10.10.0.10";
            extraOptions = {
              StrictHostKeyChecking = "no";
              RequestTTY = "yes";
              RemoteCommand = "tmux -L tmux new-session -As hacktheplanet";
              UserKnownHostsFile = "/dev/null";
            };
          };

          router = {
            user = "root";
            hostname = "router.oliverwiegers.com";
            identityFile = "~/.ssh/id_rsa";
            extraOptions = {
              requestTTY = "yes";
              HostKeyAlgorithms = "+ssh-rsa";
            };
          };
        };
      };

      git = {
        enable = true;
        extraConfig = {
          user = {
            email = "oliver.wiegers@gmail.com";
            name = "oliverwiegers";
            signingkey = "244D3FF3276A942F8666536FDE9FDB17F778EFDA";
          };
          commit = {
            gpgsign = true;
          };
          gpg = {
            program = "gpg2";
          };
          init = {
            defaultBranch = "main";
          };
          "protocol \"http\"" = {
            allow = "never";
          };
          "protocol \"git\"" = {
            allow = "never";
          };
        };
      };
    };
  };

  graphical = {
    browser = {
      firefox = enabled;
    };

    programs = {
      gtk = enabled;
      rofi = enabled;
      zathura = enabled;
    };

    services = {
      mako = enabled;
    };
  };

  wm = {
    hyprland = enabled;
  };

  hackstation = enabled;
}
