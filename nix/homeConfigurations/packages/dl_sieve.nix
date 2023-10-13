let
  pkgs = import <nixpkgs> {};
  inherit (pkgs) rustPlatform fetchFromGitea;
in
  rustPlatform.buildRustPackage rec {
    pname = "dl_sieve";
    version = "0.1.7";

    src = fetchFromGitea {
      domain = "git.arul.io";
      owner = "arul";
      repo = pname;
      rev = version;
      sha256 = "sha256-10ICnzKSrAKnQhBLRa8Fwm3pn46XiThbtu/B8YMdJ1U=";
    };

    cargoSha256 = "sha256-/hmwcdE4gIivhjRlQMDFDBFh/6eYhAKGoiOGkQMqb3g=";
  }
