{ pkgs, ... }:
let
  name = "ankama-launcher";
  src = pkgs.fetchurl {
    url = "https://f003.backblazeb2.com/file/arulmisc/Ankama+Launcher-Setup-x86_64.AppImage";
    sha256 = "08vq2gq33p3vzbnnbvdlshlrfxrql3kgpa30yqrj1chhy11w9n2x"; # Change for the sha256 you get after running nix-prefetch-url https://download.ankama.com/launcher/full/linux/x64
    name = "ankama-launcher.AppImage";
  };

  appimageContents = pkgs.appimageTools.extractType2 { inherit name src; };
in
pkgs.appimageTools.wrapType2 {
  inherit name src;

  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/zaap.desktop $out/share/applications/ankama-launcher.desktop
    sed -i 's/.*Exec.*/Exec=ankama-launcher/' $out/share/applications/ankama-launcher.desktop
    install -m 444 -D ${appimageContents}/zaap.png $out/share/icons/hicolor/256x256/apps/zaap.png
  '';
}
