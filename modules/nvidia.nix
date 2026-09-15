{ config, pkgs,lib, ... }:

{

  hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
          libva-vdpau-driver
              libvdpau-va-gl
              nvidia-vaapi-driver
      ];
  };

  environment.sessionVariables = {
    QT_PLUGIN_PATH = "${pkgs.qt6.qtmultimedia}/lib/qt-6/plugins";
    GST_PLUGIN_SYSTEM_PATH_1_0 = lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" (with pkgs.gst_all_1; [
      gstreamer gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-libav
    ]);
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
