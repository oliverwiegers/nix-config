{...}: {
  imports = [
    ./hardware.nix

    ../../../modules/nixos
    ../../../modules/nix_settings.nix
  ];

  #
  # Custom modules
  #
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

  #
  # NixOS Settings
  #
  networking = {
    hostname = "enigma";

    wireless = {
      enable = true;
      interfaces = ["wlp3s0"];

      networks = {
        Follow-The-Wires-5ghz = {
          pskRaw = "21e2dd18b60e3b63ab9d0eaa30f6e1e54f88df7b52785bfa9aadb0c720e9c224";
        };
        WIFIonICE = {};
        "Motel One Guest Wi-Fi" = {};
      };
    };
  };
}
