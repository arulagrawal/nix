{ pkgs, ... }: {

  # Apps I use on desktops and laptops
  environment.systemPackages = with pkgs; [
    firefox
    wezterm
    vesktop
    spotify
    pavucontrol
    mpv
  ];
}
