let
  pkgs = import <nixpkgs> { };

  python-packages = python-packages: with python-packages; [ pyyaml requests ];

  python-with-packages = pkgs.python3.withPackages python-packages;

  node = with pkgs.nodePackages; [
    pyright
    bash-language-server
    typescript-language-server
  ];

  utilites = with pkgs; [
    tree
    fzf
    jq
    tmpmail
    gdu
    tealdeer
  ];

  generic = with pkgs; [
    python-with-packages
    neovim
    htop
    docker-client
    docker-compose
    colima
    restic
    nodejs
    yarn
    rustc
    cargo
    rust-analyzer
    rustfmt
    rnix-lsp
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
    gopls
    highlight
    glow
    fly
    bitwarden-cli
    git-crypt
    black
    ffmpeg_5
  ];

  custom = with pkgs; [ (import ./packages/dl_sieve.nix) ];

  mac = with pkgs; [ ];
in { packages = generic ++ utilites ++ node ++ mac ++ custom; }
