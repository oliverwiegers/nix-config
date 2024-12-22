{...}: {
  imports = [
    ./hardware.nix
    ./disk-config.nix

    ../../../modules/nixos
    ../../../modules/nix_settings.nix
  ];

  #
  # Custom modules
  #
  server = {
    enable = true;
  };

  nixFeatures = {
    enable = true;
    allowUnfree = true;
  };

  #
  # NixOS Settings
  #
  networking = {
    hostname = "dudek";
  };
}
