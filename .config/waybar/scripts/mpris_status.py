#!/usr/bin/env python3
import json
import subprocess
import os


def get_mpris_data():
    try:
        # 获取状态和元数据
        status = subprocess.check_output(
            ["playerctl", "-p", "yesplaymusic", "status"], text=True
        ).strip()
        title = subprocess.check_output(
            ["playerctl", "-p", "yesplaymusic", "metadata", "title"], text=True
        ).strip()
        artist = subprocess.check_output(
            ["playerctl", "-p", "yesplaymusic", "metadata", "artist"], text=True
        ).strip()

        data = {
            "text": f"{title} - {artist}",
            "alt": status,
            "class": status,
            "tooltip": f"YesPlayMusic: {title}",
        }
        print(json.dumps(data, ensure_ascii=False))
    except:
        # 如果没有播放器运行，输出空 JSON
        print(json.dumps({"text": "", "class": "stopped"}))


if __name__ == "__main__":
    get_mpris_data()
