{
  lib,
  config,
  self,
  ...
}:
let
  cfg = config.acmeDefaults;
in
{
  imports = [
    ./sops-defaults.nix
  ];

  options.acmeDefaults = {
    enable = lib.mkEnableOption "ACME settings.";
  };

  config = lib.mkIf cfg.enable {
    sopsDefaults.enable = true;

    security = {
      acme = {
        acceptTerms = true;

        defaults = {
          email = "security@oliverwiegers.com";
          group = "certs";
          dnsProvider = "desec";
          dnsResolver = "ns1.desec.io:53";
          credentialFiles = {
            DESEC_TOKEN_FILE = config.sops.secrets.desec.path;
          };
          extraLegoFlags = [
            "--dns.propagation-wait"
            "300s"
          ];
        };
      };
    };

    sops.secrets.desec = {
      sopsFile = "${self}/secrets.yaml";
    };
  };
}
