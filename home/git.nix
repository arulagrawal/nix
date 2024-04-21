{ pkgs, config, flake, ... }:
{
  home.packages = with pkgs; [
    git-lfs
    git-filter-repo
    git-crypt
  ];

  programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    userName = flake.config.people.users.${config.home.username}.name;
    userEmail = flake.config.people.users.${config.home.username}.email;
    aliases = {
      co = "checkout";
    };
    ignores = [ "*~" "*.swp" ".DS_Store" ];
    signing = {
      key = "D16A92BEDB48284C";
      signByDefault = true;
    };
    delta = {
      enable = true;
      options = {
        features = "decorations";
        navigate = true;
        light = false;
        side-by-side = true;
      };
    };
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "nvim";
      push.autoSetupRemote = true;
      credential.helper = if pkgs.stdenv.isLinux then "store --file ~/.git-credentials" else "osxkeychain";
    };
  };
}
