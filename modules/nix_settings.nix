{
  lib,
  config,
  inputs,
  outputs,
  ...
}:
with lib; let
  cfg = config.nixSettings;
in {
  options = {
    nixSettings = {
      enable = mkEnableOption "Enable custom Nix / nixpkgs settings.";

      allowUnfree = mkOption {
        type = types.bool;
        default = true;
        defaultText = "true";
        example = "nixSettings.allowUnfree = true;";
        description = "Allow unfree packages.";
      };
    };
  };

  config = mkIf cfg.enable {
    nixpkgs = {
      overlays = builtins.attrValues outputs.overlays;

      config = {
        inherit (cfg) allowUnfree;
      };
    };

    nix = {
      # This will add each flake input as a registry
      # To make nix3 commands consistent with your flake
      registry = mkDefault (mapAttrs (_: value: {flake = value;}) inputs);

      # This will additionally add your inputs to the system's legacy channels
      # Making legacy nix commands consistent as well.
      nixPath = mapAttrsToList (n: _: "${n}=flake:${n}") inputs;

      # Disable channels.
      channel.enable = false;

      settings = {
        # Enable flakes and new 'nix' command
        experimental-features = "nix-command flakes";
        # Deduplicate and optimize nix store
        auto-optimise-store = false; #TODO: Deactivate for now
        warn-dirty = false;
        # Workaround for https://github.com/NixOS/nix/issues/9574
        nix-path = config.nix.nixPath;
        allow-import-from-derivation = true;
      };

      gc = {
        automatic = true;
        options = "--delete-older-than 7d";
      };
    };
  };
}
