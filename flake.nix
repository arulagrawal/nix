{
  inputs = {
    # change tag or commit of nixpkgs for your system
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # change main to a tag or git revision (TODO: why?)
    mk-darwin-system.url = "github:arulagrawal/mk-darwin-system/main";
    mk-darwin-system.inputs.nixpkgs.follows = "nixpkgs";

    naersk = {
      url = "github:nmattia/naersk/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dl_sieve = {
      url = "git+https://git.arul.io/arul/dl_sieve";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "mk-darwin-system/flake-utils";
      inputs.naersk.follows = "naersk";
    };
  };

  outputs = {mk-darwin-system, ...} @ inputs: let
    userName = "arul";
    hostName = "coffeemaker";

    darwinFlake = mk-darwin-system.mkFlake {
      inherit userName hostName inputs;
      flake = ./.;
    };
  in
    darwinFlake;
}
