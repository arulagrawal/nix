{
  pkgs,
  flake,
  ...
}: let
  inherit (flake) inputs;
  inherit (inputs) self;
in {
  imports = [
    self.darwinModules.default
    "${self}/nixos/man.nix"
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";

  environment = {
    shells = with pkgs; [fish];
    pathsToLink = ["/share/fish"];
  };

  networking = {
    dns = ["1.1.1.1" "1.0.0.1"];
    knownNetworkServices = ["Wi-Fi"];
  };

  environment.systemPackages = with pkgs; [nixVersions.stable];

  security.pam.services.sudo_local.touchIdAuth = true;

  # For home-manager to work.
  users.users.${flake.config.people.myself} = {
    name = flake.config.people.myself;
    home = "/Users/${flake.config.people.myself}";
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system = {
    primaryUser = flake.config.people.myself;
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
        NSWindowResizeTime = 0.1;
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
  networking = {
    applicationFirewall = {
      enable = true;
      enableStealthMode = true;
    };
  };
}
