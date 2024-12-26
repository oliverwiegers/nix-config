{
  lib,
  helpers,
  ...
}:
with lib; {
  imports = helpers.getConfigFilePaths ./. ++ helpers.getDirectoryPaths ./.;

  options = {
    wm = {
      yabai = {
        enable = mkEnableOption "Enable yabai WM.";
      };
    };
  };
}
