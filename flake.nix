{
  description = "Nix configuration.";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix User Repository.
    nur = {
      url = "github:nix-community/NUR";
    };

    # Firefox addons.
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # My own Neovim flake.
    flim = {
      url = "github:oliverwiegers/flim";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-hardware,
    ...
  } @ inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;

    systems = [
      "x86_64-linux"
    ];

    forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
    pkgsFor = lib.genAttrs systems (system:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      });
  in {
    inherit lib;
    devShells = forEachSystem (pkgs: import ./shell.nix {inherit pkgs;});
    formatter = forEachSystem (pkgs: pkgs.alejandra);

    overlays = import ./overlays {inherit inputs outputs;};

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      enigma = lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/enigma/configuration.nix

          nixos-hardware.nixosModules.common-cpu-amd
          nixos-hardware.nixosModules.common-gpu-amd
        ];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      "oliverwiegers@enigma" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [./home/enigma/oliverwiegers.nix];
      };
    };
  };
}
