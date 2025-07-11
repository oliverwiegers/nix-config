{
  lib,
  config,
  ...
}:
let
  cfg = config.terminal.programs.direnv;
in
{
  options.terminal.programs.direnv = {
    enable = lib.mkEnableOption "Enable direnv.";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };
  };
}
