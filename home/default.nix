{ self, inputs, lib, ... }:
{
  flake = {
    homeModules = {
      common = {
        home.stateVersion = "23.11";
        imports = [
          inputs.nixvim.homeManagerModules.nixvim
          inputs.nix-index-database.hmModules.nix-index
          ./fish.nix
          ./ssh.nix
          ./starship.nix
          ./terminal.nix
          ./neovim.nix
          ./nix.nix
          ./git.nix
          ./gpg.nix
        ];
      };

      # common to gui linux and darwin
      common-desktop = {
        imports = [
          ./xdg.nix
          ./direnv.nix
        ];
        neovim.config = "full";
      };

      # common to all linux
      common-linux = {
        imports = [
          self.homeModules.common
        ];
      };

      # common to all linux desktops (gui)
      common-linux-desktop = {
        imports = [
          self.homeModules.common-linux
          self.homeModules.common-desktop
          inputs.hyprland.homeManagerModules.default
          # inputs.hyprlock.homeManagerModules.default
          # inputs.hypridle.homeManagerModules.default
          # inputs.hyprpaper.homeManagerModules.default
          inputs.anyrun.homeManagerModules.default
          inputs.agenix.homeManagerModules.default
          self.nixosModules.theme
          ./wayland
          ./transient-services.nix
          ./services/notif.nix
          ./spotify.nix
          ./polkit-agent.nix
          ./vscode.nix
        ];
      };

      # common to all linux servers (headless)
      common-linux-server = {
        imports = [
          self.homeModules.common-linux
        ];
        programs.git = {
          extraConfig.credential.helper = lib.mkForce "store --file ~/.git-credentials";
        };
        git.config = "minimal";
        neovim.config = "minimal";
      };

      # common to all macos
      common-darwin = {
        imports = [
          self.homeModules.common
          self.homeModules.common-desktop
          ./darwin
        ];
      };
    };
  };
}
