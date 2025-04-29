{
  lib,
  helpers,
  ...
}:
with lib; {
  imports = helpers.getConfigFilePaths ./. ++ helpers.getDirectoryPaths ./.;

  options = {
    terminal = {
      emulator = {
        alacritty = {
          enable = mkEnableOption "Enable Alacritty terminal emulator.";
          font = {
            size = mkOption {
              type = lib.types.int;
              default = 11;
              description = "Terminal font size";
            };
          };
        };
      };

      shell = {
        zsh = {
          enable = mkEnableOption "Enable ZSH.";
        };
      };

      programs = {
        bat = {
          enable = mkEnableOption "Enable bat.";
        };

        btop = {
          enable = mkEnableOption "Enable btop.";
        };

        direnv = {
          enable = mkEnableOption "Enable direnv.";
        };

        fzf = {
          enable = mkEnableOption "Enable fzf.";
        };

        git = {
          enable = mkEnableOption "Enable git.";
          extraConfig = mkOption {
            type = lib.types.attrs;
            default = {};
          };
        };

        home-manager = {
          enable = mkEnableOption "Enable home-manager.";
        };

        newsboat = {
          enable = mkEnableOption "Enable newsboat.";
        };

        nix = {
          enable = mkEnableOption "Enable nix related tools and settings.";
        };

        ssh = {
          enable = mkEnableOption "Enable ssh.";
          extraMatchBlocks = mkOption {
            type = lib.types.attrs;
            default = {};
          };
        };

        tmux = {
          enable = mkEnableOption "Enable tmux.";
        };

        terraform = {
          enable = mkEnableOption "Enable Terraform.";
          default = false;
        };

        github = {
          enable = mkEnableOption "Enable GitHub CLI.";
          default = false;
        };

        rust = {
          enable = mkEnableOption "Enable Rust lang toolchains.";
          default = false;
        };

        k8s-cli = {
          enable = mkEnableOption "Enable k8s cli tools.";
          default = false;
        };
      };
    };
  };
}
