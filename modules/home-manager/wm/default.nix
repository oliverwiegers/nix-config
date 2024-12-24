{lib, ...}:
with lib; {
  imports = lib.getConfigFilePaths ./. ++ lib.getDirectoryPaths ./.;

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
