{config, ...}: {
  services.n8n = {
    enable = true;
    webhookUrl = "https://wf.m3tam3re.com";
  };
  systemd.services.n8n.serviceConfig = {
    EnvironmentFile = ["${config.age.secrets.n8n-env.path}"];
  };
  # Traefik configuration specific to n8n
  services.traefik.dynamicConfigOptions.http = {
    services.n8n.loadBalancer.servers = [
      {
        url = "http://localhost:5678/";
      }
    ];

    routers.n8n = {
      rule = "Host(`wf.m3ta.dev`)";
      tls = {
        certResolver = "godaddy";
      };
      service = "n8n";
      entrypoints = "websecure";
    };
  };
}
