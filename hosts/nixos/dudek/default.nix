{
  # pkgs,
  # config,
  # helpers,
  inputs,
  # self,
  ...
}:
# let
  # domain = "oliverwiegers.com";
  # domainInternal = "oliverwiegers.de";
  # headscaleFQDN = "vpn.${domain}";
  # localHeadscaleURI = "${toString config.services.headscale.address}:${toString config.services.headscale.port}";
  # headscaleURI = "https://${headscaleFQDN}:443";
# in {
{
  imports = [
    ./hardware.nix
    ./disk-config.nix

    inputs.disko.nixosModules.disko
  ];

  #    ______           __                     __  ___          __      __
  #   / ____/_  _______/ /_____  ____ ___     /  |/  /___  ____/ /_  __/ /__  _____
  #  / /   / / / / ___/ __/ __ \/ __ `__ \   / /|_/ / __ \/ __  / / / / / _ \/ ___/
  # / /___/ /_/ (__  ) /_/ /_/ / / / / / /  / /  / / /_/ / /_/ / /_/ / /  __(__  )
  # \____/\__,_/____/\__/\____/_/ /_/ /_/  /_/  /_/\____/\__,_/\__,_/_/\___/____/

  #nixSettings = enabled;
  #acmeDefaults = enabled;
  #sopsDefaults = enabled;

  #tailscale = {
  #  enable = true;
  #  authKeyFile = config.sops.secrets."headscale/preauthkey".path;
  #};

  headscale = {
    enable = true;
  };

  #serverBase = {
  #  enable = true;

  #  fancyMotd.extraServices = ''
  #    services["nginx"]="Nginx"
  #    services["dovecot2"]="Dovecot"
  #    services["postfix"]="Postfix"
  #    services["opendkim"]="DKIM"
  #    services["redis-server"]="Redis"
  #    services["phpfpm-roundcube"]="Roundcube"
  #    services["radicale"]="Radicale"
  #    services["postgresql"]="PostgreSQL"
  #    services["headscale"]="Headscale"
  #  '';
  #};

  #mailServer = {
  #  enable = false;
  #  domains = [domain];
  #  subDomain = "mail";
  #  secretsFile = ./secrets.yaml;
  #};

  #consul = {
  #  enable = false;
  #  type = "server";
  #  #bindAddr = "100.64.0.3";
  #  #uiBindAddr = "100.64.0.3";
  #  clientSecretsFile = "${self}/secrets.yaml";
  #  serverSecretsFile = ./secrets.yaml;
  #};

  ##     _   ___      ____  _____
  ##    / | / (_)  __/ __ \/ ___/
  ##   /  |/ / / |/_/ / / /\__ \
  ##  / /|  / />  </ /_/ /___/ /
  ## /_/ |_/_/_/|_|\____//____/

  #services = {
  #  nginx = {
  #    enable = false;

  #    upstreams = {
  #      headscale.servers = {
  #        "${localHeadscaleURI}" = {};
  #      };

  #      consul.servers = {
  #        "100.64.0.1:8500" = {};
  #        "100.64.0.3:8500" = {};
  #        "100.64.0.4:8500" = {};
  #      };
  #    };

  #    virtualHosts = {
  #      "${headscaleFQDN}" = {
  #        forceSSL = true;
  #        enableACME = true;
  #        acmeRoot = null; # Needed for DNS challenge to work.
  #        locations."/" = {
  #          proxyPass = "http://headscale";
  #          proxyWebsockets = true;
  #        };
  #      };

  #      "consul.${domainInternal}" = {
  #        forceSSL = true;
  #        enableACME = true;
  #        acmeRoot = null; # Needed for DNS challenge to work.
  #        locations."/" = {
  #          proxyPass = "http://consul";
  #          proxyWebsockets = true;
  #        };
  #      };
  #    };
  #  };

  #  # headscale = let
  #  #   certDir = config.security.acme.certs.${headscaleFQDN}.directory;
  #  # in {
  #  #   enable = true;

  #  #   settings = {
  #  #     tls_key_path = certDir + "/key.pem";
  #  #     tls_chain_path = certDir + "/fullchain.pem";
  #  #     server_url = "http://${localHeadscaleURI}";

  #  #     dns = {
  #  #       search_domains = [domainInternal];
  #  #       base_domain = domainInternal;
  #  #     };

  #  #     database = {
  #  #       type = "postgres";

  #  #       postgres = {
  #  #         user = "headscale";
  #  #         name = "headscale";
  #  #         host = "127.0.0.1";
  #  #         port = 5432;
  #  #         password_file = config.sops.secrets."headscale/dbuser".path;
  #  #       };
  #  #     };
  #  #   };

  #  #   extraSettings = {
  #  #     dns.extra_records = [
  #  #       {
  #  #         name = "consul.${domainInternal}";
  #  #         type = "A";
  #  #         value = "100.64.0.3";
  #  #       }
  #  #     ];
  #  #   };
  #  # };

  #  postgresql = {
  #    enable = true;

  #    ensureUsers = [
  #      {
  #        name = "headscale";
  #        ensureClauses.login = true;
  #        ensureDBOwnership = true;
  #      }
  #    ];

  #    ensureDatabases = [
  #      "headscale"
  #    ];
  #  };

  #  postgresqlBackup = {
  #    enable = true;
  #    databases = [
  #      "headscale"
  #    ];
  #  };

  #  restic = let
  #    services = {
  #      postgresql = {
  #        paths = ["/var/backup/postgresql"];
  #      };
  #    };
  #  in {
  #    backups = builtins.mapAttrs (name: settings: helpers.mkBackup name settings) services;
  #  };
  #};

  #users.groups = {
  #  keys.members = ["headscale" "postgres"];
  #  certs.members = ["headscale"];
  #};

  #systemd.services = {
  #  #headscale = {
  #  #  startLimitBurst = 5;
  #  #  startLimitIntervalSec = 100;

  #  #  wants = [
  #  #    "acme-${headscaleFQDN}.service"
  #  #    "postgresql.service"
  #  #  ];
  #  #};

  #  tailscaled-autoconnect = {
  #    after = ["headscale.service"];
  #    wants = ["headscale.service"];
  #  };

  #  postgresql.postStart = let
  #    passwordFile = config.sops.secrets."headscale/dbuser".path;
  #  in ''
  #    $PSQL -tA <<'EOF'
  #      DO $$
  #      DECLARE password TEXT;
  #      BEGIN
  #        password := trim(both from replace(pg_read_file('${passwordFile}'), E'\n', '''));
  #        EXECUTE format('ALTER ROLE headscale WITH PASSWORD '''%s''';', password);
  #      END $$;
  #    EOF
  #  '';
  #};

  #networking.firewall.allowedTCPPorts = [80 443];

  ##   ________    _          __   ____             __
  ##  /_  __/ /_  (_)________/ /  / __ \____ ______/ /___  __
  ##   / / / __ \/ / ___/ __  /  / /_/ / __ `/ ___/ __/ / / /
  ##  / / / / / / / /  / /_/ /  / ____/ /_/ / /  / /_/ /_/ /
  ## /_/ /_/ /_/_/_/   \__,_/  /_/    \__,_/_/   \__/\__, /
  ##                                                /____/

  #sops = {
  #  defaultSopsFile = ./secrets.yaml;

  #  secrets = {
  #    "headscale/dbuser" = {
  #      group = "keys";
  #      mode = "0440";
  #    };

  #    "headscale/preauthkey" = {};
  #    "restic/mail" = {};
  #    "restic/dkim" = {};
  #    "restic/radicale" = {};
  #    "restic/postgresql" = {};
  #  };
  #};
}
