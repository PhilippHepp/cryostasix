{config, ...}: {
  services.traefik = {
    enable = true;
    staticConfigOptions = {
      log = {level = "WARN";};
      certificatesResolvers = {
        godaddy = {
          acme = {
            email = "letsencrypt.org.btlc2@passmail.net";
            storage = "/var/lib/traefik/acme.json";
            caserver = "https://acme-v02.api.letsencrypt.org/directory";
            dnsChallenge = {
              provider = "godaddy";
            };
          };
        };
      };
      api = {};
      entryPoints = {
        web = {
          address = ":80";
          http.redirections.entryPoint = {
            to = "websecure";
            scheme = "https";
          };
        };
        websecure = {address = ":443";};
      };
    };
    dynamicConfigOptions = {
      http = {
        middlewares = {
          auth = {
            basicAuth = {
              users = ["m3tam3re:$apr1$1xqdta2b$DIVNvvp5iTUGNccJjguKh."];
            };
          };
          default-headers = {
            headers = {
              frameDeny = "true";
              browserXssFilter = "true";
              contentTypeNosniff = "true";
              forceSTSHeader = "true";
              stsIncludeSubdomains = true;
              stsPreload = true;
              stsSeconds = 15552000;
              customFrameOptionsValue = "SAMEORIGIN";
              customResponseHeaders = {
                X-Forwarded-Proto = "https";
              };
            };
          };
          default-whitelist = {
            ipAllowList = {
              sourceRange = ["10.0.0.0/8" "192.168.178.0/16"];
            };
          };
          secured = {
            chain = {
              middlewares = ["default-headers" "default-whitelist"];
            };
          };
        };

        services = {
          m3-prox-1.loadBalancer = {
            servers = [
              {url = "https://192.168.178.200:8006";}
            ];
            passHostHeader = true;
            serversTransport = "pve";
          };
          ag.loadBalancer.servers = [
            {url = "http://192.168.178.210:3000";}
          ];
          homarr.loadBalancer.servers = [
            {url = "http://192.168.178.210:7575";}
          ];
          plex.loadBalancer.servers = [
            {url = "http://192.168.178.175:32400";}
          ];
          skynet.loadBalancer.servers = [
            {url = "http://192.168.178.175:5000";}
          ];
        };
        # Skip verification for PVE servers
        serversTransports = {
          pve = {insecureSkipVerify = true;};
        };

        routers = {
          api = {
            rule = "Host(`traefik.l.m3tam3re.com`)";
            service = "api@internal";
            middlewares = ["auth"];
            entrypoints = ["websecure"];
            tls = {
              certResolver = "godaddy";
            };
          };
          m3-prox-1 = {
            rule = "Host(`m3-prox-1.l.m3tam3re.com`)";
            service = "m3-prox-1";
            middlewares = ["default-headers"];
            entrypoints = ["websecure"];
            tls = {
              certResolver = "godaddy";
            };
          };
          ag = {
            rule = "Host(`ag.l.m3tam3re.com`)";
            service = "ag";
            entrypoints = ["websecure"];
            tls = {
              certResolver = "godaddy";
            };
          };
          homarr = {
            rule = "Host(`dash.l.m3tam3re.com`)";
            service = "homarr";
            entrypoints = ["websecure"];
            tls = {
              certResolver = "godaddy";
            };
          };
          plex = {
            rule = "Host(`plex.l.m3tam3re.com`)";
            service = "plex";
            entrypoints = ["websecure"];
            tls = {
              certResolver = "godaddy";
            };
          };
          skynet = {
            rule = "Host(`skynet.l.m3tam3re.com`)";
            service = "homarr";
            entrypoints = ["websecure"];
            tls = {
              certResolver = "godaddy";
            };
          };
        };
      };
    };
  };

  systemd.services.traefik.serviceConfig = {
    EnvironmentFile = ["${config.age.secrets.traefik.path}"];
  };

  networking.firewall.allowedTCPPorts = [80 443];
}
