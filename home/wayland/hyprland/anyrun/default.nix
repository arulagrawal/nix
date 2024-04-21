{ pkgs
, flake
, config
, ...
}: {
  programs.anyrun = {
    enable = true;

    config = {
      plugins = with flake.inputs.anyrun.packages.${pkgs.system}; [
        applications
        dictionary
        rink
        shell
        symbols
      ];

      width.fraction = 0.3;
      y.fraction = 0.3;
      hidePluginInfo = true;
      closeOnClick = true;
    };

    extraCss = builtins.readFile (./. + "/style-${config.theme.name}.css");

    extraConfigFiles."applications.ron".text = ''
      Config(
        desktop_actions: false,
        max_entries: 5,
        terminal: Some("foot"),
      )
    '';
  };
}
