{
  hardware.nvidia = {
    prime = {
      offload.enable = false;

      # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
      intelBusId = "PCI:0:2:0";

      # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
      nvidiaBusId = "PCI:1:0:0";
    };
    modesetting.enable = true;
    powerManagement.finegrained = false;
    powerManagement.enable = true;
    open = false;
    dynamicBoost.enable = true;
    nvidiaSettings = true;
  };
  hardware.bluetooth.enable = true;
  hardware.keyboard.zsa.enable = true;
  hardware.graphics.enable = true;

  services.hardware.bolt.enable = true;
  services.auto-cpufreq.enable = true;
  services.tlp.enable = true;
}
