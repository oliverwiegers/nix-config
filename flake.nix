{
  description = "Nix configuration.";

  inputs = {
    # Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager.
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
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
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Homebrew
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
      inputs.nixpkgs.follows = "nixpkgs";
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
    nixos-hardware,
    nix-homebrew,
    homebrew-core,
    homebrew-cask,
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

    overlays = import ./overlays {inherit inputs outputs;};

    nixosConfigurations = {
      enigma = lib.nixosSystem {
        specialArgs = {inherit inputs outputs myLib;};
        modules = [
          ./nixos/enigma.nix

          nixos-hardware.nixosModules.common-cpu-amd
          nixos-hardware.nixosModules.common-gpu-amd
        ];
      };
    };

    darwinConfigurations = {
      sigaba = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {inherit inputs outputs myLib;};
        modules = [
          ./darwin/sigaba.nix

          nix-homebrew.darwinModules.nix-homebrew
        ];
      };
    };

    homeConfigurations = {
      "oliverwiegers@enigma" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs myLib;};
        modules = [./home-manager/enigma/oliverwiegers.nix];
      };

      "oliver.wiegers@sigaba" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsFor.aarch64-darwin;
        extraSpecialArgs = {inherit inputs outputs myLib;};
        modules = [./home-manager/sigaba/oliverwiegers.nix];
      };
    };
  };
}
