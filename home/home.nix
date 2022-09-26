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
        yarn
        ripgrep
        neofetch
        wget
        ansible
        terraform
        mosh
        nixfmt
        shellcheck
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
        plugins = [{
          name = "functions";
          src = ./plugins;
          # file = "functions.zsh";
        }];
        # dont look!
        initExtraBeforeCompInit = lib.concatStringsSep "\n" [
          "zstyle ':completion:*' special-dirs false"
          "zstyle ':completion:*:functions' ignored-patterns '_*'"
          "zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'"
          "zstyle ':completion:*' menu select=2 interactive"
          "zstyle ':completion:*' list-colors 'no=00:rs=0:fi=00:di=01;34:ln=36:mh=04;36:pi=04;01;36:so=04;33:do=04;01;36:bd=01;33:cd=33:or=31:mi=01;37;41:ex=01;36:su=01;04;37:sg=01;04;37:ca=01;37:tw=01;37;44:ow=01;04;34:st=04;37;44:*.7z=01;32:*.ace=01;32:*.alz=01;32:*.arc=01;32:*.arj=01;32:*.bz=01;32:*.bz2=01;32:*.cab=01;32:*.cpio=01;32:*.deb=01;32:*.dz=01;32:*.ear=01;32:*.gz=01;32:*.jar=01;32:*.lha=01;32:*.lrz=01;32:*.lz=01;32:*.lz4=01;32:*.lzh=01;32:*.lzma=01;32:*.lzo=01;32:*.rar=01;32:*.rpm=01;32:*.rz=01;32:*.sar=01;32:*.t7z=01;32:*.tar=01;32:*.taz=01;32:*.tbz=01;32:*.tbz2=01;32:*.tgz=01;32:*.tlz=01;32:*.txz=01;32:*.tz=01;32:*.tzo=01;32:*.tzst=01;32:*.war=01;32:*.xz=01;32:*.z=01;32:*.Z=01;32:*.zip=01;32:*.zoo=01;32:*.zst=01;32:*.aac=32:*.au=32:*.flac=32:*.m4a=32:*.mid=32:*.midi=32:*.mka=32:*.mp3=32:*.mpa=32:*.mpeg=32:*.mpg=32:*.ogg=32:*.opus=32:*.ra=32:*.wav=32:*.3des=01;35:*.aes=01;35:*.gpg=01;35:*.pgp=01;35:*.doc=32:*.docx=32:*.dot=32:*.odg=32:*.odp=32:*.ods=32:*.odt=32:*.otg=32:*.otp=32:*.ots=32:*.ott=32:*.pdf=32:*.ppt=32:*.pptx=32:*.xls=32:*.xlsx=32:*.app=01;36:*.bat=01;36:*.btm=01;36:*.cmd=01;36:*.com=01;36:*.exe=01;36:*.reg=01;36:*~=02;37:*.bak=02;37:*.BAK=02;37:*.log=02;37:*.log=02;37:*.old=02;37:*.OLD=02;37:*.orig=02;37:*.ORIG=02;37:*.swo=02;37:*.swp=02;37:*.bmp=32:*.cgm=32:*.dl=32:*.dvi=32:*.emf=32:*.eps=32:*.gif=32:*.jpeg=32:*.jpg=32:*.JPG=32:*.mng=32:*.pbm=32:*.pcx=32:*.pgm=32:*.png=32:*.PNG=32:*.ppm=32:*.pps=32:*.ppsx=32:*.ps=32:*.svg=32:*.svgz=32:*.tga=32:*.tif=32:*.tiff=32:*.xbm=32:*.xcf=32:*.xpm=32:*.xwd=32:*.xwd=32:*.yuv=32:*.anx=32:*.asf=32:*.avi=32:*.axv=32:*.flc=32:*.fli=32:*.flv=32:*.gl=32:*.m2v=32:*.m4v=32:*.mkv=32:*.mov=32:*.MOV=32:*.mp4=32:*.mpeg=32:*.mpg=32:*.nuv=32:*.ogm=32:*.ogv=32:*.ogx=32:*.qt=32:*.rm=32:*.rmvb=32:*.swf=32:*.vob=32:*.webm=32:*.wmv=32:'"
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
          init = {
            defaultBranch = "main";
          };
          credential.helper = "osxkeychain";
        };
      };
      exa = {
        enable = true;
        enableAliases = true;
      };
      starship = {
        enable = true;
        enableZshIntegration = true;
      };
    };
    xdg = { enable = true; };
  };
}
