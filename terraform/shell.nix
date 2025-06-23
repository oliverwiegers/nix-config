# If you're not using nix you won't neec this file.
# If you're curious ask Olli of read for yourself here:
# https://nixos.wiki/wiki/Development_environment_with_nix-shell

let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-unstable";
  pkgs = import nixpkgs {
    config = { };
    overlays = [ ];
  };
in
pkgs.mkShellNoCC {
  packages = with pkgs; [
    # General dev tools.
    git
    pre-commit
    ruby
    # Terraform
    opentofu
    tflint
    terraform-docs
    s3cmd

    # Secrets
    sops
  ];
}
