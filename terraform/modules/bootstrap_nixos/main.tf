module "system-build" {
  source = "github.com/nix-community/nixos-anywhere//terraform/nix-build?ref=1.11.0"

  attribute = "${path.root}/../nix/#nixosConfigurations.${var.hostname}.config.system.build.toplevel"
}

module "disko" {
  source = "github.com/nix-community/nixos-anywhere//terraform/nix-build?ref=1.11.0"

  attribute = "${path.root}/../nix/#nixosConfigurations.${var.hostname}.config.system.build.diskoScript"
}

module "install" {
  source = "github.com/nix-community/nixos-anywhere//terraform/install?ref=1.11.0"

  nixos_system       = module.system-build.result.out
  nixos_partitioner  = module.disko.result.out
  target_host        = var.host
  extra_files_script = "${path.root}/../scripts/prepare_ssh_host_keys.sh"
  instance_id        = var.instance_id

  extra_environment = {
    CI          = "true"
    TARGET_HOST = var.hostname
  }
}
