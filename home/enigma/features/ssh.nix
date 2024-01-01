{...}: {
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

      matchBlocks = {
        kali = {
          user = "root";
          hostname = "10.5.0.5";
          extraOptions = {
            StrictHostKeyChecking = "no";
            RequestTTY = "yes";
            RemoteCommand = "tmux -L tmux new-session -As hacktheplanet";
            UserKnownHostsFile = "/dev/null";
          };
        };

        hackthebox = {
          user = "root";
          hostname = "10.10.0.10";
          extraOptions = {
            StrictHostKeyChecking = "no";
            RequestTTY = "yes";
            RemoteCommand = "tmux -L tmux new-session -As hacktheplanet";
            UserKnownHostsFile = "/dev/null";
          };
        };

        router = {
          user = "root";
          hostname = "router.oliverwiegers.com";
          identityFile = "~/.ssh/id_rsa";
          extraOptions = {
            RequestTTY = "yes";
            HostKeyAlgorithms = "+ssh-rsa";
          };
        };
      };
    };
  };
}
