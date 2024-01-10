{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.workstation.bluetooth;
in {
  config = mkIf cfg.enable {
    hardware = {
      bluetooth = {
        enable = true;
        powerOnBoot = true;
      };
    };
  };
}
