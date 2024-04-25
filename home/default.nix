{ self, inputs, ... }:
{
  flake = {
    homeModules = {
      common = {
        home.stateVersion = "23.11";
        imports = [
          inputs.nixvim.homeManagerModules.nixvim
          #inputs.nix-index-database.hmModules.nix-index
          ./fish.nix
          ./ssh.nix
          ./starship.nix
          ./terminal.nix
          ./neovim.nix
          ./nix.nix
          ./git.nix
          ./gpg.nix
          ./direnv.nix
          ./xdg.nix
        ];
      };
      common-linux = {
        imports = [
          self.homeModules.common
        ];
      };

      common-linux-desktop = {
        imports = [
          self.homeModules.common-linux
          inputs.hyprlock.homeManagerModules.default
          inputs.matugen.nixosModules.default
          inputs.anyrun.homeManagerModules.default
          self.nixosModules.theme
          ./wayland
          ./specialisations.nix
          #./gnome-keyring.nix
          ./transient-services.nix
          ./spotify.nix
        ];
      };

      common-linux-server = {
        imports = [
          self.homeModules.common-linux
        ];
      };

      common-darwin = {
        imports = [
          self.homeModules.common
          ./darwin
        ];
      };
    };
  };
}
