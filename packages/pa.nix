{ writeShellApplication, stdenv, wl-clipboard, ... }:

writeShellApplication {
  name = "pa";
  runtimeInputs = [ wl-clipboard ];
  meta.description = ''
    Upload file to arul.io
  '';
  text = ''
    [ ! -f "$1" ] && echo "give a file name" && return 1
    curl --netrc-file ~/.config/.netrc -sF "file=@$1" "https://arul.io" | tee >(${if stdenv.isLinux then "wl-copy" else "pbcopy"})
  '';
}
