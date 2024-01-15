{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.workstation.wifi;
in {
  config = mkIf cfg.enable {
    networking = {
      hostName = "enigma";
      enableIPv6 = false;
      firewall = {
        enable = false;
      };

      wireless = {
        enable = true;
        interfaces = ["wlp3s0"];

        networks = {
          Follow-The-Wires-5ghz = {
            pskRaw = "21e2dd18b60e3b63ab9d0eaa30f6e1e54f88df7b52785bfa9aadb0c720e9c224";
          };
          WIFIonICE = {};
        };
      };

      networkmanager = {
        enable = false;
      };
    };
  };
}
