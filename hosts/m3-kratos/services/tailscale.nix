{config, ...}: {
  services.tailscale = {
    enable = true;
    authKeyFile = config.age.secrets.tailscale-key.path;
    useRoutingFeatures = "both";
    extraUpFlags = [
      "--login-server=https://va.m3tam3re.com"
      "--accept-routes"
      "--exit-node-allow-lan-access"
    ];
  };
}
