{ inputs, pkgs, ... }:

{
    imports = [
        inputs.qylock.nixosModules.default
    ];
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;

    environment.systemPackages = with pkgs; [
            gst_all_1.gstreamer
            gst_all_1.gst-plugins-base
            gst_all_1.gst-plugins-good
            gst_all_1.gst-plugins-bad
            gst_all_1.gst-plugins-ugly
            gst_all_1.gst-libav
    ];

    programs.qylock = {
        enable = true;
        theme = "last-of-us";
            sddm.enable = true;
            quickshell.enable = true;

            #themeOptions = {
            #};
    };
}
