let
  pkgs = import <nixpkgs> { };

  python-packages = python-packages: with python-packages; [ pyyaml requests ];

  python-with-packages = pkgs.python3.withPackages python-packages;

  node = with pkgs.nodePackages; [
    pyright
    bash-language-server
    typescript-language-server
    yaml-language-server
    vscode-css-languageserver-bin
  ];

  utilites = with pkgs; [
    tree
    jq
    tmpmail
    gdu
    tealdeer
    glow
    shellcheck
    mtr
    yt-dlp
  ];

  research = with pkgs; [
    obsidian
  ];

  generic = with pkgs; [
    python-with-packages
    neovim
    htop
    docker-client
    docker-compose
    # colima
    restic
    nodejs
    yarn
    rustup
    rnix-lsp
    ripgrep
    neofetch
    wget
    /* ansible */
    terraform
    mosh
    nixfmt
    imagemagick
    gosec
    gopls
    highlight
    fly
    bitwarden-cli
    git-crypt
    black
    ffmpeg_5
    ctags
    tesseract
    spin
    jdk17
    jetbrains.idea-community
    # jetbrains.rust-rover
  ];

  custom = with pkgs; [ (import ./packages/dl_sieve.nix) ];

  mac = with pkgs; [ ];
in { packages = generic ++ utilites ++ node ++ mac ++ custom ++ research; }
