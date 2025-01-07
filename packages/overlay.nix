{ flake, system, ... }:
let
  inherit (flake) inputs;
in
self: super: {
  pa = self.callPackage ./scripts/pa.nix { };
  brightness = self.callPackage ./scripts/brightness.nix { };
  screenshot = self.callPackage ./scripts/screenshot.nix { };
  ankama-launcher = self.callPackage ./ankama-launcher.nix { };
  fe = inputs.fe.packages.${system}.default;
  dl_sieve = inputs.dl_sieve.packages.${system}.default;
  rofi-sound = inputs.rofi-sound.packages.${system}.default;
  nextprev = inputs.nextprev.packages.${system}.default;
  notif = inputs.notif.packages.${system}.default;
  agenix = inputs.agenix.packages.${system}.default;
  zen-browser = inputs.zen-browser.packages."${system}".default;
  # python312 =
  #   let
  #     version = "master";
  #     src = super.fetchFromGitHub { owner = "openrazer"; repo = "openrazer"; rev = "3241c8f876f10b7305ec578dcd59f156a7f86030"; sha256 = "sha256-j3tVboCqHywB2PkgELQXw8/nhdcfA4xxfmZ7+dcUqS8="; };
  #
  #   in
  #   super.python312.override {
  #     packageOverrides = pf: pp: {
  #       openrazer = pp.openrazer.overrideAttrs (_: { inherit src version; });
  #       openrazer-daemon = pp.openrazer-daemon.overrideAttrs (_: { inherit src version; });
  #     };
  #   };
  # linuxPackages =
  #   let
  #     version = "master";
  #     src = super.fetchFromGitHub { owner = "openrazer"; repo = "openrazer"; rev = "3241c8f876f10b7305ec578dcd59f156a7f86030"; sha256 = "sha256-j3tVboCqHywB2PkgELQXw8/nhdcfA4xxfmZ7+dcUqS8="; };
  #
  #   in
  #   super.linuxPackages.extend (lpf: lpp: { openrazer = lpp.openrazer.overrideAttrs (_: { inherit src version; }); });
  #

  #   old:
  #   let
  #     version = "master";
  #     src = super.fetchFromGitHub { owner = "openrazer"; repo = "openrazer"; rev = "3241c8f876f10b7305ec578dcd59f156a7f86030"; sha256 = "sha256-j3tVboCqHywB2PkgELQXw8/nhdcfA4xxfmZ7+dcUqS8="; };
  #   in
  #   {
  #     python312 = super.python312.override {
  #       packageOverrides = pf: pp: {
  #         openrazer = pp.openrazer.overrideAttrs (_: { inherit src version; });
  #         openrazer-daemon = pp.openrazer-daemon.overrideAttrs (_: { inherit src version; });
  #       };
  #     };
  #
  #     linuxPackages = super.linuxPackages.extend (lpf: lpp: { openrazer = lpp.openrazer.overrideAttrs (_: { inherit src version; }); });
  #   }
  # );

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
