{
  lib,
  myLib,
  ...
}:
with lib; {
  imports = myLib.getConfigFilePaths ./. ++ myLib.getDirectoryPaths ./.;

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
