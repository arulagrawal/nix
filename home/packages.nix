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
    nodePackages.pyright
  ];
}
