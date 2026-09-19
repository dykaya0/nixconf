{ lib, pkgs, ... }:
{
    system.stateVersion = "26.05";
    nix.settings.experimental-features = [
        "nix-command"
        "flakes"
    ];
    nix.settings.trusted-users = [
      "root"
      "@wheel"
    ];
    services.greetd = {
        enable = true;
        settings = {
            default_session = {
                user = "greeter";
                command = lib.getExe pkgs.tuigreet + " --time --remember --remember-session";
            };
        };
    };

    #services.displayManager.sddm.enable = true;
    #services.displayManager.sddm.wayland.enable = true;
    # Time and Networking
    time.timeZone = "Europe/Istanbul";
    nixpkgs.config.allowUnfree = true;
    i18n.defaultLocale = "en_GB.UTF-8";
    networking.networkmanager.enable = true;
    programs.nm-applet.enable = true;

    # Garbage collection
    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
    };

    fonts.fontconfig = {

        enable = true;
        hinting.enable = true;
        antialias = true;
    };
}
