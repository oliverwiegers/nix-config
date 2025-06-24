{
  lib,
  config,
  helpers,
  ...
}:
let
  cfg = config.terminal.programs.ssh;
  servers = builtins.mapAttrs (_: properties: {
    hostname = properties.hostName;
  }) helpers._metadata.hosts;

in
{
  options.terminal.programs.ssh = {
    enable = lib.mkEnableOption "Enable ssh.";
    extraMatchBlocks = lib.mkOption {
      type = lib.types.attrs;
      default = { };
    };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      ssh = {
        enable = true;
        forwardAgent = true;

        extraConfig = ''
          IgnoreUnknown UseKeychain
          UseKeychain yes
          IdentityFile ~/.ssh/id_ed25519
          AddKeysToAgent yes
        '';

        matchBlocks =
          {
            "*" = {
              user = "root";
            };
          }
          // servers
          // cfg.extraMatchBlocks;
      };
    };
  };
}
