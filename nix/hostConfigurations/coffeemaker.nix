{
  config,
  lib,
  pkgs,
  ...
}:
# for configurable nixos modules see (note that many of them might be linux-only):
# https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/module-list.nix
#
# for configurable nix-darwin modules see
# https://github.com/LnL7/nix-darwin/blob/master/modules/module-list.nix
{
  users.users.arul = {
    name = "arul";
    home = "/Users/arul";
    shell = "/etc/profiles/per-user/arul/bin/fish";
  };

  documentation = {
    enable = true;
    doc.enable = true;
    info.enable = true;
    man.enable = true;
  };

  imports = [
    ./homebrew.nix
  ];

  system = {
    defaults = {
      dock = {
        autohide = true;
        minimize-to-application = true;
        mru-spaces = false;
        show-recents = false;
        orientation = "bottom";
        tilesize = 52;
      };
      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = false;
        ShowPathbar = true;
        FXEnableExtensionChangeWarning = false;
      };
      loginwindow = {
        GuestEnabled = false;
      };
      NSGlobalDomain = {
        AppleInterfaceStyleSwitchesAutomatically = true;
        AppleShowAllExtensions = true;
        "com.apple.trackpad.scaling" = 2.0;
        NSAutomaticSpellingCorrectionEnabled = false;
        InitialKeyRepeat = 15;
        KeyRepeat = 1;
      };
      alf = {
        globalstate = 1;
        stealthenabled = 1;
      };
    };
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 4;
  };

  security = {pam.enableSudoTouchIdAuth = true;};

  environment = {
    shells = with pkgs; [fish];
    pathsToLink = ["/share/fish"];
  };

  launchd.user.agents = {
    backup = {
      command = "/Users/arul/scripts/backup";
      environment = {
        HOME = "/Users/arul";
      };
      serviceConfig = {
        UserName = "arul";
        Label = "backup";
        StandardOutPath = "/Users/arul/Library/Logs/restic.log";
        StandardErrorPath = "/Users/arul/Library/Logs/restic.err.log";
        StartCalendarInterval = [
          {
            Hour = 6;
            Minute = 30;
          }
          {
            Hour = 22;
            Minute = 0;
          }
        ];
      };
    };
  };

  services = {
    # Auto upgrade nix package and the daemon service.
    nix-daemon.enable = true;
    yabai = import ./yabai;
    skhd = import ./skhd;
  };
  nix = {
    package = pkgs.nix;
    gc = {
      automatic = true;
      interval = {
        Day = 7;
        Hour = 3;
        Minute = 15;
      };
      options = "--delete-older-than 30d";
    };
    settings = {
      auto-optimise-store = false;
      trusted-users = ["root" "arul"];
    };
  };
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
      allowInsecure = false;
      allowUnsupportedSystem = false;
    };
    # overlays = [
    #   (self: super: {
    #     yabai = super.yabai.overrideAttrs (o: rec {
    #       version = "6.0.0";
    #       src = super.fetchzip {
    #         url = "https://github.com/koekeishiya/yabai/releases/download/v6.0.0/yabai-v6.0.0.tar.gz";
    #         sha256 = "sha256-KeZ5srx9dfQN9u6Fgg9BtIhLhFWp975iz72m78bWINo=";
    #       };
    #     });
    #   })
    # ];
  };

  # programs.fish = {
  #   enable = true;
  # };

  networking = {
    dns = ["1.1.1.1" "1.0.0.1"];
    knownNetworkServices = ["Wi-Fi"];
  };
  environment.systemPackages = with pkgs; [nixVersions.stable];
}
