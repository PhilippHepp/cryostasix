{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.features.desktop.hyprland;
in {
  imports = [
    ../common
    ./dotfiles
    ./home.nix
    ../features/cli
    ../features/coding
    ../features/desktop
    ./services/librechat.nix
  ];

  options.features.desktop.hyprland.enable =
    mkEnableOption "enable Hyprland";

  config = mkMerge [
    # Base configuration
    {
      xdg = {
        # TODO: better structure
        enable = true;
        configFile."mimeapps.list".force = true;
        mimeApps = {
          enable = true;
          associations.added = {
            "application/zip" = ["org.gnome.FileRoller.desktop"];
            "application/csv" = ["calc.desktop"];
            "application/pdf" = ["vivaldi-stable.desktop"];
            "x-scheme-handler/http" = ["vivaldi-stable.desktop"];
            "x-scheme-handler/https" = ["vivaldi-stable.desktop"];
          };
          defaultApplications = {
            "application/zip" = ["org.gnome.FileRoller.desktop"];
            "application/csv" = ["calc.desktop"];
            "application/pdf" = ["vivaldi-stable.desktop"];
            "application/md" = ["dev.zed.Zed.desktop"];
            "application/text" = ["dev.zed.Zed.desktop"];
            "x-scheme-handler/http" = ["vivaldi-stable.desktop"];
            "x-scheme-handler/https" = ["vivaldi-stable.desktop"];
          };
        };
      };
      features = {
        cli = {
          nushell.enable = true;
          skim.enable = true;
          nitch.enable = true;
          secrets.enable = true;
          starship.enable = true;
        };
        desktop = {
          crypto.enable = true;
          coding.enable = true;
          gaming.enable = true;
          hyprland.enable = true;
          media.enable = true;
          office.enable = true;
          rofi.enable = true;
          fonts.enable = true;
          wayland.enable = true;
        };
      };
    }

    (mkIf cfg.enable {
      wayland.windowManager.hyprland = {
        enable = true;
        settings = {
          monitor = [
            "DP-1,2560x1440@144,0x0,1"
            "DP-2,2560x1440@144,2560x0,1"
          ];
          workspace = [
            "1, monitor:DP-1, default:true"
            "2, monitor:DP-1"
            "3, monitor:DP-1"
            "4, monitor:DP-2"
            "5, monitor:DP-2"
            "6, monitor:DP-2"
            "7, monitor:DP-2"
          ];

          windowrule = [
            "workspace 1,class:dev.zed.Zed"
            "workspace 1,class:Msty"
            "workspace 2,class:(com.obsproject.Studio)"
            "workspace 4,opacity 1.0, class:(brave-browser)"
            "workspace 4,opacity 1.0, class:(vivaldi-stable)"
            "idleinhibit focus, class:^steam_app_\\d+$"
          ];
        };
      };
    })
  ];
}
