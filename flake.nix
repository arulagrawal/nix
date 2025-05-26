{
  inputs = {
    # Principle inputs (updated by `nix run .#update`)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:arulagrawal/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nixos-unified.url = "github:srid/nixos-unified";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    systems.url = "github:nix-systems/default";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
      inputs.systems.follows = "systems";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
    };
    # chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    colmena-flake.url = "github:juspay/colmena-flake";

    nix-index-database.url = "github:nix-community/nix-index-database/40d882b55e89add1ded379cc99edaab24983d6d9";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    # zen-browser
    zen-browser.url = "github:youwen5/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    # Neovim
    # nixvim = {
    #   url = "github:nix-community/nixvim";
    #   #inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.flake-parts.follows = "flake-parts";
    #   inputs.home-manager.follows = "home-manager";
    #   inputs.nix-darwin.follows = "nix-darwin";
    #   inputs.treefmt-nix.follows = "treefmt-nix";
    # };

    # Neovim
    nvf = {
      url = "github:arulagrawal/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    hypridle = {
      url = "github:hyprwm/hypridle";
      inputs.hyprlang.follows = "hyprland/hyprlang";
      inputs.nixpkgs.follows = "hyprland/nixpkgs";
      inputs.systems.follows = "hyprland/systems";
    };

    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs.hyprlang.follows = "hyprland/hyprlang";
      inputs.nixpkgs.follows = "hyprland/nixpkgs";
      inputs.systems.follows = "hyprland/systems";
    };

    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
      inputs.hyprlang.follows = "hyprland/hyprlang";
      inputs.nixpkgs.follows = "hyprland/nixpkgs";
      inputs.systems.follows = "hyprland/systems";
    };

    # anyrun = {
    #   url = "github:Kirottu/anyrun";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.flake-parts.follows = "flake-parts";
    # };

    crane = {
      url = "github:ipetkov/crane";
    };

    dl_sieve = {
      url = "git+https://git.arul.io/arul/dl_sieve";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.crane.follows = "crane";
      inputs.flake-utils.follows = "flake-utils";
    };

    fe = {
      url = "git+https://git.arul.io/arul/fe";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.crane.follows = "crane";
      inputs.flake-utils.follows = "flake-utils";
    };

    nextprev = {
      url = "git+https://git.arul.io/arul/nextprev";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.crane.follows = "crane";
      inputs.flake-utils.follows = "flake-utils";
    };

    rofi-sound = {
      url = "git+https://git.arul.io/arul/rofi-sound";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.crane.follows = "crane";
      inputs.flake-utils.follows = "flake-utils";
    };

    notif = {
      url = "git+https://git.arul.io/arul/notif";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = inputs @ {self, ...}:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
      imports = [
        inputs.treefmt-nix.flakeModule
        inputs.nixos-unified.flakeModule
        inputs.colmena-flake.flakeModules.default
        ./users
        ./home
        ./nixos
        ./nix-darwin
      ];

      # Colmena deployment configuration
      # See https://github.com/juspay/colmena-flake
      colmena-flake.deployment = {
        oven = {
          targetHost = "oven";
          targetUser = "arul";
        };

        kettle = {
          targetHost = "kettle";
          targetUser = "arul";
          buildOnTarget = true;
        };
      };

      flake = {
        nixosConfigurations = {
          refrigerator =
            self.nixos-unified.lib.mkLinuxSystem
            {home-manager = true;}
            ./systems/refrigerator.nix;

          oven =
            self.nixos-unified.lib.mkLinuxSystem
            {home-manager = true;}
            ./systems/oven.nix;

          kettle =
            self.nixos-unified.lib.mkLinuxSystem
            {home-manager = true;}
            ./systems/kettle.nix;
        };

        darwinConfigurations.coffeemaker =
          self.nixos-unified.lib.mkMacosSystem
          {home-manager = true;}
          ./systems/coffeemaker.nix;
      };

      perSystem = {
        self',
        pkgs,
        lib,
        config,
        ...
      }: {
        # Flake inputs we want to update periodically
        # Run: `nix run .#update`.
        nixos-unified.primary-inputs = [
          "nixpkgs"
          "home-manager"
          "nix-darwin"
          "nixos-unified"
          "nixvim"
        ];

        treefmt.config = {
          projectRootFile = "flake.nix";
          programs.nixpkgs-fmt.enable = true;
        };
        formatter = config.treefmt.build.wrapper;

        packages.default = self'.packages.activate;
        devShells.default = pkgs.mkShell {
          inputsFrom = [config.treefmt.build.devShell];
          packages = with pkgs; [
            colmena
          ];
        };
      };
    };
}
