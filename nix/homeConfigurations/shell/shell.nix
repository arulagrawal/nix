{
  pkgs,
  lib,
  config,
  ...
}: {
  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
        set fish_pager_color_description magenta --italics
      '';
      shellInit = ''
        for p in /nix/var/nix/profiles/default/bin /run/current-system/sw/bin /etc/profiles/per-user/(users)/bin /Users/(users)/.nix-profile/bin
          if not contains $p $fish_user_paths
            set -g fish_user_paths $p $fish_user_paths
          end
        end
      '';
      shellAliases = {
        mkdir = "mkdir -pv";
        get = "curl --continue-at - --location --progress-bar --remote-name --remote-time";
      };
      shellAbbrs = {
        cx = "chmod +x";
        ga = "git add";
        gap = "git add -p";
        gaa = "git add -A";
        gc = "git commit";
        gcm = "git commit -m";
        gs = "git status";
        gp = "git push";
        gd = "git diff";
        gl = "git log";
        q = "exit 0";
      };
      functions = {
        fzfp = ''
          fzf --reverse --inline-info --preview="if test (file --mime {} | string match -r 'binary');
                  echo '{} is a binary file';
              else
                  highlight --style base16/nord -O ansi -l {} ||
                  cat {} ^/dev/null | head -500;
              end" --bind '?:toggle-preview' --tabstop=1 --ansi --delimiter / --with-nth -1
        '';
        dots = "find ~/nix -type f | awk '!/git|after|lua|.DS_Store/'| fzfp | xargs $EDITOR";
        try = ''
          set -l packages
          for i in $argv
                  set packages $packages "nixpkgs#$i"
              end
          nix shell $packages
        '';
      };
    };
    eza = {
      enable = true;
      enableAliases = true;
    };
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
    fzf = {
      enable = true;
      enableFishIntegration = true;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        command_timeout = 1000;
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
          format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)";
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
          detect_extensions = [];
          detect_files = [];
        };
      };
    };
  };
}
