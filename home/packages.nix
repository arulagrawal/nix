let
  pkgs = import <nixpkgs> { };

  python-packages = python-packages: with python-packages; [
    pyyaml
    requests
  ];

  python-with-packages = pkgs.python3.withPackages python-packages;

  node = with pkgs.nodePackages; [
    pyright
    bash-language-server
    typescript-language-server
  ];

  generic = with pkgs; [
    python-with-packages
    tree
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
    rustc
    cargo
    rust-analyzer
    rustfmt
    rnix-lsp
    ripgrep
    neofetch
    tmpmail
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
    gdu
    tealdeer
    bitwarden-cli
    git-crypt
  ];

  custom = with pkgs; [
    (import ./packages/dl_sieve.nix)
  ];

  mac = with pkgs; [
  ];
in {
  packages = generic ++ node ++ mac ++ custom;
}
