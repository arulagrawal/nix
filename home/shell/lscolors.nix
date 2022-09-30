let
  pkgs = import <nixpkgs> { };
  inherit (pkgs) stdenv fetchFromGitHub;
in stdenv.mkDerivation {
  name = "nord-ls-colors";
  src = fetchFromGitHub {
    owner = "arcticicestudio";
    repo = "nord-dircolors";
    rev = "v0.2.0";
    sha256 = "1c9fa6dip266z6hfqd5nan5v6qjp6dg074lvk4rxisirm26djlzz";
  };

  buildInputs = [ pkgs.coreutils ];

  installPhase = ''
    dircolors -b src/dir_colors | head -n1 | cut -d \' -f2 > colors
    echo "zstyle ':completion:*' list-colors '$(cat colors)'" > $out
  '';
}
