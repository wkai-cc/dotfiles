#!/usr/bin/env bash

set -euo pipefail

TMP="/tmp/voice-input.wav"
RESULT="/tmp/voice-result"

PIDFILE="/tmp/voice-input-record.pid"

MODEL="$HOME/.local/share/whisper/ggml-medium.bin"

# 2K USB Camera 麦克风
DEVICE="alsa_input.usb-SN0002_2K_USB_Camera_46435000_P030300_SN0002-02.mono-fallback"


cleanup_files()
{
    rm -f "$TMP"
    rm -f "$RESULT.txt"
}


notify()
{
    notify-send \
        --app-name="Voice Input" \
        "$1" \
        "$2"
}


start_record()
{
    cleanup_files

    echo "🎤 Recording..."

    notify \
        "Voice Input" \
        "🎤 Recording started"


    # 后台录音
    pw-record \
        --target "$DEVICE" \
        "$TMP" &


    echo $! > "$PIDFILE"
}


stop_record()
{
    echo "⏹ Stop recording"

    notify \
        "Voice Input" \
        "⏹ Processing..."


    if [[ -f "$PIDFILE" ]]; then

        PID=$(cat "$PIDFILE")

        # 正常结束录音，确保 wav 文件写入完成
        kill -SIGINT "$PID" 2>/dev/null || true

        rm -f "$PIDFILE"

        sleep 1
    fi


    if [[ ! -s "$TMP" ]]; then

        notify \
            "Voice Input" \
            "❌ No audio recorded"

        exit 1
    fi


    echo "🧠 Transcribing..."


    whisper-cli \
        -m "$MODEL" \
        -f "$TMP" \
        -l zh \
        --temperature 0 \
        --no-timestamps \
        -otxt \
        -of "$RESULT" \
        >/dev/null 2>&1


    if [[ ! -f "$RESULT.txt" ]]; then

        notify \
            "Voice Input" \
            "❌ No transcription"

        exit 1
    fi


    # 合并换行，避免输入时出现多行
    TEXT=$(sed ':a;N;$!ba;s/\n/ /g' "$RESULT.txt")


    if [[ -z "$TEXT" ]]; then

        notify \
            "Voice Input" \
            "❌ Empty result"

        exit 1
    fi


    echo "📝 $TEXT"


    # 写入剪贴板
    printf "%s" "$TEXT" | wl-copy


    # 模拟 Ctrl+V
    sleep 0.15

    ydotool key \
        29:1 \
        47:1 \
        47:0 \
        29:0


    notify \
        "Voice Input" \
        "✅ Done"


    cleanup_files
}


# 检查模型
if [[ ! -f "$MODEL" ]]; then

    notify \
        "Voice Input" \
        "❌ Model missing"

    exit 1
fi


# 第一次按键开始，第二次按键结束
if [[ -f "$PIDFILE" ]]; then

    stop_record

else

    start_record

fi
