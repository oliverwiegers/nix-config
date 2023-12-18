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
    rev = "f14d49290eb023d81bde40c4602dcbd7d8bd85ea";
    sha256 = "tK5F+Y5uSzRgeSkwWzvyFoS8X3eO5CUZEld/LctNH98=";
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
