# Nix Configuration

## Setup

- Boot Live disk.
- Format disk.
  - Eventually tweak `hosts/<hostname>/configuration.nix`.
- Run `nixos-install --flake github.com:oliverwiegers/nix-config#<hostname>`.
- Reboot host.
- Run `nix run home-manager/master -- init --switch`
- Run `home-manager switch --flake "github.com:oliverwiegers/nix-config#<username>@<hostname>"`.

## Update System

```bash
cd <repo-folder>
nix flake update
sudo nixos-rebuild switch --flake .#enigma
home-manager switch --flake .#oliverwiegers@enigma
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
