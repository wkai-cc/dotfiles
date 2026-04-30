# ~/.config/zsh/plugins.zsh

# 插件加载 (通过 pacman 安装的系统路径)
# 命令自动建议 (输入时显示灰色候选项)
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# 找不到命令时自动提示所属软件包
source /usr/share/doc/pkgfile/command-not-found.zsh
# FZF：提供模糊搜索的快捷键支持和补全
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
# 语法高亮 (让命令在终端显示不同的颜色)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# 交互体验与补全系统增强
# 内存中保存的历史命令条数
HISTSIZE=5000
# 磁盘文件里保存的历史命令条数
SAVEHIST=5000
# 不记录重复的命令，保持历史记录清爽
setopt HIST_IGNORE_ALL_DUPS
# 多个终端窗口实时共享命令历史
setopt SHARE_HISTORY
# Tab 键唤起可视化选择菜单
zstyle ':completion:*' menu select
# 补全时忽略大小写差异
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# 提升在大代码仓库下的自动建议性能
typeset -g ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# 现代化工具初始化
# 如果系统中安装了 zoxide (更聪明的 cd)，则初始化它
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"
# 如果系统中安装了 starship (极简提示符)，则初始化它
(( $+commands[starship] )) && eval "$(starship init zsh)"
