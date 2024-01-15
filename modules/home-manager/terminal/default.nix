{lib, ...}:
with lib; {
  imports = [
    ./emulator
    ./shell
    ./programs
  ];

  options = {
    terminal = {
      emulator = {
        alacritty = {
          enable = mkEnableOption "Enable Alacritty terminal emulator.";
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
        };

        tmux = {
          enable = mkEnableOption "Enable tmux.";
        };
      };
    };
  };
}
