{helpers, ...}: {
  imports = helpers.getConfigFilePaths ./. ++ helpers.getDirectoryPaths ./.;
}
