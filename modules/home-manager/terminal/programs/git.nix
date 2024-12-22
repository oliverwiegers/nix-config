{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.terminal.programs.git;
in {
  config = mkIf cfg.enable {
    programs = {
      git = {
        enable = true;
        inherit (cfg) extraConfig;

        diff-so-fancy = {
          enable = true;
          changeHunkIndicators = true;
          stripLeadingSymbols = false;
        };
      };
    };
  };
}
