# ~/.config/zsh/env.zsh

# 基础环境与路径设置
# 设置默认编辑器为 Neovim
export EDITOR='nvim'
# 设置系统语言环境为中文 UTF-8
export LANG=zh_CN.UTF-8

# 输入法 (Fcitx) 兼容性配置
# Qt5 / Qt6 界面
export QT_IM_MODULE=fcitx
# GTK3 / GTK4 界面
export GTK_IM_MODULE=fcitx
# X11 程序 XWayland、Chromium
export XMODIFIERS=@im=fcitx
# SDL 程序 游戏内文本框
export SDL_IM_MODULE=fcitx

# Wayland 桌面环境特化配置
# 强制 Firefox 浏览器开启原生 Wayland 支持，解决模糊和性能问题
export MOZ_ENABLE_WAYLAND=1
# Qt 应用优先尝试 Wayland 协议，失败则自动回退到 X11 (xcb)
export QT_QPA_PLATFORM="wayland;xcb"
# 让 Electron 应用（如 VSCode, Discord）自动开启原生 Wayland 支持
export ELECTRON_OZONE_PLATFORM_HINT=auto

# 让 makepkg 和其他构建工具使用所有 CPU 核心进行并行编译
export MAKEFLAGS="-j$(nproc)"
