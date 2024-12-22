{
  description = "Nix configuration.";

  inputs = {
    # Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager.
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Disko disk partitioning
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Firefox addons.
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # My own Neovim flake.
    flim = {
      url = "github:oliverwiegers/flim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # My own Tmux flake.
    tmuxist = {
      url = "github:oliverwiegers/tmuxist";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };

    # Rust toolchains.
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Krew
    krewfile = {
      url = "github:brumhard/krewfile";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    dagger = {
      url = "github:dagger/nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    #
    # MacOS related inputs.
    #

    # Nix Darwin.
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Firefox overlay. Because nixpkgs package is broken on darwin.
    nixpkgs-firefox-darwin = {
      url = "github:bandithedoge/nixpkgs-firefox-darwin";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Homebrew
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Declarative tap management for homebrew
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };

    # Declarative tap management for homebrew
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    # Declarative tap management for homebrew
    # Needed to use nix-darwins homebrew module.
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
  };

  outputs = {
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
  };
}
