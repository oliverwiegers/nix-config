{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.terminal.programs.nix;
in
{
  config = mkIf cfg.enable {
    nix = {
      package = lib.mkDefault pkgs.nix;
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        warn-dirty = false;
      };
    };

    programs = {
      nix-index = {
        enable = true;
        enableZshIntegration = true;
      };
    };
  };
}
