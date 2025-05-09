{
  virtualisation.oci-containers.containers."homarr" = {
    image = "ghcr.io/ajnart/homarr:latest";
    ports = ["7575:7575"];
    volumes = [
      "homarr-configs:/app/data/configs"
      "homarr-icons:/app/public/icons"
      "homarr-data:/data"
    ];
  };
}
