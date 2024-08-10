{ pkgs, ... }: {
  networking.wireless = {
    enable = true;
    userControlled.enable = true;
  };
  environment.systemPackages = with pkgs; [ wpa_gui wpa_cli ];
}
