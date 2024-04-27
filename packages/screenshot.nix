{ writeShellApplication, stdenv, wl-clipboard, ... }:

let
  copy = if stdenv.isLinux then "wl-copy" else "pbcopy";
  util = if stdenv.isLinux then "grimblast save" else "screencapture";
  whole = if stdenv.isLinux then "output" else "";
  area = if stdenv.isLinux then "area" else "-i";
in
writeShellApplication {
  name = "screenshot";
  runtimeInputs = [ wl-clipboard ];
  meta.description = ''
    Take a screenshot and upload to arul.io
  '';
  text = ''
    name="$XDG_PICTURES_DIR/screenshots/$(date +'%F:%R:%S').png"
    case $1 in
        whole)
            ${util} ${whole} "$name";;
        area)
            ${util} ${area} "$name" ;;
    esac

    if [ -f "$name" ]; then
      URL="$(curl --netrc-file ~/.config/.netrc -sF "file=@$name" "https://arul.io" | tee >(${copy}))"
      msg="display notification \"$URL\" with title \"Screenshot uploaded!\""
      osascript -e "$msg"
    fi
  '';
}
