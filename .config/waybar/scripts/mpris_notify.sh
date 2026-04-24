#!/bin/bash
playerctl metadata --format '{{title}} - {{artist}}' --follow | while read -r line; do
    # 提取封面图 URL (Spotify/MPV 等支持)
    arturl=$(playerctl metadata mpris:artUrl)
    # 发送通知
    notify-send "Now Playing" "$line" -i "$arturl" -a "MusicPlayer" -t 3000
done
