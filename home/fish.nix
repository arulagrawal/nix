{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      	    set fish_greeting
      	    set fish_pager_color_description magenta --italics
      	  '';
    shellBinds = {
      "." = "rationalise-dot";
    };
    shellAliases = {
      mkdir = "mkdir -pv";
      get = "curl --continue-at - --location --progress-bar --remote-name --remote-time";
    };
    shellAbbrs = {
      cx = "chmod +x";
      ga = "git add";
      gap = "git add -p";
      gaa = "git add -A";
      gc = "git commit";
      # gcm = "git commit -m";
      gcm = {
        position = "command";
        setCursor = true;
        expansion = "git commit -m '%'";
      };
      gs = "git status";
      gp = "git push";
      gd = "git diff";
      gl = "git log";
      q = "exit 0";
      flake = "nix flake";
    };
    functions = import ./functions.nix;
  };

}
