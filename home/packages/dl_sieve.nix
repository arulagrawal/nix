let
  pkgs = import <nixpkgs> { };
  inherit (pkgs) rustPlatform fetchFromGitea;
in rustPlatform.buildRustPackage rec {
  pname = "dl_sieve";
  version = "0.1.0";

  src = fetchFromGitea {
    domain = "git.arul.io";
    owner = "arul";
    repo = pname;
    rev = version;
    sha256 = "sha256-pkePWiCJwWuD2Rr2vTmlsGGr4hLNNsf4Y4m0YfUaqYk=";
  };

  cargoSha256 = "sha256-TZasxBji7tJnpSVd49s3E8bszqcSkfybQLtVB69625U=";
}
