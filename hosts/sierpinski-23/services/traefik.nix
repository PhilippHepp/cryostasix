{ config, ... }:
{
  services.traefik = {
    enable = true;
    staticConfigOptions = {
      log = {
        level = "WARN";
      };
      certificatesResolvers = {
        godaddy = {
          acme = {
            email = "letsencrypt.org.btlc2@passmail.net";
            storage = "/var/lib/traefik/acme.json";
            caserver = "https://acme-v02.api.letsencrypt.org/directory";
            dnsChallenge = {
              provider = "godaddy";
              resolvers = [
                "1.1.1.1:53"
                "8.8.8.8:53"
              ];
              propagation = {
                delayBeforeChecks = 60;
                disableChecks = true;
              };
            };
          };
        };
      };
      api = { };
      entryPoints = {
        web = {
          address = ":80";
          http.redirections.entryPoint = {
            to = "websecure";
            scheme = "https";
          };
        };
        rtmp = {
          address = ":1935";
        };
        rtmps = {
          address = ":1945";
        };
        websecure = {
          address = ":443";
        };
      };
    };
    dynamicConfigOptions = {
      http = {
        services = {
          dummy = {
            loadBalancer.servers = [
              { url = "http://192.168.0.1"; } # Diese URL wird nie verwendet
            ];
          };
        };
        middlewares = {
          domain-redirect = {
            redirectRegex = {
              regex = "^https://www\\.lstr-261\\.com(.*)";
              replacement = "https://lstr.dev$1";
              permanent = true;
            };
          };
          strip-www = {
            redirectRegex = {
              regex = "^https://www\\.(.+)";
              replacement = "https://$1";
              permanent = true;
            };
          };
          subdomain-redirect = {
            redirectRegex = {
              regex = "^https://([a-zA-Z0-9-]+)\\.lstr-261\\.com(.*)";
              replacement = "https://$1.lstr.dev$2";
              permanent = true;
            };
          };
          auth = {
            basicAuth = {
              users = [ "lstr-261:$apr1$1xqdta2b$DIVNvvp5iTUGNccJjguKh." ];
            };
          };
        };

        routers = {
          api = {
            rule = "Host(`r.lstr-261.com`)";
            service = "api@internal";
            middlewares = [ "auth" ];
            entrypoints = [ "websecure" ];
            tls = {
              certResolver = "godaddy";
            };
          };
        };
      };
    };
  };

  systemd.services.traefik.serviceConfig = {
    EnvironmentFile = [ "${config.age.secrets.traefik.path}" ];
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
