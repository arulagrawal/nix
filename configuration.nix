{ config, pkgs, lib, ... }:

{
  imports = [ ./home/home.nix ./homebrew.nix ];
  users.users.arul = {
    name = "arul";
    home = "/Users/arul";
    shell = pkgs.zsh;
  };

  documentation = {
    enable = true;
    doc.enable = true;
    info.enable = true;
    man.enable = true;
  };

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
      };
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        "com.apple.trackpad.scaling" = 2.0;
        NSAutomaticSpellingCorrectionEnabled = false;
        InitialKeyRepeat = 15;
        KeyRepeat = 1;
      };
      alf = { globalstate = 1; };
    };
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 4;
  };

  security = { pam.enableSudoTouchIdAuth = true; };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  #environment.systemPackages =
  #  [ pkgs.neovim
  #  ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/nix/configuration.nix
  environment = {
    darwinConfig = "$HOME/nix/configuration.nix";
    shells = with pkgs; [ zsh ];
    pathsToLink = [ "/share/zsh" ];
  };

  launchd.agents = {
    backup = {
      command = "/Users/arul/scripts/backup";
      environment = {
        HOME = "/Users/arul";
      };
      serviceConfig = {
        UserName = "arul";
        Label = "backup";
        RunAtLoad = true;
        StandardOutPath = "/Users/arul/Library/Logs/restic.log";
        StandardErrorPath = "/Users/arul/Library/Logs/restic.err.log";
        StartCalendarInterval = [
          { Hour = 6; Minute = 30; }
          { Hour = 22; Minute = 0; }
        ];
      };
    };
  };

  services = {
    # Auto upgrade nix package and the daemon service.
    nix-daemon.enable = true;
    tailscale = {
      enable = true;
      magicDNS.enable = true;
    };
    yabai = {
      enable = true;
      config = {
        mouse_follows_focus = "off";
        focus_follows_mouse = "off";
        window_placement = "second_child";
        window_topmost = "on";
        window_opacity = "off";
        window_opacity_duration = 0.0;
        window_shadow = "on";
        active_window_opacity = 1.0;
        normal_window_opacity = 1.0;
        split_ratio = 0.5;
        auto_balance = "off";
        mouse_modifier = "ctrl";
        mouse_action1 = "move";
        mouse_action2 = "resize";

        layout = "bsp";
        #external_bar           = " all:20:0";
        top_padding = 10;
        bottom_padding = 20;
        left_padding = 20;
        right_padding = 20;
        window_gap = 10;
      };
      extraConfig = (builtins.readFile ./yabai_rules);
    };
    skhd = {
      enable = true;
      skhdConfig = (builtins.readFile ./skhdrc);
    };
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
      trusted-users = [ "root" "arul" ];
    };
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
      experimental-features = nix-command flakes
    '';
  };
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
      allowInsecure = false;
      allowUnsupportedSystem = false;
    };
    /* overlays = [ */
    /*   (self: super: { */
    /*     yabai = super.yabai.overrideAttrs (o: rec { */
    /*       version = "5.0.2"; */
    /*       src = super.fetchzip { */
    /*         url = */
    /*           "https://github.com/koekeishiya/yabai/releases/download/v5.0.2/yabai-v5.0.1.tar.gz"; */
    /*         sha256 = "sha256-iCx/e3IwJ6YzgEy7wGkNQU/d7gaZd4b/RLwRvRpwVwQ="; */
    /*       }; */
    /*     }); */
    /*   }) */
    /* ]; */
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh = {
    enable = true;
    enableCompletion = false;
    enableBashCompletion = false;
    promptInit = "";
    # enableFzfCompletion = true;
    # enableFzfHistory = true;
    # enableSyntaxHighlighting = true;
  };
  # programs.fish.enable = true;

  networking = {
    dns = [ "1.1.1.1" "1.0.0.1" ];
    knownNetworkServices = [ "Wi-Fi" ];
  };
}
