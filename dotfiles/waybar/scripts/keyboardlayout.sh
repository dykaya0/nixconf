#!/usr/bin/env bash

KEYBOARDNAME=$KEYBOARD
layout=$(hyprctl devices -j | jq -r ".keyboards[] | select(.name == \"$KEYBOARDNAME\") | .active_keymap")

isReady() {
    if [[ -z "$layout" ]]; then
        notify-send "Error: Keyboard layout couldn't fetched in waybar/scripts/keyboard.sh script $layout"
        exit 1
    fi
}

getLayout () {
# Map key layout to CSS class
case "$layout" in
    "English (UK)")
        class="english"
        ;;
    "Turkish")
        class="turkish"
        ;;
    "German")
        class="german"
        ;;
    *)
        class="unknown"
        ;;
esac

printf '{"text":"%s","tooltip":"%s","class":"%s"}\n' "$layout" "$layout" "$class"

}

if [[ $# -gt 0 ]]; then
    "$1"
else
    getLayout
fi

