{
  services.gitea = {
    enable = true;
    settings = {
      server.ROOT_URL = "https://code.lstr-261.dev";
      service.DISABLE_REGISTRATION = true;
    };
    lfs.enable = true;
    dump = {
      enable = true;
      type = "tar.gz";
      interval = "03:30:00";
      backupDir = "/var/backup/gitea";
    };
  };
  # Traefik configuration specific to gitea
  services.traefik.dynamicConfigOptions.http = {
    services.gitea.loadBalancer.servers = [
      {
        url = "http://localhost:3000/";
      }
    ];

    routers.gitea = {
      rule = "Host(`code.lstr-261.dev`)";
      tls = {
        certResolver = "godaddy";
      };
      service = "gitea";
      entrypoints = "websecure";
    };
    routers.gitea-old = {
      rule = "Host(`code.lstr-261.com`)";
      tls = {
        certResolver = "godaddy";
      };
      service = "gitea";
      entrypoints = "websecure";
      middlewares = [ "subdomain-redirect" ];
    };
  };
}
