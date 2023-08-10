{
  imports = [ <home-manager/nix-darwin> ];

  home-manager = {
    useUserPackages = false;
    useGlobalPkgs = true;
    users.arul = { pkgs, ... }: {
      home = let packages = import ./packages.nix;
      in {
        inherit (packages) packages;
        stateVersion = "23.05";
        sessionPath = [ "/opt/homebrew/bin" ];
        sessionVariables = {
          EDITOR = "nvim";
          LANG = "en_US.UTF-8";
          LC_ALL = "en_US.UTF-8";
          # FIGNORE = ".git:DS_Store";
        };
        file = {
          scripts = {
            recursive = false;
            source = ./scripts;
          };
        };
      };
      programs = let shell = import ./shell/shell.nix;
      in {
        inherit (shell) zsh exa zoxide starship fzf;
        go = {
          enable = true;
          goPath = "code/go";
        };
        ssh = {
          enable = true;
          matchBlocks = {
            "kettle" = { user = "arul"; };
            "airfryer" = { user = "ubuntu"; };
          };
          extraConfig = ''
            IgnoreUnknown UseKeychain
            UseKeychain yes
          '';
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
            # https://github.com/dandavison/delta/issues/447#issuecomment-1239398586
            core.pager = ''
              ${pkgs.delta}/bin/delta --features "$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo dark-mode || echo light-mode)"'';
            "delta \"light-mode\"".light = true;
            "delta \"dark-mode\"".light = false;
            delta.line-numbers = true;
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
