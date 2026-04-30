# 1. Oh My Zsh 核心配置 (必须最先处理)
# 指定 Oh My Zsh 的安装路径
export ZSH="/usr/share/oh-my-zsh"
# 性能优化：禁用自动更新检查，加快终端启动速度
zstyle ':omz:update' mode disabled
# 声明要启用的 Oh My Zsh 插件
plugins=(git sudo)
# 指定补全缓存文件的位置，放到 .cache 文件夹以保持家目录整洁
export ZSH_COMPDUMP="$HOME/.cache/zcompdump-$HOST-$ZSH_VERSION"

# 启动 Oh My Zsh 引擎
source $ZSH/oh-my-zsh.sh

# 2. 自动引入 ~/.config/zsh/ 下的所有 .zsh 模块
# (N) 标志用于在文件夹为空时防止脚本报错
for config_file in ~/.config/zsh/*.zsh(N); do
    source "$config_file"
done
