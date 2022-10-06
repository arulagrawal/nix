let
  pkgs = import <nixpkgs> { };
  inherit (pkgs) stdenvNoCC fetchFromGitHub;
in stdenvNoCC.mkDerivation {
  name = "nord-ls-colors";
  src = fetchFromGitHub {
    owner = "arcticicestudio";
    repo = "nord-dircolors";
    rev = "v0.2.0";
    sha256 = "1c9fa6dip266z6hfqd5nan5v6qjp6dg074lvk4rxisirm26djlzz";
  };

  dontConfigure = true;
  dontBuild = true;

  buildInputs = [ pkgs.coreutils ];

  installPhase = ''
    echo "zstyle ':completion:*' list-colors '$(dircolors -b src/dir_colors | head -n1 | cut -d \' -f2)'" > $out
  '';
}
