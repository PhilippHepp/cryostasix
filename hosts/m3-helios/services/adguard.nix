{
  services.adguardhome = {
    enable = true;
    openFirewall = true;
    settings = {
      dns = {
        port = 53;
        upstream_dns = [
          "1.1.1.1"
          "8.8.8.8"
        ];
      };
      filtering = {
        rewrites = [
          {
            domain = "*.l.m3tam3re.com";
            answer = "192.168.178.210";
          }
        ];
      };
    };
  };
  networking.firewall.allowedTCPPorts = [53];
  networking.firewall.allowedUDPPorts = [53];
}
