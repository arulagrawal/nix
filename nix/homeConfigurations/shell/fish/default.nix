{
  enable = true;
  interactiveShellInit = ''
    set fish_greeting
    set fish_pager_color_description magenta --italics
  '';
  shellInit = ''
    for p in /nix/var/nix/profiles/default/bin /run/current-system/sw/bin /etc/profiles/per-user/(users)/bin
      if not contains $p $fish_user_paths
        set -g fish_user_paths $p $fish_user_paths
      end
    end
  '';
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
    gcm = "git commit -m";
    gs = "git status";
    gp = "git push";
    gd = "git diff";
    gl = "git log";
    q = "exit 0";
  };
  functions = import ./functions.nix;
}
