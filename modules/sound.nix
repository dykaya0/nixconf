{ ... }:
{
    services.pipewire = {
        enable = true;
        pulse.enable = true;
    };
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = false;
}
