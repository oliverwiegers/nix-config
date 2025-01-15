{
  lib,
  pkgs,
  config,
  helpers,
  ...
}:
with lib; let
  cfg = config.serverBase;
in {
  imports = helpers.getConfigFilePaths ./. ++ helpers.getDirectoryPaths ./.;

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
      ];

      variables = {
        EDITOR = "vim";
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
  };
}
