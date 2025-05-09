{
  age = {
    secrets = {
      baserow-env = {
        file = ../../secrets/baserow-env.age;
      };
      ghost-env = {
        file = ../../secrets/ghost-env.age;
      };
      littlelink-m3tam3re = {
        file = ../../secrets/littlelink-m3tam3re.age;
      };
      minio-root-cred = {
        file = ../../secrets/minio-root-cred.age;
      };
      n8n-env = {
        file = ../../secrets/n8n-env.age;
      };
      paperless-key = {
        file = ../../secrets/paperless-key.age;
      };
      restreamer-env = {
        file = ../../secrets/restreamer-env.age;
      };
      searx = {
        file = ../../secrets/searx.age;
      };
      tailscale-key = {
        file = ../../secrets/tailscale-key.age;
      };
      traefik = {
        file = ../../secrets/traefik.age;
        owner = "traefik";
      };
      vaultwarden-env = {
        file = ../../secrets/vaultwarden-env.age;
      };
      m3tam3re-secrets = {
        file = ../../secrets/m3tam3re-secrets.age;
        owner = "m3tam3re";
      };
    };
  };
}
