{pkgs, ...}: {
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", MODE="0666
  '';
  environment.systemPackages = with pkgs; [
    zsa-udev-rules
  ];
}
