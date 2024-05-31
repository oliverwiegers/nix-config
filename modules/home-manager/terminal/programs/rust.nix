{
  lib,
  pkgs,
  inputs,
  config,
  ...
}:
with lib; let
  cfg = config.terminal.programs.rust;
in {
  config = mkIf cfg.enable {
     nixpkgs.overlays = [ inputs.fenix.overlays.default ];
     home.packages = with pkgs; [
      (inputs.fenix.packages.${system}.complete.withComponents [
        "cargo"
        "clippy"
        "rust-src"
        "rustc"
        "rustfmt"
      ])
      rust-analyzer-nightly
    ];
  };
}
