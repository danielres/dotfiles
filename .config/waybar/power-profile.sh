#!/usr/bin/env bash
set -euo pipefail

data="$(powerprofilesctl get)"

case "$data" in
performance) icon="󰓅" ;;
balanced) icon="󰾅" ;;
power-saver) icon="󰾆" ;;
*) icon="󱐋" ;; # fallback
esac

# text = what’s shown, class = CSS class to target
echo "{\"text\": \"$icon\", \"class\": \"$data\", \"tooltip\": \"Power profile: $data\"}"
