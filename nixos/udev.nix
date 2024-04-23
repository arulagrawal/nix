{ lib, ... }:
{
  # prevent logitech pro superlight receiver from waking up the system
  services.udev.extraRules = lib.concatStringsSep ", " [
    ''ACTION=="add"''

    ''SUBSYSTEM=="usb"''
    ''ATTR{idVendor}=="046d"''
    ''ATTR{idProduct}=="c547"''
    ''ATTR{power/wakeup}="disabled"''
  ];
}
