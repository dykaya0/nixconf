{ config, ... }:

{

  hardware.graphics = {
      enable = true;
      enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    powerManagement.enable = false; # Make it true if having wakeup/sleep issues
  };
}
