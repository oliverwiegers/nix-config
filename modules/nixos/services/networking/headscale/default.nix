{
  lib,
  self,
  config,
  inputs,
  ...
}: let
  cfg = config.headscale;
in {
  options.headscale = {
    enable = lib.mkEnableOption "Headscale server.";

    secretsFile = lib.mkOption {
      description = "Path to secrets.yaml for nix-sops containing headscale secrets.";
      type = lib.types.path;
      default = null;
      defaultText = "consul.secretsFile = null;";
      example = "consul.secretsFile = ./secrets/foo.yaml;";
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [];

    networking.nat = {
      enable = true;
      internalInterfaces = ["ve-+"];
      externalInterface = "enp1s0";
    };

    containers = {
      # headscale = {
      # };

      test = {
        autoStart = true;
        privateNetwork = true;
        hostAddress = "128.140.58.255";
        localAddress = "10.0.0.3";
        ephemeral = true;

        config = {
          pkgs,
          lib,
          ...
        }: {
          environment.systemPackages = [pkgs.postgresql pkgs.curl];

          services.resolved.enable = true;

          networking = {
            # Use systemd-resolved inside the container
            # Workaround for bug https://github.com/NixOS/nixpkgs/issues/162686
            useHostResolvConf = lib.mkForce false;
          };
        };
      };

      headscale-db = {
        autoStart = true;
        privateNetwork = true;
        hostAddress = "128.140.58.255";
        localAddress = "10.0.0.2";
        ephemeral = true;

        config = {pkgs, ...}: {
          imports = [
            "${self}/modules/nixos/acme-defaults.nix"
            "${self}/modules/nixos/sops-defaults.nix"
            inputs.sops-nix.nixosModules.sops
          ];

          acmeDefaults.enable = true;
          sopsDefaults.enable = true;

          sops = {
            secrets = {
              "headscale/dbuser" = {
                sopsFile = cfg.secretsFile;
                owner = "postgres";
              };
            };
          };

          systemd.services = {
            postgresql.postStart = let
              passwordFile = config.sops.secrets."headscale/dbuser".path;
            in ''
              $PSQL -tA <<'EOF'
                DO $$
                DECLARE password TEXT;
                BEGIN
                  password := trim(both from replace(pg_read_file('${passwordFile}'), E'\n', '''));
                  EXECUTE format('ALTER ROLE headscale WITH PASSWORD '''%s''';', password);
                END $$;
              EOF
            '';
          };

          services = {
            postgresql = {
              enable = true;
              enableTCPIP = true;

              ensureUsers = [
                {
                  name = "headscale";
                  ensureClauses.login = true;
                  ensureDBOwnership = true;
                }
              ];

              ensureDatabases = [
                "headscale"
              ];

              authentication = pkgs.lib.mkOverride 10 ''
                #type database DBuser origin-address auth-method
                host  headscale      headscale     10.0.0.2/32   password
              '';
            };

            postgresqlBackup = {
              enable = true;
              databases = [
                "headscale"
              ];
            };
          };

          services.resolved.enable = true;

          networking = {
            # Use systemd-resolved inside the container
            # Workaround for bug https://github.com/NixOS/nixpkgs/issues/162686
            useHostResolvConf = lib.mkForce false;
          };

          networking.firewall = {
            enable = true;
            allowedTCPPorts = [5432];
          };
        };
      };
    };
  };
}
