{
  services.restic.backups = {
    skynet = {
      repository = "/mnt/skynet-bkg/m3-nix";
      passwordFile = "/etc/nixos/restic-pass";
      initialize = true;
      paths = ["/home/m3tam3re"];
      exclude = [
        "/home/m3tam3re/.cache"
        "/home/m3tam3re/Bilder/"
        "/home/m3tam3re/Videos/"
        "/home/m3tam3re/Downloads"
        "/home/m3tam3re/Library"
        "/home/m3tam3re/Projekte"
        "/home/m3tam3re/Sync"
        "/home/m3tam3re/.local/share/Trash"
      ];
      timerConfig = {
        OnCalendar = "09:30";
        RandomizedDelaySec = "2h";
        Persistent = true;
      };
    };
  };
}
