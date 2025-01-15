{helpers, ...}:
with helpers; {
  imports = [
    ./hardware.nix

    ../../../modules/nixos
    ../../../modules/nix_settings.nix
  ];

  #    ______           __                     __  ___          __      __
  #   / ____/_  _______/ /_____  ____ ___     /  |/  /___  ____/ /_  __/ /__  _____
  #  / /   / / / / ___/ __/ __ \/ __ `__ \   / /|_/ / __ \/ __  / / / / / _ \/ ___/
  # / /___/ /_/ (__  ) /_/ /_/ / / / / / /  / /  / / /_/ / /_/ / /_/ / /  __(__  )
  # \____/\__,_/____/\__/\____/_/ /_/ /_/  /_/  /_/\____/\__,_/\__,_/_/\___/____/

  workstation = {
    enable = true;

    audio = enabled;
    bluetooth = enabled;
    laptop = enabled;
    virtualization = enabled;
    wifi = enabled;
    wm = enabled;
  };

  nixSettings = enabled;

  base.stateVersion = "23.11";

  #     _   ___      ____  _____
  #    / | / (_)  __/ __ \/ ___/
  #   /  |/ / / |/_/ / / /\__ \
  #  / /|  / />  </ /_/ /___/ /
  # /_/ |_/_/_/|_|\____//____/

  networking = {
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
