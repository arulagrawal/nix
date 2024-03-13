{pkgs, ...}: let
  python-packages = python-packages: with python-packages; [pyyaml requests tkinter];

  python-with-packages = pkgs.python311.withPackages python-packages;

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
    bat
  ];

  research = with pkgs; [
    obsidian
  ];

  generic = with pkgs; [
    python-with-packages
    htop
    docker-client
    docker-compose
    restic
    nodejs
    yarn
    rustup
    gh
    nil
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
    awscli2
    black
    ffmpeg
    ctags
    tesseract
    spin
    jdk17
    jetbrains.idea-community
    jetbrains.rust-rover
  ];

  custom = with pkgs; [];
  mac = with pkgs; [
    nivApps.Halloy
  ];
in {
  home.packages = generic ++ utilites ++ node ++ mac ++ custom ++ research;
}
