{ pkgs, ... }:
{
  services.mysql = {
    enable = true;
    package = pkgs.mysql84;
    ensureDatabases = [
      "mond"
      "toechter"
    ];
    initialScript = pkgs.writeText "initial-script.sql" ''
      CREATE USER 'mond'@'10.200.%' IDENTIFIED BY 'mond';
      GRANT ALL PRIVILEGES ON mond.* TO 'mond'@'10.200.%';

      CREATE USER 'toechter'@'10.200.%' IDENTIFIED BY 'toechter';
      GRANT ALL PRIVILEGES ON toechter.* TO 'toechter'@'10.200.%'; '';
  };
  services.mysqlBackup = {
    enable = true;
    calendar = "03:00:00";
    databases = [
      "mond"
      "toechter"
    ];
  };
  networking.firewall.allowedTCPPorts = [ 3306 ];
}
