{ self, config, ... }:

{
  # Configuration common to all Linux systems
  flake = {
    nixosModules = {
      # NixOS modules that are known to work on nix-darwin.
      common.imports = [
        ./nix.nix
        ./caches
        ./self/primary-as-admin.nix
      ];

      my-home-desktop = {
        users.users.${config.people.myself} = {
          isNormalUser = true;
        };
        home-manager.users.${config.people.myself} = {
          imports = [
            self.homeModules.common-linux-desktop
          ];
        };
      };

      my-home-server = {
        users.users.${config.people.myself} = {
          isNormalUser = true;
        };
        home-manager.users.${config.people.myself} = {
          imports = [
            self.homeModules.common-linux-server
          ];
        };
      };

      theme = import ./theme;

      default.imports = [
        self.nixosModules.home-manager
        self.nixosModules.common
        #./self/self-ide.nix
      ];

      desktop.imports = [
        self.nixosModules.default
        self.nixosModules.theme
        self.nixosModules.my-home-desktop
        ./current-location.nix
      ];

      server.imports = [
        self.nixosModules.default
        self.nixosModules.my-home-server
        ./server
      ];
    };
  };
}
