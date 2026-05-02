# ~/.config/zsh/alias.zsh

# 常用快捷指令 (Aliases)
alias cls='clear'
alias ll='lsd -la'
alias grep='grep --color=auto'
alias ,y='yazi'

alias bak-arch='~/.local/bin/backup-arch-etc-v.sh'

alias ,dot='cd /mnt/data/03_Backup/ArchLinux/dotfiles'
alias ,dots='stow -v -R -t ~ .'

alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"'
