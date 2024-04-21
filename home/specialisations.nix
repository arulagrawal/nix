{ pkgs
, lib
, config
, ...
}: {
  # light/dark specialisations
  specialisation =
    let
      colorschemePath = "/org/gnome/desktop/interface/color-scheme";
      dconf = "${pkgs.dconf}/bin/dconf";

      dconfDark = lib.hm.dag.entryAfter [ "dconfSettings" ] ''
        ${dconf} write ${colorschemePath} "'prefer-dark'"
      '';
      dconfLight = lib.hm.dag.entryAfter [ "dconfSettings" ] ''
        ${dconf} write ${colorschemePath} "'prefer-light'"
      '';
    in
    {
      light.configuration = {
        theme.name = "light";
        home.activation = { inherit dconfLight; };
      };
      dark.configuration = {
        theme.name = "dark";
        home.activation = { inherit dconfDark; };
      };
    };

  theme = {
    # specific to unsplash
    wallpaper =
      let
        url = "https://arul.io/2NSAu.jpg";
        sha256 = "0llpfz2naadr01hnybypnbif4qvmf2jqp5j5q8f49lrzlcsa7z1j";
        ext = lib.last (lib.splitString "." url);
      in
      builtins.fetchurl {
        name = "wallpaper-${sha256}.${ext}";
        inherit url sha256;
      };
  };

  programs.matugen = {
    enable = false;
    wallpaper = config.theme.wallpaper;
  };
}
