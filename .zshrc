# 基础环境与路径
# 设置 Oh My Zsh 路径
export ZSH="/usr/share/oh-my-zsh"
# 默认编辑器设为 Neovim 
export EDITOR='nvim'
# 语言环境设置 
export LANG=zh_CN.UTF-8
# 输入法 (Fcitx) 兼容性配置
# 确保在 GTK/Qt 以及 SDL 程序中正常使用中文输入法
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export SDL_IM_MODULE=fcitx

# 强制 Firefox 使用 Wayland 和 硬件加速
export MOZ_ENABLE_WAYLAND=1
# 发现某些应用找不到独显
export DRI_PRIME=1

# Wayland 与 Sway 
# 定义桌面环境，帮助应用识别 Portal
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_TYPE=wayland
# 强制 Firefox 使用 Wayland 模式
export MOZ_ENABLE_WAYLAND=1
# Qt 应用优先使用 Wayland，若失败则回退到 X11
export QT_QPA_PLATFORM="wayland;xcb"
# 让 Electron 应用（如 VSCode/Discord）自动开启 Wayland 支持
export ELECTRON_OZONE_PLATFORM_HINT=auto

# Oh My Zsh 核心配置
# 性能优化：禁用自动更新检查，加快启动
zstyle ':omz:update' mode disabled
# 插件声明 (注意：必须在 source oh-my-zsh.sh 之前)
plugins=(
    git
    sudo
)

# 指定补全缓存位置，保持家目录整洁
export ZSH_COMPDUMP="$HOME/.cache/zcompdump-$HOST-$ZSH_VERSION"

# 启动 Oh My Zsh 引擎
source $ZSH/oh-my-zsh.sh

# 插件pacman安装
# 命令自动建议
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# pkgfile：当输入未安装命令时，提示所属软件
source /usr/share/doc/pkgfile/command-not-found.zsh
# FZF：模糊搜索快捷键及补全支持
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
# 语法高亮
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# 交互与补全增强
# 历史记录设置
HISTSIZE=5000
SAVEHIST=5000
setopt HIST_IGNORE_ALL_DUPS  # 不记录重复命令
setopt SHARE_HISTORY         # 多个终端会话共享历史
# 补全系统优化
zstyle ':completion:*' menu select                      # Tab 键唤起菜单
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # 补全忽略大小写
# 自动建议性能优化 (针对大仓库)
typeset -g ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# 外部工具初始化
# Zoxide
if (( $+commands[zoxide] )); then
    eval "$(zoxide init zsh)"
fi
# Starship
if (( $+commands[starship] )); then
    eval "$(starship init zsh)"
fi

# 别名
alias cls='clear'
alias ll='lsd -la'
# 高亮显示过滤结果
alias grep='grep --color=auto'
alias y='yazi'
alias bak-arch='~/.local/bin/backup-arch-etc-v.sh'
