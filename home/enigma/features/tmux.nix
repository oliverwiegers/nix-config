{pkgs, ...}: {
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

      ".tmux.conf.remote" = {
        target = ".tmux.conf.remote";
        source = "${pkgs.inputs.tmuxist.tmux}/tmux/.tmux.conf.remote";
      };
    };
  };
}
