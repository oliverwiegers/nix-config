{...}: {
  imports = [
    ./hardware.nix
    ./disk-config.nix

    ../../../modules/nixos
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
    hostName = "dudek";
  };
}
