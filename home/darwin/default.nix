{ config, pkgs, ... }:
{
  home.sessionVariables = {
    EDITOR = "nvim";
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    NIX_SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
    # FIGNORE = ".git:DS_Store";
  };
  programs.fish.shellInit = ''
    for p in /nix/var/nix/profiles/default/bin /run/current-system/sw/bin /etc/profiles/per-user/(users)/bin
      if not contains $p $fish_user_paths
        set -g fish_user_paths $p $fish_user_paths
      end
    end
  '';

  home.sessionPath = [ "/opt/homebrew/bin" ];
  home.file.scripts = {
    recursive = false;
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/home/darwin/scripts";
  };

  home.packages = with pkgs; [
    nextprev
    screenshot
    rustup
    restic
  ];
}
