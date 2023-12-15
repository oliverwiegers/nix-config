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
    rev = "1dc3f2baa1e141403dbbe884ffd9876cfa39ca0e";
    sha256 = "dqUx9SMlcCDoiogNY4Q1uO2nwBjb14Ddo393D9a/rNY=";
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
