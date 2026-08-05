# ~/.config/zsh/plugins.zsh

# 命令自动建议
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Arch Linux 命令不存在提示
source /usr/share/doc/pkgfile/command-not-found.zsh

# FZF 模糊搜索
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# 语法高亮（必须最后加载）
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# 历史记录
HISTSIZE=100000
SAVEHIST=100000

# 不记录重复命令
setopt HIST_IGNORE_ALL_DUPS

# 保存历史时删除重复命令
setopt HIST_SAVE_NO_DUPS

# 优先删除重复历史
setopt HIST_EXPIRE_DUPS_FIRST

# 多终端追加历史
setopt APPEND_HISTORY

# 多终端实时共享历史
setopt SHARE_HISTORY


# 补全设置
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'


# 提升 zsh-autosuggestions 在大型项目中的性能
typeset -g ZSH_AUTOSUGGEST_MANUAL_REBIND=1


# zoxide 智能目录跳转
if (( $+commands[zoxide] )); then
    eval "$(zoxide init zsh)"
fi

# starship 提示符
if (( $+commands[starship] )); then
    eval "$(starship init zsh)"
fi
