{ pkgs, ... }: {
  services.pcscd.enable = true;
  services.dbus.packages = [ pkgs.gcr ];
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };
}
