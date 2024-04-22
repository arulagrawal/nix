{ flake, system, ... }:
let
  inherit (flake) inputs;
in
self: super: {
  pa = self.callPackage ./pa.nix { };
  fe = inputs.fe.defaultPackage.${system};
  dl_sieve = inputs.dl_sieve.defaultPackage.${system};
}
