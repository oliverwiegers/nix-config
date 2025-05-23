{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.terminal.programs.tmux;
in
{
  config = mkIf cfg.enable {
    programs = {
      tmux = {
        enable = true;
        package = pkgs.inputs.tmuxist.tmux;
      };
    };

    home = {
      file = {
        ".tmux.conf.local" = {
          target = ".tmux.conf.local";
          text = ''
            # : <<EOF
            unbind-key C-b
            set -g prefix C-k
            bind-key C-k send-prefix
            # EOF
          '';
        };
      };
    };
  };
}
