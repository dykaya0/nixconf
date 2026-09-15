{ config, pkgs, ... }:

let
  wallpaperScript = pkgs.writeShellApplication {
    name = "wallpaper-changer";
    runtimeInputs = with pkgs; [ awww coreutils findutils procps ];
    text = builtins.readFile ./wallpaper-changer.sh;
  };
in
{
  home.packages = [ wallpaperScript ];

  systemd.user.services.wallpaper-changer = {
    Unit = {
      Description = "Set wallpaper based on time of day";
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${wallpaperScript}/bin/wallpaper-changer";
      Environment = [
        "WALLPAPER_DIR=%h/pictures/wallpapers"
      ];
      Restart = "on-failure";
      RestartSec = "5s";
    };
  };

  # Fires exactly at each time-of-day boundary rather than polling.
  # Keep these in sync with the hour ranges in wallpaper-changer.sh.
  systemd.user.timers.wallpaper-changer = {
    Unit.Description = "Trigger wallpaper-changer at each time-of-day boundary";
    Timer = {
      OnCalendar = [
        "*-*-* 05:00:00" # early
        "*-*-* 08:00:00" # morning
        "*-*-* 12:00:00" # afternoon
        "*-*-* 17:00:00" # evening
        "*-*-* 20:00:00" # night
      ];
      Persistent = true; # catch up if the machine was asleep at a boundary
    };
    Install.WantedBy = [ "timers.target" ];
  };
}
