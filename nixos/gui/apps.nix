{ pkgs, ... }: {
  # Apps I use on desktops and laptops
  environment.systemPackages = with pkgs; [
    firefox
    google-chrome
    zen-browser
    vesktop
    wezterm
    pavucontrol
    ankama-launcher
    thunderbird
    nvtopPackages.amd
    gpu-screen-recorder-gtk

    (catppuccin-gtk.override {
      size = "compact";
      tweaks = [ "rimless" ]; # You can also specify multiple tweaks here
      variant = "mocha";
    })

    prismlauncher
  ];

  programs.virt-manager.enable = true;
}
