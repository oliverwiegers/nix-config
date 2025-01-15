###########################################
###########################################
#                                         #
# Flake inputs are located in ./flake.nix #
#                                         #
###########################################
###########################################
{
  self,
  nixpkgs-unstable,
  home-manager,
  nix-darwin,
  deploy-rs,
  ...
} @ inputs: let
  inherit (self) outputs;

  pkgs = nixpkgs-unstable;
  lib = nix-darwin.lib // home-manager.lib // pkgs.lib;
  helpers = import ./lib {inherit lib;};

  systems = [
    "x86_64-linux"
    "aarch64-darwin"
  ];

  pkgsFor = lib.genAttrs systems (
    system:
      import pkgs {
        inherit system;
        config.allowUnfree = true;
      }
  );

  forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
in {
  devShells = forEachSystem (pkgs: import ./shell.nix {inherit pkgs;});
  formatter = forEachSystem (pkgs: pkgs.alejandra);
  overlays = import ./overlays {inherit inputs;};

  nixosConfigurations = helpers.mkHostConfigs {
    hostsDir = ./hosts/nixos;
    inherit inputs outputs helpers;
  };

  darwinConfigurations = helpers.mkHostConfigs {
    hostsDir = ./hosts/darwin;
    isLinux = false;
    inherit inputs outputs helpers;
  };

  deploy = {
    nodes = {
      dudek = {
        hostname = "mail.oliverwiegers.com";
        profiles.system = {
          path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.dudek;
        };
      };
    };

    sshUser = "root";
    remoteBuild = true;
  };

  homeConfigurations = {
    "oliverwiegers@enigma" = lib.homeManagerConfiguration {
      pkgs = pkgsFor.x86_64-linux;
      extraSpecialArgs = {inherit inputs outputs helpers;};
      modules = [./hosts/nixos/enigma/home-manager/oliverwiegers.nix];
    };

    "oliver.wiegers@sigaba" = lib.homeManagerConfiguration {
      pkgs = pkgsFor.aarch64-darwin;
      extraSpecialArgs = {inherit inputs outputs helpers;};
      modules = [./hosts/darwin/sigaba/home-manager/oliverwiegers.nix];
    };
  };
}
