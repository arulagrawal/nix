{ lib, ... }:

{
  imports = [ <home-manager/nix-darwin> ];

  home-manager.users.arul = { pkgs, ... }: {
    nixpkgs = {
      config = {
        allowUnfree = true;
        allowBroken = false;
        allowInsecure = false;
        allowUnsupportedSystem = false;
      };
    };
    home = {
      stateVersion = "22.11";
      packages = with pkgs; [
        neovim
        htop
        docker
        docker-compose
        colima
        restic
        fzf
        jq
        nodejs
        yarn
        ripgrep
        neofetch
        wget
        ansible
        terraform
        mosh
        nixfmt
        shellcheck
        imagemagick
        gosec
      ];
      sessionPath = [ "/opt/homebrew/bin" ];
      sessionVariables = {
        EDITOR = "nvim";
        LANG = "en_US.UTF-8";
        LC_ALL = "en_US.UTF-8";
        # FIGNORE = ".git:DS_Store";
      };
    };
    programs = {
      go = {
        enable = true;
        goPath = "code/go";
      };
      zsh = {
        enable = true;
        enableAutosuggestions = true;
        historySubstringSearch.enable = true;
        autocd = true;
        shellAliases = {
          rebuild = "darwin-rebuild switch";
          mkdir = "mkdir -pv";
          cx = "chmod +x";
          vim = "nvim";
          get =
            "curl --continue-at - --location --progress-bar --remote-name --remote-time";
          ga = "git add";
          gaa = "git add -A";
          gc = "git commit";
          gs = "git status";
          gp = "git push";
          gd = "git diff";
          q = "exit 0";
        };
        dotDir = ".config/zsh";
        history = {
          expireDuplicatesFirst = true;
          save = 100000000;
          size = 1000000000;
          path = "$ZDOTDIR/.zsh_history";
          share = true;
        };
        plugins = [
          {
            name = "functions";
            src = ./plugins;
            # file = "functions.zsh";
          }
          {
            name = "colored-man-pages";
            src = pkgs.fetchFromGitHub {
              owner = "ael-code";
              repo = "zsh-colored-man-pages";
              rev = "57bdda68e52a09075352b18fa3ca21abd31df4cb";
              sha256 = "sha256-087bNmB5gDUKoSriHIjXOVZiUG5+Dy9qv3D69E8GBhs=";
            };
          }
        ];
        # dont look!
        initExtraBeforeCompInit = lib.concatStringsSep "\n" [
          "fignore=(DS_Store)" # to remove .DS_Store from completions
          "zstyle ':completion:*' special-dirs false"
          "zstyle ':completion:*:functions' ignored-patterns '_*'"
          "zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'"
          "zstyle ':completion:*' menu select=2 interactive"
          (builtins.readFile ./LS_COLORS)
        ];
        initExtra =
          "setopt autocd extendedglob nomatch globdots extended_glob COMPLETE_IN_WORD";
      };
      zoxide = {
        enable = true;
        enableZshIntegration = true;
      };
      ssh = {
        enable = true;
        matchBlocks = {
          "airfryer" = {
            user = "ubuntu";
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
      exa = {
        enable = true;
        enableAliases = true;
      };
      starship = {
        enable = true;
        enableZshIntegration = true;
        settings = {
          format = lib.concatStrings [
            "$username"
            "$hostname"
            "$directory"
            "$git_branch"
            "$git_state"
            "$git_status"
            "$cmd_duration"
            "$line_break"
            "$python"
            "$character"
          ];
          directory = {
            style = "bold blue";
            truncation_length = 10;
            truncation_symbol = "";
            truncate_to_repo = false;
          };

          character = {
            success_symbol = "[❯](purple)";
            error_symbol = "[❯](red)";
            vicmd_symbol = "[❮](green)";
          };

          git_branch = {
            format = "[$branch]($style)";
            style = "green";
          };

          # yes these zero width spaces are on purpose
          git_status = {
            format =
              "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)";
            style = "cyan";
            conflicted = "​";
            untracked = "​";
            modified = "​";
            staged = "​";
            renamed = "​";
            deleted = "​";
            stashed = "≡";
            ahead = "↑ ";
            behind = "↓ ";
          };

          git_state = {
            format = "([$state( $progress_current/$progress_total)]($style)) ";
            style = "bright-black";
          };

          cmd_duration = {
            format = "[$duration]($style) ";
            style = "yellow";
          };

          python = {
            format = "[$virtualenv]($style) ";
            style = "bright-black";
          };
        };
      };
    };
    xdg = { enable = true; };
  };
}
