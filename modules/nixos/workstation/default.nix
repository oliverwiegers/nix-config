{
  pkgs,
  lib,
  config,
  myLib,
  ...
}:
with lib; let
  cfg = config.workstation;
in {
  imports = myLib.getConfigFilePaths ./. ++ myLib.getDirectoryPaths ./.;

  options = {
    workstation = {
      enable = mkEnableOption "Enable settings for use as workstation.";

      audio = {
        enable = mkEnableOption "Enable audio using PipeWire.";
      };

      bluetooth = {
        enable = mkEnableOption "Enable bluetooth.";
      };

      laptop = {
        enable = mkEnableOption "Enable laptop settings like power management.";
      };

      virtualization = {
        enable = mkEnableOption "Enable virtualization using Podman.";
      };

      wifi = {
        enable = mkEnableOption "Enable wireless networking.";
      };

      wm = {
        enable = mkEnableOption "Enable window manager settings using Hyprland.";
      };
    };
  };

  config = mkIf cfg.enable {
    # Boot settings.
    boot = {
      kernelPackages = pkgs.unstable.linuxPackages_latest;

      loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot.enable = true;
      };

      kernel = {
        sysctl = {
          "net.ipv4.ip_forward" = true;
        };
      };
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

    users.users = {
      oliverwiegers = {
        isNormalUser = true;
        extraGroups = ["wheel"];
        description = "Oliver Wiegers";
        shell = pkgs.zsh;
      };
    };

    environment = {
      systemPackages = with pkgs; [
        vim-full
        dhcpcd
        wpa_supplicant
        nettools
        inetutils
        wget
        git
      ];
    };

    programs = {
      gnupg = {
        agent = {
          enable = true;
        };
      };

      zsh = {
        enable = true;
      };
    };

    system.stateVersion = "23.11";

    fileSystems = {
      "/media/nas" = {
        device = "daedalus.oliverwiegers.com:/mnt/carter/olli";
        fsType = "nfs";
        options = ["nofail"];
      };
      "/media/nas_vanessa" = {
        device = "daedalus.oliverwiegers.com:/mnt/carter/vanessa";
        fsType = "nfs";
        options = ["nofail"];
      };
    };

    security = {
      sudo = {
        enable = true;
        extraRules = [
          {
            users = ["oliverwiegers"];
            commands = [
              {
                command = "ALL";
                options = ["NOPASSWD" "SETENV"];
              }
            ];
          }
        ];
      };
    };
  };
}
