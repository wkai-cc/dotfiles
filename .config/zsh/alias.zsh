# ~/.config/zsh/alias.zsh

# 常用快捷指令 (Aliases)
# alias cls='clear'
alias cls='clear'
alias ll='lsd -la'
alias grep='grep --color=auto'
alias ,zed='zeditor'

alias ,dot='cd /mnt/data/03_Backup/Cachyos/dotfiles'
alias ,dots='stow -v -R -t ~ .'

alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"'

alias ,orange='cd ~/tools/orange && uv run orange-canvas'
