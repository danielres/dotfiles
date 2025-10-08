#!/usr/bin/env sh
current_ws=$(hyprctl activeworkspace -j | jq -r '.id')

pkill wofi

hyprctl clients -j |
  sed "s/special:minimized/_/g" |
  sed "s/WaybarPopup/(floating)/g" |
  jq -r --arg ws "$current_ws" '
      sort_by(.workspace.id)[] |
      select(.workspace.id != ($ws | tonumber)) |
      "󰍹  \(.workspace.name)\t\t\((.class|split(".")|last))\t\t\(.title)\t<span alpha=\"1\">|\(.address)</span>"' |
  nl -w2 -s$'\t' |
  wofi --dmenu |
  awk -F'|' '{print $2}' |
  awk -F'<' '{print $1}' |
  xargs -I {} hyprctl dispatch movetoworkspace "$current_ws",address:{}
