{
  age = {
    secrets = {
      traefik = {
        file = ../../secrets/traefik.age;
        mode = "770";
        owner = "traefik";
      };
      m3tam3re-secrets = {
        file = ../../secrets/m3tam3re-secrets.age;
        owner = "m3tam3re";
      };
    };
  };
}
