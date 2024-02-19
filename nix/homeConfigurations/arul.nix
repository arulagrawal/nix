{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
# for configurable home-manager modules see:
# https://github.com/nix-community/home-manager/blob/master/modules/modules.nix
{
  imports = [
    ./packages.nix
    ./shell/shell.nix
  ];

  home = {
    stateVersion = lib.mkForce "24.05";
    sessionPath = ["/opt/homebrew/bin"];
    sessionVariables = {
      EDITOR = "nvim";
      LANG = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
      NIX_SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
      DIRENV_LOG_FORMAT="";
      # FIGNORE = ".git:DS_Store";
    };
    file = {
      scripts = {
        recursive = false;
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/nix/homeConfigurations/scripts";
      };
    };

    # custom packages
    packages = [
      inputs.dl_sieve.defaultPackage.${pkgs.system}
      inputs.fe.defaultPackage.${pkgs.system}
    ];
  };

  programs = {
    go = {
      enable = true;
      goPath = "code/go";
    };
    ssh = {
      enable = true;
      matchBlocks = {
        "kettle" = {
          user = "arul";
          hostname = "kettle.arul.io";
        };
        "airfryer" = {
          user = "ubuntu";
          hostname = "airfryer.arul.io";
        };
        "oven" = {
          user = "arul";
          hostname = "100.85.105.81";
        };
      };
      extraConfig = ''
        IgnoreUnknown UseKeychain
        UseKeychain yes
      '';
    };
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
    };
    gpg = {enable = true;};
    git = {
      enable = true;
      package = pkgs.git;
      ignores = [".DS_Store"];
      userEmail = "me@arul.io";
      userName = "Arul Agrawal";
      signing = {
        # gpgPath = "/Users/arul/.nix-profile/bin/gpg";
        key = "D16A92BEDB48284C";
        signByDefault = true;
      };
      extraConfig = {
        init = {defaultBranch = "main";};
        credential.helper = "osxkeychain";
        push.autoSetupRemote = true;
        # https://github.com/dandavison/delta/issues/447#issuecomment-1239398586
        core.pager = ''
          ${pkgs.delta}/bin/delta --features "$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo dark-mode || echo light-mode)"'';
        "delta \"light-mode\"".light = true;
        "delta \"dark-mode\"".light = false;
        delta.line-numbers = true;
        interactive.diffFilter = ''
          ${pkgs.delta}/bin/delta --color-only --features "$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo dark-mode || echo light-mode)"
        '';
      };
      aliases = {co = "checkout";};
    };
  };
  xdg = {
    enable = true;
  };
}
