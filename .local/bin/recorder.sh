#!/bin/bash

# --- 强制注入环境变量 ---
# 确保脚本后台进程能找到 Wayland 窗口服务
export WAYLAND_DISPLAY="wayland-1"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"

# --- 配置区 ---
# 录像保存目录
SAVE_DIR="$HOME/Videos/ScreenRecording"
mkdir -p "$SAVE_DIR"

# 临时日志文件，用于排查启动失败
LOG_FILE="/tmp/wf-recorder.log"

# --- 停止逻辑 ---
# 如果已经在录制，则停止
if pgrep -x "wf-recorder" >/dev/null; then
    pkill -INT wf-recorder
    pkill -x wshowkeys # 停止录制时关闭按键显示
    # pkill -SIGUSR2 waybar      # 强制 Waybar 刷新（去掉红点）
    # 获取最后一个生成的录像文件名（用于通知显示）
    LAST_FILE=$(ls -t "$SAVE_DIR" | head -1)
    notify-send "录屏已停止" "文件已保存: \n$LAST_FILE" -i camera-video -t 5000
    exit 0
fi

# --- 启动前准备 ---
if [ "$1" == "full" ]; then
    FILENAME="$SAVE_DIR/全屏_$(date +%Y%m%d_%H%M%S).mp4"
    MODE_MSG="全屏录制"
    # 拉起屏幕显示按键
    setsid wshowkeys -a bottom -m 10 -b "#2b3339aa" -f "#a7c080" >/dev/null 2>&1 &
    REC_CMD="wf-recorder --audio -c hevc_vaapi -d /dev/dri/renderD128 -f $FILENAME"

else
    FILENAME="$SAVE_DIR/区域_$(date +%Y%m%d_%H%M%S).mp4"
    MODE_MSG="区域录制"
    notify-send "录屏准备" "请选择录制区域..." -i camera-video -t 2000

    # 【修复重点】等待 3 秒避开 slurp 冻结期，同样改用短参数
    (sleep 3 && setsid wshowkeys -a bottom -m 10 -b "#2b3339aa" -f "#a7c080" >/dev/null 2>&1) &

    REC_CMD="wf-recorder -g \"$(slurp)\" --audio -c hevc_vaapi -d /dev/dri/renderD128 -f $FILENAME"
fi

# --- 启动录制 ---
# 尝试使用硬件加速启动
eval "$REC_CMD" >"$LOG_FILE" 2>&1 &

# 等待一会检查是否启动成功
sleep 0.6

if pgrep -x "wf-recorder" >/dev/null; then
    # pkill -SIGUSR2 waybar # 启动成功后强制 Waybar 刷新（显示红点）
    notify-send "$MODE_MSG" "状态: 正在录制\n编码: AMD 硬件加速 (HEVC)" -i camera-video -t 3000
else
    # 如果硬件加速失败（通常是 iGPU 报错），尝试 CPU 软解保底
    notify-send "硬件加速失败" "正在尝试 CPU 兼容模式..." -u normal

    if [ "$1" == "full" ]; then
        wf-recorder --audio -f "$FILENAME" >>"$LOG_FILE" 2>&1 &
    else
        wf-recorder -g "$(slurp)" --audio -f "$FILENAME" >>"$LOG_FILE" 2>&1 &
    fi

    sleep 0.6
    if pgrep -x "wf-recorder" >/dev/null; then
        # pkill -SIGUSR2 waybar  # 保底模式启动成功也要刷新 Waybar
        notify-send "$MODE_MSG" "状态: 正在录制\n编码: CPU 软件编码" -i camera-video -u critical
    else
        pkill -x wshowkeys # 录制完全失败时，关闭按键显示
        notify-send "录屏启动失败" "请检查日志: $LOG_FILE" -u critical
    fi
fi
