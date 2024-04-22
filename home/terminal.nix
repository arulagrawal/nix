{ pkgs, ... }:

# Platform-independent terminal setup
{
  home.packages = with pkgs; [
    # Unixy tools
    ripgrep
    ncdu
    glow
    shellcheck
    bat
    yt-dlp
    tealdeer
    dig
    flyctl

    highlight
    # Useful for Nix development
    nixci
    nix-health
    nil
    nixpkgs-fmt
    just

    # Dev
    gh


    # my scripts/programs
    pa
    fe
    dl_sieve
  ];

  programs = {
    go.enable = true;
    jq.enable = true;
    htop.enable = true;
    eza = {
      enable = true;
    };
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
    fzf = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
