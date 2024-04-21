{ flake, system, ... }:

self: super: {
  pa = self.callPackage ./pa.nix { };
}
