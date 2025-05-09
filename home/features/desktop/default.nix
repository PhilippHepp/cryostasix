{pkgs, ...}: {
  imports = [
    ./coding.nix
    ./crypto.nix
    ./fonts.nix
    ./gaming.nix
    ./hyprland.nix
    ./media.nix
    ./office.nix
    ./rofi.nix
    ./theme.nix
    ./wayland.nix
    ./wofi.nix
  ];

  xdg = {
    enable = true;
    configFile."mimeapps.list".force = true;
    mimeApps = {
      enable = true;
      associations.added = {
        "application/zip" = ["org.gnome.FileRoller.desktop"];
        "application/csv" = ["calc.desktop"];
        "application/pdf" = ["okularApplication_pdf.desktop"];
      };
      defaultApplications = {
        "application/zip" = ["org.gnome.FileRoller.desktop"];
        "application/csv" = ["calc.desktop"];
        "application/pdf" = ["okularApplication_pdf.desktop"];
        "application/md" = ["nvim.desktop"];
        "application/text" = ["nvim.desktop"];
        "x-scheme-handler/http" = ["io.github.zen_browser.zen"];
        "x-scheme-handler/https" = ["io.github.zen_browser.zen"];
      };
    };
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  home.sessionVariables = {
    WEBKIT_DISABLE_COMPOSITING_MODE = "1";
    NIXOS_OZONE_WL = "1";
    TERMINAL = "kitty";
    QT_QPA_PLATFORM = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
  };
  home.sessionPath = ["\${XDG_BIN_HOME}" "\${HOME}/.cargo/bin" "$HOME/.npm-global/bin"];

  fonts.fontconfig.enable = true;

  programs.kitty = {
    enable = true;
    shellIntegration = {
      enableFishIntegration = true;
      enableBashIntegration = true;
    };
    font = {name = "Fira Code";};
    themeFile = "Dracula";
    settings = {copy_on_select = "yes";};
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 20;
  };

  home.packages = with pkgs; [
    appimage-run
    temp.anytype
    # blueberry
    brave
    # brightnessctl
    # clipman
    distrobox
    # eww
    # firefox-devedition
    file-roller
    hyprpanel
    seahorse
    sushi
    # glib
    # google-chrome
    # gsettings-desktop-schemas
    # graphviz
    # ksnip
    msty
    msty-sidecar
    nwg-look
    # pamixer
    # pavucontrol
    # libsForQt5.qtstyleplugins
    # stable.nyxt
    # pcmanfm
    rose-pine-hyprcursor
    # qt5ct
    # qt6.qtwayland
    #rustdesk
    # socat
    # unrar
    # unzip
    # usbutils
    # v4l-utils
    remmina
    slack
    telegram-desktop
    vivaldi
    vivaldi-ffmpeg-codecs
    warp-terminal
    # wl-clipboard
    # wlogout
    # wtype
    # xdg-utils
    # ydotool
    # zip
  ];
}
