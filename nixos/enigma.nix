{...}: {
  imports = [
    ../modules/nixos

    ../modules/nix_settings.nix
    ../modules/nixos/hardware/enigma.nix
  ];

  workstation = {
    enable = true;

    audio.enable = true;
    bluetooth.enable = true;
    laptop.enable = true;
    virtualization.enable = true;
    wifi.enable = true;
    wm.enable = true;
  };

  nixFeatures = {
    enable = true;
    allowUnfree = true;
  };
}
