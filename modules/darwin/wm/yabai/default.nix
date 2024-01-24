{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.wm.yabai;
in {
  config = mkIf cfg.enable {
    services = {
      yabai = {
        enable = true;
        extraConfig = builtins.readFile ./yabairc;
        enableScriptingAddition = true;
      };

      skhd = {
        enable = true;
        skhdConfig = builtins.readFile ./skhdrc;
      };
    };
  };
}
