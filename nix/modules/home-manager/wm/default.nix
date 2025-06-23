{
  lib,
  helpers,
  ...
}:
with lib;
{
  imports = helpers.getConfigFilePaths ./. ++ helpers.getDirectoryPaths ./.;

  options = {
    wm = {
      hyprland = {
        enable = mkEnableOption "Enable Hyprland.";
      };

      yabai = {
        enable = mkEnableOption "Enable Yabai (MacOS).";
      };
    };
  };
}
