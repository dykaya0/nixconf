#!/usr/bin/env bash

updates_file="${XDG_RUNTIME_DIR:-$HOME/.cache}/package_updates"

isReady() {
    if ! command -v paru >/dev/null 2>&1 || ! command -v ghostty >/dev/null 2>&1; then
        notify-send "paru or ghostty is not installed"
        exit 1
    fi
}

check() {
    {
        checkupdates 2>/dev/null
        paru -Qu 2>/dev/null
    } | sort -u > "$updates_file"
}

status() {
    if [ -f "$updates_file" ];then
        updates=$(cat "$updates_file")
        count=$(wc -l < "$updates_file")
        
        if [ "$count" -eq 0 ]; then
            jq -cn '{"text":"","tooltip":"System is up to date"}'

        elif [ "$count" -lt 25 ]; then
            jq -cn --arg u "$updates" --arg c "$count" \
                '{"text":" \($c)","class":"low","tooltip":$u}'

        elif [ "$count" -lt 80 ]; then
            jq -cn --arg u "$updates" --arg c "$count" \
                '{"text":" \($c)","class":"mid","tooltip":$u}'

        else
            jq -cn --arg u "$updates" --arg c "$count" \
                '{"text":" \($c)","class":"high","tooltip":$u}'
        fi
    else
        check
        jq -cn '{"text":"X","tooltip":"Error: on waybar/scripts/package-updates.sh"}'
    fi
}

update() {
    kitty -e paru -Syu --noconfirm

    check
}


if [[ $# -gt 0 ]]; then
    "$1"
else
    check
fi
