{
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.workstation.laptop;
in
{
  config = mkIf cfg.enable {
    # Laptop power managent.
    powerManagement.enable = true;

    services = {
      logind = {
        lidSwitchDocked = "suspend";
      };

      auto-cpufreq = {
        enable = true;
        settings = {
          battery = {
            governor = "powersave";
            turbo = "never";
          };

          charger = {
            governor = "performance";
            turbo = "auto";
          };
        };
      };
    };
  };
}
