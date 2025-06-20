{
  lib,
  config,
  helpers,
  ...
}:
with lib;
let
  cfg = config.terminal.programs.ssh;
  servers = builtins.mapAttrs (_: properties: {
    hostname = properties.hostName;
  }) helpers._metadata.hosts;

in
{
  config = mkIf cfg.enable {
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
