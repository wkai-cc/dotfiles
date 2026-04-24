#!/bin/bash

# 获取当前信息
metadata=$(playerctl metadata --format "{{title}} - {{artist}}")
[ -z "$metadata" ] && metadata="No Media Playing"

# 定义菜单选项 (使用 Nerd Fonts)
entries="󰐊 Play/Pause\n󰒭 Next Track\n󰒮 Previous Track\n󰝚 Stop Player"

# 调用 wofi 弹出菜单
# --location 3 表示右上角，你可以根据需要调整
selected=$(echo -e "$entries" | wofi --dmenu --prompt "$metadata" --width 250 --height 200 --location 3 --x offset -50 --y offset 50 --cache-file /dev/null)

case $selected in
*"Play/Pause"*) playerctl play-pause ;;
*"Next"*) playerctl next ;;
*"Previous"*) playerctl previous ;;
*"Stop"*) playerctl stop ;;
esac
