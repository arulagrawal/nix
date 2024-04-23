{ pkgs, lib, flake, ... }:
let
  spicePkgs = flake.inputs.spicetify-nix.packages.${pkgs.system}.default;

in
{
  # import the flake's module for your system
  imports = [ flake.inputs.spicetify-nix.homeManagerModule ];

  # home.packages = with pkgs; [ spotify ];

  # configure spicetify :)
  programs.spicetify =
    {
      enable = true;
      theme = spicePkgs.themes.catppuccin;
      colorScheme = "mocha";

      enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplay
        shuffle # shuffle+ (special characters are sanitized out of ext names)
        hidePodcasts
      ];
    };
}
