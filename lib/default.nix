{lib, ...}: rec {
  #     ______                 __  _
  #    / ____/_  ______  _____/ /_(_)___  ____  _____
  #   / /_  / / / / __ \/ ___/ __/ / __ \/ __ \/ ___/
  #  / __/ / /_/ / / / / /__/ /_/ / /_/ / / / (__  )
  # /_/    \__,_/_/ /_/\___/\__/_/\____/_/ /_/____/

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
        lib.attrsets.filterAttrs (_: type: type == "directory") (
          builtins.readDir (builtins.toString dir)
        )
      )
    );

  mkHost = {
    hostsDir,
    hostname,
    isLinux ? true,
    helpers,
    inputs,
    outputs,
  }:
    (
      if isLinux
      then lib.nixosSystem
      else lib.darwinSystem
    ) {
      specialArgs = {inherit helpers inputs outputs;};
      system =
        if isLinux
        then null
        else "aarch64-darwin";
      modules = lib.lists.flatten [
        (hostsDir + "/${hostname}")
        {networking.hostName = lib.mkDefault "${hostname}";}
        (import "${hostsDir}/${hostname}/modules.nix" {inherit inputs;})
      ];
    };

  mkHostConfigs = {
    hostsDir,
    isLinux ? true,
    helpers,
    inputs,
    outputs,
  }:
    builtins.mapAttrs (host: _:
      mkHost {
        inherit isLinux hostsDir helpers inputs outputs;
        hostname = "${host}";
      }) (
      lib.attrsets.filterAttrs (_: type: type == "directory") (
        builtins.readDir (builtins.toString hostsDir)
      )
    );

  #    _____       _                  __
  #   / ___/____  (_)___  ____  ___  / /______
  #   \__ \/ __ \/ / __ \/ __ \/ _ \/ __/ ___/
  #  ___/ / / / / / /_/ / /_/ /  __/ /_(__  )
  # /____/_/ /_/_/ .___/ .___/\___/\__/____/
  #             /_/   /_/

  ## Quickly enable an option.
  ##
  ## ```nix
  ##   services.openssh = enabled;
  ## ```
  ##
  enabled = {
    enable = true;
  };

  ## Quickly disable an option.
  ##
  ## ```nix
  ##   services.openssh = disabled;
  ## ```
  ##
  disabled = {
    enable = false;
  };
}
