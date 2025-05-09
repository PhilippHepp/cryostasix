{
  services.wastebin = {
    enable = true;
    settings = {
      WASTEBIN_TITLE = "down in the mines";
      WASTEBIN_BASE_URL = "https://bin.lstr.dev";
      WASTEBIN_ADDRESS_PORT = "0.0.0.0:3003";
      WASTEBIN_MAX_BODY_SIZE = 1048576;
    };
  };
  # Traefik configuration specific to wastebin
  services.traefik.dynamicConfigOptions.http = {
    services.wastebin.loadBalancer.servers = [
      {
        url = "http://localhost:3003/";
      }
    ];

    routers.wastebin = {
      rule = "Host(`bin.lstr.dev`)";
      tls = {
        certResolver = "godaddy";
      };
      service = "wastebin";
      entrypoints = "websecure";
    };
    routers.wastebin-old = {
      rule = "Host(`bin.lstr-261.com`)";
      tls = {
        certResolver = "godaddy";
      };
      service = "wastebin";
      entrypoints = "websecure";
      middlewares = [ "subdomain-redirect" ];
    };
  };
}
