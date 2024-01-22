{lib, myLib, ...}:
with lib; {
  imports = myLib.getConfigFilePaths ./. ++ myLib.getDirectoryPaths ./.;

  options = {
    wm = {
      yabai = {
        enable = mkEnableOption "Enable yabai WM.";
      };
    };
  };
}
