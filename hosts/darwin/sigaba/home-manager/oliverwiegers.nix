{
  lib,
  config,
  pkgs,
  inputs,
  outputs,
  helpers,
  ...
}:
with helpers; {
  imports = [
    ../../../../modules/home-manager
  ];

  home = {
    username = "oliver.wiegers";
    homeDirectory = "/Users/oliver.wiegers";
    stateVersion = "23.05";

    activation = {
      copyApplications = let
        apps = pkgs.buildEnv {
          name = "home-manager-applications";
          paths = config.home.packages;
          pathsToLink = "/Applications";
        };
      in
        lib.hm.dag.entryAfter ["writeBoundary"] ''
          baseDir="$HOME/Applications/Home Manager Apps"
          if [ -d "$baseDir" ]; then
            rm -rf "$baseDir"
          fi
          mkdir -p "$baseDir"
          for appFile in ${apps}/Applications/*; do
            target="$baseDir/$(basename "$appFile")"
            $DRY_RUN_CMD cp ''${VERBOSE_ARG:+-v} -fHRL "$appFile" "$baseDir"
            $DRY_RUN_CMD chmod ''${VERBOSE_ARG:+-v} -R +w "$target"
          done
        '';
    };
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays ++ [inputs.nixpkgs-firefox-darwin.overlay];
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  os.darwin = enabled;

  terminal = {
    shell.zsh = enabled;

    emulator = {
      alacritty = {
        enable = true;
        font.size = 15;
      };
    };

    programs = {
      bat = enabled;
      btop = enabled;
      direnv = enabled;
      fzf = enabled;
      home-manager = enabled;
      newsboat = enabled;
      nix = enabled;
      terraform = enabled;
      tmux = enabled;
      github = enabled;
      rust = enabled;
      k8s-cli = enabled;

      ssh = {
        enable = true;
        matchBlocks = {
          jumphost = {
            user = "wiegers";
            hostname = "aptdater03.infra.netlogix-ws.cust.nlxnet.de";
            extraOptions = {
              RequestTTY = "yes";
              RemoteCommand = "tmux -L tmux new-session -As hacktheplanet";
            };
          };

          mail = {
            user = "root";
            hostname = "152.53.49.50";
          };
        };
      };

      git = {
        enable = true;
        extraConfig = {
          user = {
            email = "oliver.wiegers@netlogix.de";
            name = "oliverwiegers";
            signingkey = "7DE42A84CF1FCCEC4EB9CAE8AFF11CB49BACA5D6";
          };
          commit = {
            gpgsign = true;
          };
          gpg = {
            program = "gpg2";
          };
          init = {
            defaultBranch = "main";
          };
          "protocol \"http\"" = {
            allow = "never";
          };
          "protocol \"git\"" = {
            allow = "never";
          };
          difftool = {
            trustExitCode = true;
          };
          diff = {
            tool = "vimdiff";
          };
        };
      };
    };
  };

  graphical = {
    browser = {
      firefox = {
        enable = true;
        package = pkgs.firefox-bin;
      };
    };
  };
}
