{
  inputs,
  outputs,
  lib,
  config,
  ...
}: {
  imports = [
    ../modules/darwin
  ];

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    hostPlatform = "aarch64-darwin";

    config = {
      allowUnfree = true;
    };
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = false; #TODO: Deactivate for now
      warn-dirty = false;
    };
  };

  services.nix-daemon.enable = true;

  system = {
    defaults = {
      NSGlobalDomain = {
        KeyRepeat = 2;
        InitialKeyRepeat = 15;

        _HIHideMenuBar = true;

        "com.apple.swipescrolldirection" = false;
        "com.apple.keyboard.fnState" = true;
        "com.apple.sound.beep.feedback" = 0;
        "com.apple.sound.beep.volume" = 0.000;
      };

      dock = {
        autohide = true;
        orientation = "right";
        mru-spaces = false;
      };
    };

    keyboard = {
      # Check for this issue when zsh autosuggest binding on ctrl+space is not working:
      # https://github.com/zsh-users/zsh-autosuggestions/issues/132#issuecomment-491248596
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
  };

  networking = {
    hostName = "sigaba";
    localHostName = "sigaba";
  };

  programs.zsh.enable = true;

  nix-homebrew = {
    enable = true;
    user = "oliver.wiegers";
    enableRosetta = true;
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      # Needed to use nix-darwins homebrew module when mutableTaps = false is set.
      "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
    };
    # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
    mutableTaps = false;
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
    };
    brews = [
      "blueutil"
    ];
    casks = [
      "caffeine"
      "docker"
      "appcleaner"
      "amethyst"
      #"microsoft-office"
      #"microsoft-teams"
      #"microsoft-outlook"
    ];
  };

  wm.yabai.enable = true;
}
