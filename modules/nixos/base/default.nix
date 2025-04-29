{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.base;
in {
  options.base = {
    timeZone = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      defaultText = "null";
      example = "base.timeZone = \"Europe/Vienna\";";
      description = "Set timeZone for host.";
    };

    stateVersion = lib.mkOption {
      type = lib.types.str;
      default = "24.11";
      defaultText = "24.11";
      example = "base.stateVersion = \"24.11\";";
      description = "Set the stateVersion for the nixos config.";
    };
  };

  config = {
    time = {
      inherit (cfg) timeZone;
    };

    # Boot settings.
    boot = {
      kernelPackages = pkgs.linuxPackages_latest;
    };

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

    system = {
      inherit (cfg) stateVersion;
    };

    networking.enableIPv6 = false;
  };
}
