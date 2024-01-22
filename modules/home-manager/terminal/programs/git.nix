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
        extraConfig = cfg.extraConfig;
      };
    };
  };
}
