{lib, ...}: {
  # Read all .nix file from local directory except "default.nix"
  imports =
    map (path: ./. + "/${path}") (
      builtins.filter (
        file: lib.hasSuffix ".nix" file && file != "default.nix"
      ) (
        builtins.attrNames (builtins.readDir (builtins.toString ./.))
      )
    )
    ++ [./zsh];
}
