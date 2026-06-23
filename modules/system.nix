{ ... }:
{
    system.stateVersion = "26.05";
    nix.settings.experimental-features = [
        "nix-command"
        "flakes"
    ];

    # Time and Networking
    time.timeZone = "Europe/Istanbul";
    nixpkgs.config.allowUnfree = true;
    i18n.defaultLocale = "en_GB.UTF-8";
    networking.networkmanager.enable = true;
    programs.nm-applet.enable = true;
}
