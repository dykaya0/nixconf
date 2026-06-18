{ pkgs, ... }:

{
    system.stateVersion = "26.05";
    nix.settings.experimental-features = [
        "nix-command"
        "flakes"
    ];

    time.timeZone = "Europe/Istanbul";

    i18n.defaultLocale = "en_GB.UTF-8";

    networking.networkmanager.enable = true;

    programs.git.enable = true;
    programs.bash.enable = true;

    environment.systemPackages = with pkgs; [
        curl
        wget
        vim
    ];
}
