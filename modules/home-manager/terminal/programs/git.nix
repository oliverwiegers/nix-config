{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.terminal.programs.git;
in {
  config = mkIf cfg.enable {
    programs = {
      git = {
        enable = true;

        extraConfig =
          {
            commit = {
              gpgsign = true;
            };
            init = {
              defaultBranch = "main";
            };
            "protocol \"http\"" = {
              allow = "never";
            };
            "protocol \"git\"" = {
              allow = "never";
            };
            difftool = {
              trustExitCode = true;
              prompt = false;
            };
          }
          // cfg.extraConfig;

        difftastic = {
          enable = true;
        };
      };

      zsh = mkIf config.terminal.shell.zsh.enable {
        # Use difftastic for log and show as well'''.
        shellAliases = {
          glgp = "git log --patch --ext-diff";
          gsh = "git show --ext-diff";
          gsps = "git show --pretty=short --show-signature --ext-diff";
        };
      };
    };
  };
}
