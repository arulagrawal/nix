{
  services.home-assistant = {
    enable = true;
    extraComponents = [
      # Components required to complete the onboarding
      "esphome"
      "met"
      "radio_browser"
    ];
    config = {
      # Includes dependencies for a basic setup
      # https://www.home-assistant.io/integrations/default_config/
      default_config = { };
    };
  };

  networking.firewall.allowedTCPPorts = [ 8123 ];


  services.esphome = {
    enable = true;
    openFirewall = true;
    address = "0.0.0.0";
  };
}
