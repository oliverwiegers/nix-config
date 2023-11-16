{ pkgs, ... }:

let
  # TODO: Yeah software to never update again.
  # This is a quick workaround to use pre nix config files.
  # This is ugly as hell. Need to fix this.
  source = pkgs.fetchFromGitHub {
    leaveDotGit = true;
    deepClone = true;
    fetchSubmodules = true;
    owner = "oliverwiegers";
    repo = ".tmuxist";
    rev = "1dfc6e3bf3e8082c1d90e1bf9dc27aa3e005b0ce";
    sha256 = "HDPbqVHkQhQRTKek1I9pNbfVC7AA+Ppm6bHBopPlTVA=";
  };
in
{
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
          unbind-key C-b
          set -g prefix C-k
          bind-key C-k send-prefix
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
