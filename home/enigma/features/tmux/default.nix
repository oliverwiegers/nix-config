{pkgs, ...}: let
  # TODO: Yeah software to never update again.
  # This is a quick workaround to use pre nix config files.
  # This is ugly as hell. Need to fix this.
  source = pkgs.fetchFromGitHub {
    leaveDotGit = true;
    deepClone = true;
    fetchSubmodules = true;
    owner = "oliverwiegers";
    repo = ".tmuxist";
    rev = "947b14d9ced2598107d379c3db9041f7acb91f10";
    sha256 = "Uf5QnrgQRVXTTJVk7JSBtZcY929aBQ2d2O27rc55ocA=";
  };
in {
  home = {
    file = {
      ".tmuxist" = {
        target = ".tmuxist";
        source = "${source}";
      };

      ".tmux.conf" = {
        target = ".tmux.conf";
        source = "${source}/tmux/.tmux.conf";
      };

      # TODO: Set vi mode-keys in tmux.conf again.
      # Currently broken. This is just a workaround.
      ".tmux.conf.local" = {
        target = ".tmux.conf.local";
        text = ''
          # : <<EOF
          unbind-key C-b
          set -g prefix C-k
          bind-key C-k send-prefix
          set-window-option -g mode-keys vi
          # EOF
        '';
      };

      ".tmux.conf.remote" = {
        target = ".tmux.conf.remote";
        source = "${source}/tmux/.tmux.conf.remote";
      };
    };
  };

  programs = {
    tmux = {
      enable = true;
    };
  };
}
