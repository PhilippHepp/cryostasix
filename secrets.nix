let
  # SYSTEMS
  m3-ares = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG+M4CygEQ29eTmLqgyIAFCxy0rgfO23klNiARBEA+3s";
  m3-kratos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDl+LtFGsk/A7BvxwiUCyq5wjRzGtQSrBJzzLGxINF4O";
  m3-helios = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIyHuLITpI+M45ZZem33wDusY2X988mBoWpD1HDeZNRJ";
  m3-atlas = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINBYK1wsFkUPIb/lX1BH7+VyXmmGSbdEFHnvhAOcaC7H";

  # USERS
  m3tam3re = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC3YEmpYbM+cpmyD10tzNRHEn526Z3LJOzYpWEKdJg8DaYyPbDn9iyVX30Nja2SrW4Wadws0Y8DW+Urs25/wVB6mKl7jgPJVkMi5hfobu3XAz8gwSdjDzRSWJrhjynuaXiTtRYED2INbvjLuxx3X8coNwMw58OuUuw5kNJp5aS2qFmHEYQErQsGT4MNqESe3jvTP27Z5pSneBj45LmGK+RcaSnJe7hG+KRtjuhjI7RdzMeDCX73SfUsal+rHeuEw/mmjYmiIItXhFTDn8ZvVwpBKv7xsJG90DkaX2vaTk0wgJdMnpVIuIRBa4EkmMWOQ3bMLGkLQeK/4FUkNcvQ/4+zcZsg4cY9Q7Fj55DD41hAUdF6SYODtn5qMPsTCnJz44glHt/oseKXMSd556NIw2HOvihbJW7Rwl4OEjGaO/dF4nUw4c9tHWmMn9dLslAVpUuZOb7ykgP0jk79ldT3Dv+2Hj0CdAWT2cJAdFX58KQ9jUPT3tBnObSF1lGMI7t77VU=";
  users = [
    m3tam3re
  ];

  systems = [
    m3-atlas
    m3-ares
    m3-helios
    m3-kratos
  ];
in {
  "secrets/baserow-env.age".publicKeys = systems ++ users;
  "secrets/ghost-env.age".publicKeys = systems ++ users;
  "secrets/littlelink-m3tam3re.age".publicKeys = systems ++ users;
  "secrets/m3tam3re-secrets.age".publicKeys = systems ++ users;
  "secrets/minio-root-cred.age".publicKeys = systems ++ users;
  "secrets/n8n-env.age".publicKeys = systems ++ users;
  "secrets/paperless-key.age".publicKeys = systems ++ users;
  "secrets/restreamer-env.age".publicKeys = systems ++ users;
  "secrets/searx.age".publicKeys = systems ++ users;
  "secrets/tailscale-key.age".publicKeys = systems ++ users;
  "secrets/traefik.age".publicKeys = systems ++ users;
  "secrets/vaultwarden-env.age".publicKeys = systems ++ users;
  "secrets/wg-DE.age".publicKeys = systems ++ users;
  "secrets/wg-NL.age".publicKeys = systems ++ users;
  "secrets/wg-NO.age".publicKeys = systems ++ users;
  "secrets/wg-US.age".publicKeys = systems ++ users;
  "secrets/wg-BR.age".publicKeys = systems ++ users;
}
