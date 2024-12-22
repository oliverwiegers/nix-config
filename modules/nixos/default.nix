{myLib, ...}: {
  imports = myLib.getConfigFilePaths ./. ++ myLib.getDirectoryPaths ./.;
}
