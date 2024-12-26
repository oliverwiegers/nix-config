{inputs, ...}: [
  inputs.nix-homebrew.darwinModules.nix-homebrew

  {
    nix.registry.nixpkgs.flake = inputs.nixpkgs-unstable;
    system.stateVersion = 5;
  }
]
