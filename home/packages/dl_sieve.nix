let
  pkgs = import <nixpkgs> { };
  inherit (pkgs) rustPlatform fetchFromGitea;
in rustPlatform.buildRustPackage rec {
  pname = "dl_sieve";
  version = "0.1.1";

  src = fetchFromGitea {
    domain = "git.arul.io";
    owner = "arul";
    repo = pname;
    rev = version;
    sha256 = "sha256-yIF4YOAm15Rvbv5aj+fmz8ZNz4YwoEvZpo5DGFcMt10=";
  };

  cargoSha256 = "sha256-TinrEKxAPmR9+7F78xe0IFl+7LhtVjnAIW9qoNVvZOQ=";
}
