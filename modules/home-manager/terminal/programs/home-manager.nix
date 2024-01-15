{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.terminal.programs.home-manager;
in {
  config = mkIf cfg.enable {
    programs = {
      home-manager = {
        enable = true;
      };
    };
  };
}
