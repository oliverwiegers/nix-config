{
  helpers,
  lib,
  ...
}:
with lib; {
  imports = helpers.getConfigFilePaths ./. ++ helpers.getDirectoryPaths ./.;

  options = {
    base = {
      timeZone = mkOption {
        type = types.str;
        default = "Europe/Berlin";
        defaultText = "Europe/Berlin";
        example = "base.timeZone = \"Europe/Vienna\";";
        description = "Set timeZone for host.";
      };

      stateVersion = mkOption {
        type = types.str;
        default = "24.11";
        defaultText = "24.11";
        example = "base.stateVersion = \"24.11\";";
        description = "Set the stateVersion for the nixos config.";
      };
    };

    serverBase = {
      enable = mkEnableOption "base server configuration.";
    };

    mailServer = {
      enable = mkEnableOption "mailserver based on simple-nixos-mailserver.";

      domains = mkOption {
        type = types.listOf types.str;
        example = ["example.com"];
        default = [];
        description = "The domains that this mail server serves.";
      };

      subDomain = mkOption {
        type = types.str;
        default = "mail";
        defaultText = "mail";
        example = "subDomain = \"mail\"";
        description = "Sub domain of first item in ({option}`mailServer.domains`).";
      };

      secretsFile = mkOption {
        type = types.path;
        default = null;
        defaultText = "null";
        example = "./secrets.yaml";
        description = "Path to secrets.yaml for nix-sops.";
      };
    };
  };
}
