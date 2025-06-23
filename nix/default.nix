###########################################
###########################################
#                                         #
# Flake inputs are located in ./flake.nix #
#                                         #
###########################################
###########################################
{
  self,
  nixpkgs,
  home-manager,
  nix-darwin,
  deploy-rs,
  flake-utils,
  treefmt-nix,
  ...
}@inputs:
flake-utils.lib.eachDefaultSystemPassThrough (
  system:
  let
    inherit (self) outputs;

    bootstrapPkgs = import nixpkgs { inherit system; };
    bootstrapHelpers = import ./lib { inherit (bootstrapPkgs) lib; };

    # Use nixpkgs.lib because function nixosSystem is in the flake output.
    # See here: https://www.reddit.com/r/NixOS/comments/12i18ns/what_am_i_not_understanding_here_attribute/
    lib = nix-darwin.lib // home-manager.lib // nixpkgs.lib;
    helpers = import ./lib { inherit lib; };

    nixosSystem =
      if bootstrapHelpers.patchesPresent then
        import (nixpkgs-patched + "/nixos/lib/eval-config.nix")
      else
        lib.nixosSystem;

    nixpkgs-patched =
      if bootstrapHelpers.patchesPresent then
        bootstrapPkgs.applyPatches {
          name = "nixpkgs-patched";
          src = nixpkgs;
          patches = bootstrapHelpers.getFilesBySuffix ./patches ".patch";
        }
      else
        nixpkgs;

    pkgs = import nixpkgs-patched { inherit system; };
  in
  {
    nixosConfigurations = helpers.mkHostConfigs {
      inherit
        inputs
        outputs
        helpers
        self
        nixosSystem
        ;
    };

    darwinConfigurations = helpers.mkHostConfigs {
      inherit
        inputs
        outputs
        helpers
        self
        nixosSystem
        ;
      os = "darwin";
    };

    homeConfigurations = {
      "oliverwiegers@enigma" = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs outputs helpers; };
        modules = [ ./hosts/nixos/enigma/homes/oliverwiegers.nix ];
      };

      "oliver.wiegers@sigaba" = inputs.home-manager.lib.homeManagerConfiguration {
        # FIXME: I have to get rid of flake utils.
        # Workaround for buildtime issues on darwin systems.
        pkgs = import nixpkgs-patched { system = "aarch64-darwin"; };
        extraSpecialArgs = { inherit inputs outputs helpers; };
        modules = [ ./hosts/darwin/sigaba/homes/oliver.wiegers.nix ];
      };
    };

    deploy = {
      nodes = builtins.mapAttrs (name: properties: {
        hostname = properties.hostName;
        profiles.system = {
          path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.${name};
        };
      }) helpers._metadata.hosts;

      sshUser = "root";
      remoteBuild = true;
      activationTimeout = 600;
    };
  }
)
// flake-utils.lib.eachDefaultSystem (
  system:
  let
    bootstrapPkgs = import nixpkgs { inherit system; };
    bootstrapHelpers = import ./lib { inherit (bootstrapPkgs) lib; };

    nixpkgs-patched =
      if bootstrapHelpers.patchesPresent then
        bootstrapPkgs.applyPatches {
          name = "nixpkgs-patched";
          src = nixpkgs;
          patches = bootstrapHelpers.getFilesBySuffix ./patches ".patch";
        }
      else
        nixpkgs;

    pkgs = import nixpkgs-patched { inherit system; };

    treefmtEval = treefmt-nix.lib.evalModule pkgs {
      # Be a bit more verbose by default, so we can see progress happening
      settings.verbose = 1;
      programs = {
        terraform.enable = true;
        hclfmt.enable = true;
        shellcheck.enable = true;
        statix.enable = true;
        deadnix.enable = true;
        nixfmt.enable = true;
      };
    };
  in
  {
    devShells = import ../shell.nix { inherit pkgs; };
    formatter = treefmtEval.config.build.wrapper;

    checks = {
      formatting = treefmtEval.config.build.check self;
    };
  }
)
// {
  overlays = import ./overlays { inherit inputs; };
}
