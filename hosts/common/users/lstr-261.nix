{
  config,
  pkgs,
  inputs,
  ...
}:
{
  users.users.lstr-261 = {
    #initialHashedPassword = "$y$j9T$IoChbWGYRh.rKfmm0G86X0$bYgsWqDRkvX.EBzJTX.Z0RsTlwspADpvEF3QErNyCMC";
    password = "signalis";
    isNormalUser = true;
    description = "lstr-261";
    extraGroups = [
      "wheel"
      "networkmanager"
      "libvirtd"
      "flatpak"
      "audio"
      "video"
      "plugdev"
      "input"
      "kvm"
      "qemu-libvirtd"
      "adbusers"
    ];
    openssh.authorizedKeys.keys = [
    ];
    packages = [ inputs.home-manager.packages.${pkgs.system}.default ];
  };
  home-manager.users.lstr-261 = import ../../../home/lstr-261/${config.networking.hostName}.nix;
}
