{
  imports = [ <home-manager/nix-darwin> ];

  home-manager = {
    useUserPackages = false;
    useGlobalPkgs = true;
    users.arul = { pkgs, lib, ... }: {
      home = let packages = import ./packages.nix;
      in {
        inherit (packages) packages;
        stateVersion = "22.11";
        sessionPath = [ "/opt/homebrew/bin" ];
        sessionVariables = {
          EDITOR = "nvim";
          LANG = "en_US.UTF-8";
          LC_ALL = "en_US.UTF-8";
          # FIGNORE = ".git:DS_Store";
        };
      };
      programs = let shell = import ./shell/shell.nix;
      in {
        inherit (shell) zsh exa zoxide starship;
        go = {
          enable = true;
          goPath = "code/go";
        };
        ssh = {
          enable = true;
          matchBlocks = {
            "airfryer" = { user = "ubuntu"; };
            "status" = {
              user = "cyberian";
              hostname = "status.arul.io";
            };
          };
          extraConfig = lib.concatStringsSep "\n" [
            "IgnoreUnknown UseKeychain"
            "UseKeychain yes"
          ];
        };
        gpg = { enable = true; };
        git = {
          enable = true;
          ignores = [ ".DS_Store" ];
          userEmail = "me@arul.io";
          userName = "Arul Agrawal";
          signing = {
            gpgPath = "/Users/arul/.nix-profile/bin/gpg";
            key = "D16A92BEDB48284C";
            signByDefault = true;
          };
          extraConfig = {
            init = { defaultBranch = "main"; };
            credential.helper = "osxkeychain";
            push.autoSetupRemote = true;
          };
          aliases = { co = "checkout"; };
        };
      };
      xdg = {
        enable = true;
        configFile."nixpkgs/config.nix".source = ./nixpkgs-config.nix;
      };
    };
  };
}
