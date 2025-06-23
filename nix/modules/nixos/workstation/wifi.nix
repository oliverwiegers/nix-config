{
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.workstation.wifi;
in
{
  config = mkIf cfg.enable {
    networking = {
      enableIPv6 = false;

      firewall = {
        enable = false;
      };

      networkmanager = {
        enable = false;
      };
    };
  };
}
