{
  pkgs,
  lib,
  config,
  myLib,
  ...
}:
with lib; let
  cfg = config.server;
in {
  imports = myLib.getConfigFilePaths ./. ++ myLib.getDirectoryPaths ./.;

  options = {
    server = {
      enable = mkEnableOption "Enable settings for use as server.";
    };
  };

  config = mkIf cfg.enable {
    # Boot settings.
    boot = {
      kernelPackages = pkgs.unstable.linuxPackages_latest;

      #loader = {
      #  efi.canTouchEfiVariables = true;
      #  systemd-boot.enable = true;
      #};

      #kernel = {
      #  sysctl = {
      #    "net.ipv4.ip_forward" = true;
      #  };
      #};
    };

    # Set your time zone.
    time.timeZone = "Europe/Berlin";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };

    users = {
      mutableUsers = true;

      users = {
        root = {
          initialHashedPassword = "$y$j9T$2419qZYpVwTQ7y5a9h03/.$hn9h3o2Oi5WKIvN/Q001EdSFPbWr9vIIfYBvIloadF2";

          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINKvcXlse6olKBEiRpfPclT4Pn31lpQ4fbZHNv5MBXat"
          ];
        };
      };
    };

    environment = {
      systemPackages = with pkgs; [
        vim-full
        dhcpcd
        nettools
        inetutils
        wget
        git
      ];

      variables = {
        EDITOR = "vim";
      };
    };

    networking = {
      firewall.enable = false;

      nameservers = [
        "1.1.1.1"
        "1.0.0.1"
        "8.8.8.8"
        "2606:4700:4700::1111"
        "2606:4700:4700::1001"
        ];
      };

    services = {
      openssh = {
        enable = true;

        settings = {
          PasswordAuthentication = false;
        };
      };

      resolved = {
        enable = true;
      };

      qemuGuest = {
        enable = true;
      };
    };

    documentation = {
      enable = false;
      nixos.options.warningsAreErrors = false;
      info.enable = false;
    };

    system.stateVersion = "24.11";
  };
}
