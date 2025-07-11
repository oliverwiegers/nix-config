# Shell for bootstrapping flake-enabled nix and other tooling
{
  pkgs ?
    # If pkgs is not defined, instantiate nixpkgs from locked commit
    let
      lock = (builtins.fromJSON (builtins.readFile ./flake.lock)).nodes.nixpkgs.locked;
      nixpkgs = fetchTarball {
        url = "https://github.com/nixos/nixpkgs/archive/${lock.rev}.tar.gz";
        sha256 = lock.narHash;
      };
    in
    import nixpkgs {
      overlays = [ ];
    },
  ...
}:
{
  default = pkgs.mkShellNoCC {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes";
    nativeBuildInputs = with pkgs; [
      git
      pre-commit
      ruby
      deadnix
      statix
      flake-checker
      deploy-rs
      sops
      wget
      nixos-anywhere
      ssh-to-age

      # Terraform
      opentofu
      tflint
      terraform-docs
      s3cmd
    ];
  };
}
