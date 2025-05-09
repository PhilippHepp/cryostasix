{
  systemd.user.services.librechat = {
    Unit = {
      Description = "LibreChat Start";
      After = ["network-online.target"];
      Wants = ["network-online.target"];
    };
    Install = {WantedBy = ["default.target"];};
    Service = {
      Type = "oneshot";
      RemainAfterExit = "yes";
      WorkingDirectory = "/home/m3tam3re/p/r/ai/LibreChat";
      ExecStart = "/run/current-system/sw/bin/podman-compose up -d";
      ExecStop = "/run/current-system/sw/bin/podman-compose down";
      Restart = "on-failure";
    };
  };
}
