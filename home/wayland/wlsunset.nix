{ osConfig, ... }:
{
  services.wlsunset = {
    enable = true;
    latitude = osConfig.location.latitude;
    longitude = osConfig.location.longitude;
    temperature.night = 5000;
  };
}
