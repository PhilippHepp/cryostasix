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
    #./services/librechat.nix
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
          fish.enable = true;
          nushell.enable = true;
          skim.enable = true;
          nitch.enable = true;
          secrets.enable = true;
          starship.enable = true;
        };
        desktop = {
          coding.enable = true;
          crypto.enable = true;
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
            "eDP-1,preferred,0x0,1.25"
            "HDMI-A-1,preferred,2560x0,1"
          ];
          workspace = [
            "1, monitor:eDP-1, default:true"
            "2, monitor:eDP-1"
            "3, monitor:eDP-1"
            "4, monitor:HDMI-A-1"
            "5, monitor:HDMI-A-1,border:false,rounding:false"
            "6, monitor:HDMI-A-1"
          ];
          windowrule = [
            "workspace 1,class:dev.zed.Zed"
            "workspace 1,class:Msty"
            "workspace 2,class:(com.obsproject.Studio)"
            "workspace 4,opacity 1.0, class:(brave-browser)"
            "workspace 4,opacity 1.0, class:(vivaldi-stable)"
            "fullscreen,class:^steam_app_\\d+$"
            "workspace 5,class:^steam_app_\\d+$"
            "idleinhibit focus, class:^steam_app_\\d+$"
          ];
        };
      };
    })
  ];
}
