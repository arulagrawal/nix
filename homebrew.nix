{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    taps = [ "homebrew/cask" "homebrew/cask-versions" ];
    casks = [
      "orion"
      "google-chrome"
      "firefox"
      "duckduckgo"
      "visual-studio-code"
      "discord"
      "spotify"
      "plex"
      "homebrew/cask-versions/iterm2-beta"
      "altserver"
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
      "mpv"
      "mullvadvpn-beta"
    ];
    masApps = {
      "Hidden Bar" = 1452453066;
      "Infuse" = 1136220934;
      "Intermission" = 1439431081;
      "Adguard for Safari" = 1440147259;
      "Bitwarden" = 1352778147;
      "Tampermonkey" = 1482490089;
      "Noir" = 1592917505;
      "Sponsorblock" = 1573461917;
      "Tweaks for Reddit" = 1524828965;
      "Vimari" = 1480933944;
    };
  };
}
