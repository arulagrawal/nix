let
  pkgs = import <nixpkgs> { };
  inherit (pkgs) rustPlatform fetchFromGitea;
in rustPlatform.buildRustPackage rec {
  pname = "dl_sieve";
  version = "0.1.5";

  src = fetchFromGitea {
    domain = "git.arul.io";
    owner = "arul";
    repo = pname;
    rev = version;
    sha256 = "sha256-xRyXgx9cU4k8FxWKx2FaN1x6B8cwWnrNcJRtYYR5rm8=";
  };

  cargoSha256 = "sha256-1K8WRx/vXhFC32ycysxSS0kLyUkNBZo/z007xkfl3S8=";
}
