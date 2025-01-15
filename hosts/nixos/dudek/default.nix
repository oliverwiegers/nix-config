{
  pkgs,
  helpers,
  ...
}:
with helpers; {
  imports = [
    ./hardware.nix
    ./disk-config.nix

    ../../../modules/nixos
    ../../../modules/nix_settings.nix
  ];

  #    ______           __                     __  ___          __      __
  #   / ____/_  _______/ /_____  ____ ___     /  |/  /___  ____/ /_  __/ /__  _____
  #  / /   / / / / ___/ __/ __ \/ __ `__ \   / /|_/ / __ \/ __  / / / / / _ \/ ___/
  # / /___/ /_/ (__  ) /_/ /_/ / / / / / /  / /  / / /_/ / /_/ / /_/ / /  __(__  )
  # \____/\__,_/____/\__/\____/_/ /_/ /_/  /_/  /_/\____/\__,_/\__,_/_/\___/____/

  base.timeZone = "Europe/Vienna";
  nixSettings = enabled;
  serverBase = enabled;

  mailServer = {
    enable = true;
    domains = ["oliverwiegers.com"];
    subDomain = "mail";
    secretsFile = ./secrets.yaml;

    #backup = {
    #  enable = true;
    #  target = "/var/backups/restic/";
    #};
  };

  #     _   ___      ____  _____
  #    / | / (_)  __/ __ \/ ___/
  #   /  |/ / / |/_/ / / /\__ \
  #  / /|  / />  </ /_/ /___/ /
  # /_/ |_/_/_/|_|\____//____/
  environment = {
    systemPackages = with pkgs; [
      postgresql
      restic
    ];
  };

  #   ________    _          __   ____             __
  #  /_  __/ /_  (_)________/ /  / __ \____ ______/ /___  __
  #   / / / __ \/ / ___/ __  /  / /_/ / __ `/ ___/ __/ / / /
  #  / / / / / / / /  / /_/ /  / ____/ /_/ / /  / /_/ /_/ /
  # /_/ /_/ /_/_/_/   \__,_/  /_/    \__,_/_/   \__/\__, /
  #                                                /____/
}
