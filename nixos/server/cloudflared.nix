{ flake, config, lib, ... }:
{
  age.secrets.cloudflared = {
    file = ../../secrets/cloudflared.age;
    owner = "cloudflared";
    group = "cloudflared";
    mode = "770";
  };

  services.cloudflared = {
    enable = true;
    tunnels."main" = {
      credentialsFile = config.age.secrets.cloudflared.path;
      ingress = {
        "*.yamchah2.com" = "http://localhost:80";
      };
      default = "http_status:404";
    };
  };
}
