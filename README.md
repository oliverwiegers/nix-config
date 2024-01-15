# Nix Configuration

## Setup

### NixOS

- Boot Live disk.
- Format disk.
  - Eventually tweak `hosts/<hostname>/configuration.nix`.
- Run `nixos-rebuild switch --flake "github:oliverwiegers/nix-config#<host>`.
- Reboot host.
- Run `nix run nixpkgs#home-manager.out -- switch --flake .#<username>@<host>`

### MacOS

```bash
# Install Nix
sh <(curl -L https://nixos.org/nix/install) --daemon

# Create project home and clone repository.
mkdir ~/Documents/projects && cd ~/Documents/projects
nix run nixpkgs#git.out -- clone git@github.com:oliverwiegers/nix-config

# Setup home-manager.
nix run nixpkgs#home-manager.out -- switch --flake .#oliverwiegers@enigma
```

## Update System

```bash
cd <repo-folder>
nix flake update
sudo nixos-rebuild switch --flake .#<hostname>
home-manager switch --flake .#<hostname>@<user>
```

## Links

- [Setup home-manager using flakes](https://nix-community.github.io/home-manager/index.html#sec-flakes-standalone)
- [Nix starter config](https://github.com/Misterio77/nix-starter-configs)
- [Nix flake templates](https://github.com/NixOS/templates/tree/master)
- [Search home-manager modules](https://mipmip.github.io/home-manager-option-search/?query=programs.zsh)
- [Search nix packages / NixOS options](https://search.nixos.org/packages)

## FAQ

- **Q:** Why can't flake find existing file?
  **A:** Because it isn't added to git. See [here](https://discourse.nixos.org/t/flake-based-home-manager-cannot-find-home-nix/18356).
