{
  inputs,
  lib,
  outputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };
  };

  networking = {
    hostName = "enigma";
    enableIPv6 = false;

    firewall = {
      enable = false;
    };

    wireless = {
      enable = true;
      interfaces = ["wlp3s0"];

      networks = {
        Follow-The-Wires = {
          pskRaw = "e08ac9e6c4f27cd9e09a0833130e60baf86e5c984443041aec3d24158896afc5";
        };
      };
    };

    networkmanager = {
      enable = false;
    };
  };

  # Boot settings.
  boot = {
    kernelPackages = pkgs.unstable.linuxPackages_latest;

    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
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

    etc = {
      "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
        bluez_monitor.properties = {
            ["bluez5.enable-sbc-xq"] = true,
            ["bluez5.enable-msbc"] = true,
            ["bluez5.enable-hw-volume"] = true,
            ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag a2dp_sink ]"
        }
      '';
    };
  };

  programs = {
    hyprland = {
      enable = true;
    };

    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };

    zsh = {
      enable = true;
    };
  };

  services = {
    pipewire = {
      enable = true;

      pulse = {
        enable = true;
      };

      alsa = {
        enable = true;
      };

      wireplumber = {
        enable = true;
      };
    };

    pcscd = {
      enable = true;
    };
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk];
    };
  };

  system.stateVersion = "23.11";

  fileSystems = {
    "/media/nas" = {
      device = "daedalus.oliverwiegers.com:/mnt/carter/olli";
      fsType = "nfs";
    };
    "/media/nas_vanessa" = {
      device = "daedalus.oliverwiegers.com:/mnt/carter/vanessa";
      fsType = "nfs";
    };
  };

  security = {
    # Enable realtime processing for hq sound.
    rtkit = {
      enable = true;
    };
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

  hardware = {
    pulseaudio = {
      enable = false;
    };

    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    opengl = {
      enable = true;
    };
  };
}
