{
  lib,
  pkgs,
  config,
  modulesPath,
  helpers,
  ...
}:
with lib // helpers;
let
  cfg = config.serverBase;
in
{
  imports = [
    (modulesPath + "/profiles/headless.nix")
  ];

  options.serverBase = {
    enable = mkEnableOption "base server configuration.";

    fancyMotd.extraServices = mkOption {
      type = types.str;
      default = "";
      defaultText = "";
      example = ''
        services["nginx"]="Nginx"
      '';
      description = "Additional services to show in motd.";
    };
  };

  config = mkIf cfg.enable {
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
        htop
        jq
        goaccess
        tmux
        restic
        dig
        lazyjournal

        # fancy-motd
        fancy-motd
        figlet
        bc
        curl
        fortune
        lm_sensors
      ];

      variables = {
        EDITOR = "vim";
      };

      etc = {
        fancy-motd =
          let
            defaultConfig = ''
              # Colors
              CA="\e[34m"  # Accent
              CO="\e[32m"  # Ok
              CW="\e[33m"  # Warning
              CE="\e[31m"  # Error
              CN="\e[0m"   # None

              # Max width used for components in second column
              WIDTH=50

              # Services to show
              declare -A services
              services["sshd"]="SSH"
              services["tailscaled"]="Tailscale"
            '';
          in
          {
            text = lib.concatStrings [
              defaultConfig
              cfg.fancyMotd.extraServices
            ];
          };
      };
    };

    networking = {
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
        allowSFTP = false;

        settings = {
          PasswordAuthentication = false;
          LogLevel = "VERBOSE";
        };
      };

      resolved = {
        enable = true;
      };

      qemuGuest = {
        enable = true;
      };

      prometheus.exporters = {
        node = {
          enable = true;
          enabledCollectors = [
            "logind"
            "systemd"
            "mountstats"
          ];
        };
      };

      fail2ban = enabled;
    };

    documentation = {
      enable = true;
      nixos.options.warningsAreErrors = false;
      info.enable = false;
    };

    system.activationScripts.root_profile = ''
      printf '%s\n' 'motd /etc/fancy-motd' > /root/.profile
    '';
  };
}
