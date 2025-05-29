{
  config,
  ...
}: {
  config = {
    security = {
      acme = {
        acceptTerms = true;

        defaults = {
          email = "security@oliverwiegers.com";
          group = "acme";
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
  };
}
