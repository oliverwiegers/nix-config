{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.os.darwin;
in {
  config = mkIf cfg.enable {
    home.packages = with pkgs.unstable; [
      gnupg
      ruby
      sshuttle
      gnutar
      wget
      ipcalc
    ];
  };
}
