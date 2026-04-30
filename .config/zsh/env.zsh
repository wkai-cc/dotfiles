# ~/.config/zsh/env.zsh

# 基础环境与路径设置
# 设置默认编辑器为 Neovim
export EDITOR='nvim'
# 设置系统语言环境为中文 UTF-8
export LANG=zh_CN.UTF-8

# 输入法 (Fcitx) 兼容性配置
# 确保 Qt 程序、支持 XIM 协议的应用以及 SDL 游戏能正常调用输入法
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export SDL_IM_MODULE=fcitx

# 硬件与 Wayland 桌面环境特化配置
# 强制使用独立显卡运行应用
export DRI_PRIME=1
# 定义桌面环境，帮助应用识别并调用正确的 Portal 接口
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_TYPE=wayland
# 强制 Firefox 浏览器开启原生 Wayland 支持，解决模糊和性能问题
export MOZ_ENABLE_WAYLAND=1
# Qt 应用优先尝试 Wayland 协议，失败则自动回退到 X11 (xcb)
export QT_QPA_PLATFORM="wayland;xcb"
# 让 Electron 应用（如 VSCode, Discord）自动开启原生 Wayland 支持
export ELECTRON_OZONE_PLATFORM_HINT=auto

# 保持家目录整洁的 XDG 规范强制化
export CARGO_HOME="$HOME/.local/share/cargo"  # Rust 路径
export GOPATH="$HOME/.local/share/go"         # Go 路径
export NODE_REPL_HISTORY="$HOME/.cache/node_history"
