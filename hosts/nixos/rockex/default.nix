{
  config,
  helpers,
  inputs,
  rootDir,
  ...
}:
with helpers; {
  imports = [
    ./hardware.nix
    ./disk-config.nix

    inputs.sops-nix.nixosModules.sops
    inputs.disko.nixosModules.disko
  ];

  #    ______           __                     __  ___          __      __
  #   / ____/_  _______/ /_____  ____ ___     /  |/  /___  ____/ /_  __/ /__  _____
  #  / /   / / / / ___/ __/ __ \/ __ `__ \   / /|_/ / __ \/ __  / / / / / _ \/ ___/
  # / /___/ /_/ (__  ) /_/ /_/ / / / / / /  / /  / / /_/ / /_/ / /_/ / /  __(__  )
  # \____/\__,_/____/\__/\____/_/ /_/ /_/  /_/  /_/\____/\__,_/\__,_/_/\___/____/

  nixSettings = enabled;
  acmeDefaults = enabled;
  sopsDefaults = enabled;

  tailscale = {
    enable = true;
    authKeyFile = config.sops.secrets."headscale/preauthkey".path;
  };

  serverBase = {
    enable = true;

    fancyMotd.extraServices = ''
    '';
  };

  consul = {
    enable = true;
    type = "server";
    bindAddr = "100.64.0.1";
    uiBindAddr = "100.64.0.1";
    clientSecretsFile = "${rootDir}/secrets.yaml";
    serverSecretsFile = ./secrets.yaml;
  };

  #     _   ___      ____  _____
  #    / | / (_)  __/ __ \/ ___/
  #   /  |/ / / |/_/ / / /\__ \
  #  / /|  / />  </ /_/ /___/ /
  # /_/ |_/_/_/|_|\____//____/

  #   ________    _          __   ____             __
  #  /_  __/ /_  (_)________/ /  / __ \____ ______/ /___  __
  #   / / / __ \/ / ___/ __  /  / /_/ / __ `/ ___/ __/ / / /
  #  / / / / / / / /  / /_/ /  / ____/ /_/ / /  / /_/ /_/ /
  # /_/ /_/ /_/_/_/   \__,_/  /_/    \__,_/_/   \__/\__, /
  #                                                /____/

  sops = {
    defaultSopsFile = ./secrets.yaml;

    secrets = {
      "headscale/preauthkey" = {};
    };
  };
}
