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
  nixpkgs-unstable,
  home-manager,
  disko,
  nixos-hardware,
  nix-homebrew,
  nix-darwin,
  ...
} @ inputs: let
  inherit (self) outputs;
  lib = nixpkgs.lib // home-manager.lib;
  myLib = import ./lib {inherit lib;};

  systems = [
    "x86_64-linux"
    "aarch64-darwin"
  ];

  forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
  pkgsFor = lib.genAttrs systems (system:
    import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    });
in {
  inherit lib;
  devShells = forEachSystem (pkgs: import ./shell.nix {inherit pkgs;});
  formatter = forEachSystem (pkgs: pkgs.alejandra);

  overlays = import ./overlays {inherit inputs;};

  nixosConfigurations = {
    enigma = lib.nixosSystem {
      specialArgs = {inherit inputs outputs myLib;};
      modules = [
        ./hosts/nixos/enigma

        nixos-hardware.nixosModules.common-cpu-amd
        nixos-hardware.nixosModules.common-gpu-amd
      ];
    };

    dudek = lib.nixosSystem {
      specialArgs = {inherit inputs outputs myLib;};
      modules = [
        ./hosts/nixos/dudek

        disko.nixosModules.disko
      ];
    };
  };

  darwinConfigurations = {
    sigaba = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      specialArgs = {inherit inputs outputs myLib;};
      modules = [
        ./hosts/darwin/sigaba

        nix-homebrew.darwinModules.nix-homebrew
        {
          nix.registry.nixpkgs.flake = nixpkgs-unstable;
          system.stateVersion = 5;
        }
      ];
    };
  };

  homeConfigurations = {
    "oliverwiegers@enigma" = home-manager.lib.homeManagerConfiguration {
      pkgs = pkgsFor.x86_64-linux;
      extraSpecialArgs = {inherit inputs outputs myLib;};
      modules = [./hosts/nixos/enigma/home-manager/oliverwiegers.nix];
    };

    "oliver.wiegers@sigaba" = home-manager.lib.homeManagerConfiguration {
      pkgs = pkgsFor.aarch64-darwin;
      extraSpecialArgs = {inherit inputs outputs myLib;};
      modules = [./hosts/darwin/sigaba/home-manager/oliverwiegers.nix];
    };
  };
}
