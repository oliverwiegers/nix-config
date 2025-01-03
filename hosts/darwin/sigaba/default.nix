{
  lib,
  inputs,
  helpers,
  ...
}:
with lib // helpers; {
  imports = [
    ../../../modules/darwin
    ../../../modules/nix_settings.nix
  ];

  #    ______           __                     __  ___          __      __
  #   / ____/_  _______/ /_____  ____ ___     /  |/  /___  ____/ /_  __/ /__  _____
  #  / /   / / / / ___/ __/ __ \/ __ `__ \   / /|_/ / __ \/ __  / / / / / _ \/ ___/
  # / /___/ /_/ (__  ) /_/ /_/ / / / / / /  / /  / / /_/ / /_/ / /_/ / /  __(__  )
  # \____/\__,_/____/\__/\____/_/ /_/ /_/  /_/  /_/\____/\__,_/\__,_/_/\___/____/

  wm.yabai = enabled;

  nixFeatures = {
    enable = true;
    allowUnfree = true;
  };

  #           _                __                    _
  #    ____  (_)  __      ____/ /___ _______      __(_)___
  #   / __ \/ / |/_/_____/ __  / __ `/ ___/ | /| / / / __ \
  #  / / / / />  </_____/ /_/ / /_/ / /   | |/ |/ / / / / /
  # /_/ /_/_/_/|_|      \__,_/\__,_/_/    |__/|__/_/_/ /_/

  services.nix-daemon.enable = true;

  # TODO: Checkout https://nixcademy.com/posts/macos-linux-builder/
  # Put this stuff into a module
  nix = {
    linux-builder.enable = true;
    settings.trusted-users = ["@admin"];
  };

  system = {
    #stateVersion = 5;
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
        wvous-tl-corner = 1;
        wvous-tr-corner = 1;
        wvous-bl-corner = 1;
        wvous-br-corner = 1;
      };
    };

    keyboard = {
      # Check for this issue when zsh autosuggest binding on ctrl+space is not working:
      # https://github.com/zsh-users/zsh-autosuggestions/issues/132#issuecomment-491248596
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
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
      #"microsoft-office"
      #"microsoft-teams"
      #"microsoft-outlook"
    ];
  };
}
