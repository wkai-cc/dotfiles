#!/bin/bash

WPS_FILES=("/usr/bin/wps" "/usr/bin/et" "/usr/bin/wpp")

ENV_BLOCK="export LANG=zh_CN.UTF-8
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export QT_QPA_PLATFORM=xcb"

for file in "${WPS_FILES[@]}"; do
    if [ -f "$file" ]; then
        if grep -q "QT_QPA_PLATFORM=xcb" "$file"; then
            echo "[跳过] $file 已经修复过。"
        else
            echo "[处理] $file"
            sudo bash -c "head -n 1 $file > ${file}.tmp"
            sudo bash -c "echo '$ENV_BLOCK' >> ${file}.tmp"
            sudo bash -c "tail -n +2 $file >> ${file}.tmp"
            sudo mv "${file}.tmp" "$file"
            sudo chmod +x "$file"
            echo "      $file 修复完成。"
        fi
    fi
done
