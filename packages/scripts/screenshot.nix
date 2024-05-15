{ writeShellApplication, stdenv, lib, pkgs, ... }:

let
  copy = if stdenv.isLinux then "wl-copy" else "pbcopy";
  util = if stdenv.isLinux then "grimblast save" else "screencapture";
  whole = if stdenv.isLinux then "output" else "";
  area = if stdenv.isLinux then "area" else "-i";
  path = if stdenv.isLinux then "$HOME/images" else "$HOME/Pictures";
in
writeShellApplication {
  name = "screenshot";
  meta.description = ''
    Take a screenshot and upload to arul.io
  '';
  runtimeInputs = lib.optionals stdenv.isLinux [ pkgs.wl-clipboard pkgs.grimblast pkgs.libnotify ];
  text = ''
    name="${path}/screenshots/$(date +'%F:%R:%S').png"
    case $1 in
        whole)
            ${util} ${whole} "$name";;
        area)
            ${util} ${area} "$name" ;;
    esac

    if [ -f "$name" ]; then
      URL="$(curl --netrc-file ~/.config/.netrc -sF "file=@$name" "https://arul.io" | tee >(${copy}))"
      ${
        if stdenv.isLinux then 
          "notify-send \"screenshot uploaded!\" \"$URL\""
        else 
          ''osascript -e "display notification \"$URL\" with title \"Screenshot uploaded!\""''
      }
    fi
  '';
}
