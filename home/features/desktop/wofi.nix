{pkgs, ...}: {
  home.packages = with pkgs; [
    wofi
    bemoji
  ];
}
