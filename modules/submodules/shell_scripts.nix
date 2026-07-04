{ pkgs }:

{
    tms = pkgs.writeShellScriptBin "tms" ''
        set -euo pipefail

        export PATH=${pkgs.fzf}/bin:${pkgs.fd}/bin:${pkgs.tmux}/bin:$PATH

        DIRS=(
                "$HOME/projects/personal"
                "$HOME/projects/work"
                "$HOME/projects/forked"
                "$HOME/projects/meta"
             )

        if [[ $# -eq 1 ]]; then
            selected=$(realpath "$1" 2>/dev/null) || exit 1
        else
            selected=$(
                    fd . "''${DIRS[@]}" --type d --max-depth 1 \
                    | sed "s|^$HOME/||" \
                    | fzf
                    )

                [[ -z $selected ]] && exit 0
                selected="$HOME/$selected"
                    fi

                    [[ ! -d $selected ]] && exit 1


                    selected_name=$(basename "$selected" | tr -cd '[:alnum:]_-')

                        if ! tmux has-session -t "$selected_name" &>/dev/null; then
                            tmux new-session -ds "$selected_name" -c "$selected"
                                fi

                                if [[ -z ''${TMUX-} ]]; then
                                    tmux attach -t "$selected_name"
                                else
                                    tmux switch-client -t "$selected_name"
                                        fi
                                        '';
    clipboard_history = pkgs.writeShellScriptBin "clipboard_history" ''
        set -euo pipefail

        export PATH=${pkgs.cliphist}/bin:${pkgs.rofi}/bin:${pkgs.wl-clipboard}/bin:$PATH

        cliphist list \
        | rofi -dmenu \
        -theme-str 'window { location: south; anchor: south; width: 100%; }' \
        -theme-str 'listview { lines: 6; }' \
        | cliphist decode \
        | wl-copy
        '';
    screenshot_menu = pkgs.writeShellScriptBin "screenshot_menu" ''
        set -euo pipefail

        export PATH=${pkgs.hyprshot}/bin:${pkgs.rofi}/bin:${pkgs.wl-clipboard}/bin:$PATH

        Region() {
            sleep 0.3
                hyprshot --freeze -m region
        }

    Monitor() {
        sleep 0.3
            hyprshot --freeze -m output
    }

    Window() {
        sleep 0.3
            hyprshot --freeze -m window
    }

    Region_clipboard() {
        sleep 0.3
            hyprshot --clipboard-only --freeze -m region
    }

    takeScreenshot() {
        choice=$(
                printf "Region\\nMonitor\\nWindow\\nRegion_clipboard" \
                | rofi -dmenu -l 4 -i -p "Choose output:"
                )

        case "$choice" in
            Region) Region ;;
            Monitor) Monitor ;;
            Window) Window ;;
            Region_clipboard) Region_clipboard ;;
            esac
    }

    if [[ $# -gt 0 ]]; then
        "$1"
    else
        takeScreenshot
            fi
            '';

    switch_audio = pkgs.writeShellScriptBin "switch_audio" ''
        export PATH="${pkgs.pulseaudio}/bin:${pkgs.gawk}/bin:${pkgs.gnused}/bin:${pkgs.gnugrep}/bin:${pkgs.coreutils}/bin:${pkgs.rofi}/bin:${pkgs.libnotify}/bin"

        get_sinks() {
            pactl list short sinks | awk '{print $2}' | sed 's/^alsa_output\.//'
        }

    switchAudio() {
        local sinks
            sinks=$(get_sinks)
            local count
            count=$(echo "$sinks" | wc -l)

            choice=$(echo "$sinks" | rofi -dmenu -i -l "$count" -p "Choose output:")

            [[ -z "$choice" ]] && exit 0

            local full_sink
                full_sink=$(pactl list short sinks | awk '{print $2}' | grep -F "$choice")

                if [[ -n "$full_sink" ]]; then
                    pactl set-default-sink "$full_sink"
                        notify-send "Audio switched to $choice"
                else
                    notify-send "Sink not found"
                        fi
    }

    if [[ $# -gt 0 ]]; then
        "$1"
    else
        switchAudio
            fi
            '';
    waybar_refresh = pkgs.writeShellScriptBin "waybar_refresh" ''
        set -euo pipefail
        export PATH=${pkgs.procps}/bin:$PATH

        pkill -SIGUSR2 waybar
        '';

    xkblayout = pkgs.writeShellScriptBin "xkblayout" ''
      export PATH="${pkgs.hyprland}/bin:${pkgs.jq}/bin:${pkgs.rofi}/bin:$PATH"

      set -euo pipefail

      device=$(hyprctl devices -j | jq -r '.keyboards[].name' | rofi -dmenu -p "Device")

      [ -z "$device" ] && exit 0

      direction=$(printf "next\nprev" | rofi -dmenu -p "Direction")

      [ -z "$direction" ] && exit 0

      hyprctl switchxkblayout "$device" "$direction"
    '';
}
