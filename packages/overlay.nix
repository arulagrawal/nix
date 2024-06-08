{ flake, system, ... }:
let
  inherit (flake) inputs;
in
self: super: {
  pa = self.callPackage ./scripts/pa.nix { };
  screenshot = self.callPackage ./scripts/screenshot.nix { };
  ankama-launcher = self.callPackage ./ankama-launcher.nix { };
  fe = inputs.fe.packages.${system}.default;
  dl_sieve = inputs.dl_sieve.defaultPackage.${system};
  rofi-sound = inputs.rofi-sound.packages.${system}.default;
  nextprev = inputs.nextprev.packages.${system}.default;
  notif = inputs.notif.packages.${system}.default;
  agenix = inputs.agenix.packages.${system}.default;

  # tailscale =
  #   let
  #     version = "1.66.1";
  #     src = super.fetchFromGitHub {
  #       owner = "tailscale";
  #       repo = "tailscale";
  #       rev = "v${version}";
  #       hash = "sha256-1Yt8W/UanAghaElGiD+z7BKeV/Ge+OElA+B9yBnu3vw=";
  #     };
  #   in
  #   (super.tailscale.override {
  #     buildGoModule = args: super.buildGoModule (args // {
  #       inherit src version;
  #       vendorHash = "sha256-Hd77xy8stw0Y6sfk3/ItqRIbM/349M/4uf0iNy1xJGw=";
  #
  #       ldflags = [
  #         "-w"
  #         "-s"
  #         "-X tailscale.com/version.longStamp=${version}"
  #         "-X tailscale.com/version.shortStamp=${version}"
  #       ];
  #     });
  #   });
}
