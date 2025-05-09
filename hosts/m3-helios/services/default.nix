{
  imports = [
    ./adguard.nix
    ./containers
    ./traefik.nix
  ];
  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernation=no
    AllowHybridSleep=no
    AllowSuspendThenHibernate=no
  '';
}
