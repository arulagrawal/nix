{pkgs, ...}: let
  python-packages = python-packages: with python-packages; [pyyaml requests];

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
    restic
    nodejs
    yarn
    rustup
    rnix-lsp
    ripgrep
    neofetch
    wget
    terraform
    mosh
    alejandra
    imagemagick
    gosec
    gopls
    highlight
    flyctl
    bitwarden-cli
    git-crypt
    black
    ffmpeg
    ctags
    tesseract
    spin
    jdk17
    jetbrains.idea-community
    halloy
    # jetbrains.rust-rover
  ];

  custom = with pkgs; [];
  mac = with pkgs; [];
in {
  home.packages = generic ++ utilites ++ node ++ mac ++ custom ++ research;
}
