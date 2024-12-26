############################################
############################################
#                                          #
# This file only defines flake inputs.     #
# Actual logic is located in ./default.nix #
#                                          #
############################################
############################################
{
  description = "Nix configuration.";

  inputs = {
    #     ____                                   __
    #    / __ \___  ______________  ____  ____ _/ /
    #   / /_/ / _ \/ ___/ ___/ __ \/ __ \/ __ `/ /
    #  / ____/  __/ /  (__  ) /_/ / / / / /_/ / /
    # /_/    \___/_/  /____/\____/_/ /_/\__,_/_/

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

    #    ______                           __
    #   / ____/__  ____  ___  _________ _/ /
    #  / / __/ _ \/ __ \/ _ \/ ___/ __ `/ /
    # / /_/ /  __/ / / /  __/ /  / /_/ / /
    # \____/\___/_/ /_/\___/_/   \__,_/_/

    # Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # home-manager.
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Firefox addons.
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
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

    #     _   ___      ____  _____
    #    / | / (_)  __/ __ \/ ___/
    #   /  |/ / / |/_/ / / /\__ \
    #  / /|  / />  </ /_/ /___/ /
    # /_/ |_/_/_/|_|\____//____/

    # Disko disk partitioning
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };

    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    #                          ____  _____
    #    ____ ___  ____ ______/ __ \/ ___/
    #   / __ `__ \/ __ `/ ___/ / / /\__ \
    #  / / / / / / /_/ / /__/ /_/ /___/ /
    # /_/ /_/ /_/\__,_/\___/\____//____/

    # nix-darwin.
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Firefox overlay. Because nixpkgs package is broken on darwin.
    nixpkgs-firefox-darwin = {
      url = "github:bandithedoge/nixpkgs-firefox-darwin";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Homebrew.
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Declarative tap management for homebrew.
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };

    # Declarative tap management for homebrew.
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

  outputs = inputs: import ./. inputs;
}
