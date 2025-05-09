{config, ...}: {
  networking.wg-quick.interfaces = {
    DE = {
      configFile = config.age.secrets.wg-DE.path;
      autostart = false;
    };
    NL = {
      configFile = config.age.secrets.wg-NL.path;
      autostart = false;
    };
    NO = {
      configFile = config.age.secrets.wg-NO.path;
      autostart = true;
    };
    US = {
      configFile = config.age.secrets.wg-US.path;
      autostart = false;
    };
    BR = {
      configFile = config.age.secrets.wg-BR.path;
      autostart = false;
    };
  };
  services.resolved.enable = true;
}
