{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.terminal.programs.github;
in
{
  config = mkIf cfg.enable {
    programs = {
      gh = {
        enable = true;
        extensions = with pkgs; [
          gh-actions-cache
          gh-eco
          gh-markdown-preview
          gh-dash
        ];

        settings = {
          git_protocol = "ssh";
        };
      };
    };
  };
}
