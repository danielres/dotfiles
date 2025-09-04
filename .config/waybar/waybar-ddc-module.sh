#!/usr/bin/env bash
set -euo pipefail

BUS=5
NAME="mon"
STEP=5

# parse args: --bus N --name LABEL
while [[ $# -gt 0 ]]; do
  case "$1" in
  --bus)
    BUS="$2"
    shift 2
    ;;
  --name)
    NAME="$2"
    shift 2
    ;;
  --step)
    STEP="$2"
    shift 2
    ;;
  *)
    echo "unknown arg: $1" >&2
    exit 2
    ;;
  esac
done

RX="/tmp/waybar-ddc-${NAME}-rx"

ddc_fast() { ddcutil --noverify --bus "$BUS" --sleep-multiplier .03 "$@" 2>/dev/null; }
ddc_slow() { ddcutil --maxtries 15,15,15 --bus "$BUS" "$@" 2>/dev/null; }

print_brightness() {
  local out val
  if out=$(ddc_slow -t getvcp 10); then
    val=$(printf '%s' "$out" | awk '{print $4}' | tr -d ',')
  else
    val=-1
  fi
  [[ -z "${val//[0-9-]/}" ]] || val=-1
  ((val < 0)) && val=0
  ((val > 100)) && val=100
  printf '{"percentage": %d}\n' "$val"
}

rm -f "$RX"
mkfifo "$RX"

print_brightness

while read -r cmd <"$RX"; do
  case "$cmd" in
  + | -) ddc_fast setvcp 10 "$cmd" "$STEP" ;;
  max) ddc_fast setvcp 10 100 ;;
  min) ddc_fast setvcp 10 0 ;;
  esac
  print_brightness
done
##!/usr/bin/env bash
#set -euo pipefail
#
#receive_pipe="/tmp/waybar-ddc-module-rx"
#step=5
#
#ddcutil_fast() { ddcutil --noverify --bus 5 --sleep-multiplier .03 "$@" 2>/dev/null; }
#ddcutil_slow() { ddcutil --maxtries 15,15,15 "$@" 2>/dev/null; }
#
#print_brightness() {
#  local out brightness
#  if out=$("$@" -t getvcp 10); then
#    brightness=$(printf '%s' "$out" | awk '{print $4}' | tr -d ',')
#  else
#    brightness=-1
#  fi
#  [[ -z "${brightness//[0-9-]/}" ]] || brightness=-1
#  ((brightness < 0)) && brightness=0
#  ((brightness > 100)) && brightness=100
#  printf '{"percentage": %d}\n' "$brightness"
#}
#
#rm -f "$receive_pipe"
#mkfifo "$receive_pipe"
#
#print_brightness ddcutil_slow
#
#while read -r command <"$receive_pipe"; do
#  case $command in
#  + | -) ddcutil_fast setvcp 10 "$command" "$step" ;;
#  max) ddcutil_fast setvcp 10 100 ;;
#  min) ddcutil_fast setvcp 10 0 ;;
#  esac
#  print_brightness ddcutil_fast
#done
