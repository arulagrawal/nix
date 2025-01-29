{pkgs, ...}: let
  pname = "ankama-launcher";
  src = pkgs.fetchurl {
    url = "https://launcher.cdn.ankama.com/installers/production/Ankama%20Launcher-Setup-x86_64.AppImage";
    # nix store prefetch-file "https://launcher.cdn.ankama.com/installers/production/Ankama%20Launcher-Setup-x86_64.AppImage" --name ankama-launcher.AppImage
    hash = "sha256-qgWhC/xWUQpIoCNZcRxBPGpbNTFGysIF2N9a1MsxCFk=";
    name = "ankama-launcher.AppImage";
  };
  version = "1.0.0";

  appimageContents = pkgs.appimageTools.extractType2 {inherit pname src version;};
in
  pkgs.appimageTools.wrapType2 {
    inherit pname src version;

    extraInstallCommands = ''
      install -m 444 -D ${appimageContents}/zaap.desktop $out/share/applications/ankama-launcher.desktop
      sed -i 's/.*Exec.*/Exec=ankama-launcher/' $out/share/applications/ankama-launcher.desktop
      install -m 444 -D ${appimageContents}/zaap.png $out/share/icons/hicolor/256x256/apps/zaap.png
    '';
  }
