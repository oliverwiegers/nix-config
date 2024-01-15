{utils, ...}: {
  imports = utils.getConfigFilePaths ./. ++ utils.getDirectoryPaths ./.;
}
