{
  lib,
  config,
  ...
}:
let
  cfg = config.sopsDefaults;
in
{
  options.sopsDefaults = {
    enable = lib.mkEnableOption "sops-nix settings.";
  };

  config = lib.mkIf cfg.enable {
    sops.age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };
  };
}
