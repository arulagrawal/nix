let pkgs = import <nixpkgs> { };
in {
  packages = with pkgs; [
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
    ncdu
    bitwarden-cli
    nodePackages.pyright
    nodePackages.bash-language-server
    (import ./packages/dl_sieve.nix)
  ];
}
