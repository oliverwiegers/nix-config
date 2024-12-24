{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.terminal.programs.terraform;
in {
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      terraform
      tflint
      terraform-docs
      terragrunt
      s3cmd
    ];
  };
}
