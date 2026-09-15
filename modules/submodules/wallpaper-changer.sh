#!/usr/bin/env bash
set -euo pipefail

# --- Configuration (override via environment, e.g. from the systemd unit) ---
WALLPAPER_DIR="${WALLPAPER_DIR:-$HOME/pictures/wallpapers}"
TRANSITION="${WALLPAPER_TRANSITION:-wave}"
FALLBACK_WALLPAPER="${WALLPAPER_DIR}/default.png"

STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/wallpaper-changer"
STATE_FILE="$STATE_DIR/last"
mkdir -p "$STATE_DIR"

log() { echo "[wallpaper-changer] $*" >&2; }

# --- Time-of-day bucket (edit ranges to taste; keep in sync with the
#     systemd timer's OnCalendar entries if you use those) ---
hour=$(date +%-H)
if   (( hour >= 5  && hour < 8  )); then time_cat="early"
elif (( hour >= 8  && hour < 12 )); then time_cat="morning"
elif (( hour >= 12 && hour < 17 )); then time_cat="afternoon"
elif (( hour >= 17 && hour < 20 )); then time_cat="evening"
else                                     time_cat="night"
fi

log "time=$time_cat"

has_images() {
  find "$1" -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) -print -quit 2>/dev/null | grep -q .
}

candidates=(
  "$WALLPAPER_DIR/$time_cat"
  "$WALLPAPER_DIR/any"
)

target_dir=""
for dir in "${candidates[@]}"; do
  if [[ -d "$dir" ]] && has_images "$dir"; then
    target_dir="$dir"
    break
  fi
done

last_wallpaper=""
[[ -f "$STATE_FILE" ]] && last_wallpaper=$(cat "$STATE_FILE")

if [[ -z "$target_dir" ]]; then
  log "no matching wallpaper directory with images found, using fallback"
  wallpaper="$FALLBACK_WALLPAPER"
else
  mapfile -t options < <(find "$target_dir" -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \))
  # avoid repeating the same pick twice in a row, when there's a choice
  if (( ${#options[@]} > 1 )) && [[ -n "$last_wallpaper" ]]; then
    filtered=()
    for f in "${options[@]}"; do
      [[ "$f" != "$last_wallpaper" ]] && filtered+=("$f")
    done
    (( ${#filtered[@]} > 0 )) && options=("${filtered[@]}")
  fi
  wallpaper="${options[RANDOM % ${#options[@]}]}"
fi

if [[ ! -f "$wallpaper" ]]; then
  log "resolved path '$wallpaper' doesn't exist, aborting"
  exit 1
fi

log "setting wallpaper: $wallpaper"

if ! pgrep -x awww-daemon > /dev/null; then
  awww-daemon &
  sleep 1
fi

awww img "$wallpaper" --transition-type "$TRANSITION" --transition-duration 1.5 --transition-fps 60

printf '%s' "$wallpaper" > "$STATE_FILE"
