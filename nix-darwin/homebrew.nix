{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    brews = [ "aircrack-ng" "bitwarden-cli" ];
    taps = [ "homebrew/cask-versions" ];
    casks = [
      "orion"
      "google-chrome"
      "arc"
      "firefox"
      "duckduckgo"
      "tor-browser"
      "visual-studio-code"
      "zed"
      "vimr"
      "discord"
      "spotify"
      "plex"
      "homebrew/cask-versions/iterm2-beta"
      "veracrypt"
      "macfuse"
      "postman"
      "wezterm"
      "steam"
      "utm"
      "numi"
      "raycast"
      "transmission"
      "iina"
      "mkvtoolnix"
      "mullvadvpn-beta"
      "tg-pro"
      "disk-diet"
      "hiddenbar"
      "contexts"
      "lunar"
      "parsec"
      "sigmaos"
      "ankama"
      "orbstack"
      "multimc"
      "cloudflare-warp"
      "whisky"
    ];
    masApps = {
      /*
      "Hidden Bar" = 1452453066;
      */
      "Infuse" = 1136220934;
      "Intermission" = 1439431081;
      "Adguard for Safari" = 1440147259;
      "Bitwarden" = 1352778147;
      "Tampermonkey" = 1482490089;
      "Noir" = 1592917505;
      "Sponsorblock" = 1573461917;
      "Tweaks for Reddit" = 1524828965;
      /*
      "Vimari" = 1480933944;
      */
      "WireGuard" = 1451685025;
      "Tailscale" = 1475387142;
      "Flow" = 1423210932;
    };
  };
}
