{lib, ...}: {
  imports = lib.getConfigFilePaths ./. ++ lib.getDirectoryPaths ./.;
}
