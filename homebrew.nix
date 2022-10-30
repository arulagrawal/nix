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
    ];
    masApps = {
      "Hidden Bar" = 1452453066;
      "Infuse" = 1136220934;
      "Intermission" = 1439431081;
    };
  };
}
