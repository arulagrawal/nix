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
    stateVersion = "23.11";
    sessionPath = ["/opt/homebrew/bin"];
    sessionVariables = {
      EDITOR = "nvim";
      LANG = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
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
      inputs.dl_sieve.defaultPackage.${inputs.flake-utils.lib.system.aarch64-darwin}
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
        "kettle" = {user = "arul";};
        "airfryer" = {user = "ubuntu";};
      };
      extraConfig = ''
        IgnoreUnknown UseKeychain
        UseKeychain yes
      '';
    };
    gpg = {enable = true;};
    git = {
      enable = true;
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
      };
      aliases = {co = "checkout";};
    };
  };
  xdg = {
    enable = true;
  };
}
