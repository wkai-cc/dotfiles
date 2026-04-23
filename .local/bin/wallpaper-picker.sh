#!/bin/bash

# 配置路径
WALLPAPER_DIR="$HOME/Pictures/wallpaper/"
VARS_FILE="$HOME/.config/sway/variables"

# 1. 选择壁纸
SELECTED=$(ls "$WALLPAPER_DIR" | grep -E ".jpg$|.png$|.jpeg$|.webp$" | rofi -dmenu -i -p "󰸉 切换主题:")
[ -z "$SELECTED" ] && exit 0
FULL_PATH="$WALLPAPER_DIR/$SELECTED"

# 2. 立即更新当前壁纸 (swaybg)
pkill swaybg
swaybg -i "$FULL_PATH" -m fill &

# 3. 持久化：修改变量文件
sed -i "s|^set \$wallpaper .*|set \$wallpaper $FULL_PATH|" "$VARS_FILE"
# 4.实时通知 Sway 更新内存中的变量值，无需重启或重载 ---
swaymsg "set \$wallpaper $FULL_PATH"

# 5. 通知
notify-send "主题已同步" "桌面与锁屏已指向：$SELECTED" -i "$FULL_PATH"
