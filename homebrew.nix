{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    taps = [ "homebrew/cask" ];
    casks = [
      "orion"
      "google-chrome"
      "visual-studio-code"
      "discord"
      "spotify"
      "plex"
      "iterm2"
      "altserver"
      "veracrypt"
      "macfuse"
      "postman"
      "wezterm"
      "steam"
    ];
    masApps = {
      "Hidden Bar" = 1452453066;
      "Infuse" = 1136220934;
      "Intermission" = 1439431081;
    };
  };
}
