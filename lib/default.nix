{lib, ...}: {
  getConfigFilePaths = dir:
    map (path: dir + "/${path}") (
      builtins.filter (
        file: lib.hasSuffix ".nix" file && file != "default.nix"
      ) (
        builtins.attrNames (builtins.readDir (builtins.toString dir))
      )
    );

  getDirectoryPaths = dir:
    map (path: dir + "/${path}") (
      builtins.attrNames (
        lib.attrsets.filterAttrs (file: type: type == "directory") (
          builtins.readDir (builtins.toString dir)
        )
      )
    );
}
