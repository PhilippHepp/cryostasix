{
  age = {
    secrets = {
      wg-DE = {
        file = ../../secrets/wg-DE.age;
        path = "/etc/wireguard/DE.conf";
      };
      wg-NL = {
        file = ../../secrets/wg-NL.age;
        path = "/etc/wireguard/NL.conf";
      };
      wg-NO = {
        file = ../../secrets/wg-NO.age;
        path = "/etc/wireguard/NO.conf";
      };
      wg-US = {
        file = ../../secrets/wg-US.age;
        path = "/etc/wireguard/US.conf";
      };
      wg-BR = {
        file = ../../secrets/wg-BR.age;
        path = "/etc/wireguard/BR.conf";
      };
      tailscale-key.file = ../../secrets/tailscale-key.age;
      m3tam3re-secrets = {
        file = ../../secrets/m3tam3re-secrets.age;
        owner = "m3tam3re";
      };
    };
  };
}
