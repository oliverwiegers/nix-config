{lib, ...}:
with lib; {
  imports = lib.getConfigFilePaths ./. ++ lib.getDirectoryPaths ./.;

  options = {
    wm = {
      yabai = {
        enable = mkEnableOption "Enable yabai WM.";
      };
    };
  };
}
