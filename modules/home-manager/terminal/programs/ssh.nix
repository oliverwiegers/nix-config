{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.terminal.programs.ssh;
in {
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

            dudek = {
              hostname = "dudek.oliverwiegers.com";
            };

            kryha = {
              hostname = "kryha.oliverwiegers.com";
            };

            rockex = {
              hostname = "rockex.oliverwiegers.com";
            };
          }
          // cfg.extraMatchBlocks;
      };
    };
  };
}
