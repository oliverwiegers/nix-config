{
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.terminal.programs.fzf;
in
{
  config = mkIf cfg.enable {
    programs = {
      fzf = {
        enable = true;
        enableZshIntegration = true;
      };
    };
  };
}
