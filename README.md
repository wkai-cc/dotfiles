# wkai's Dotfiles 

这是我的个人 Arch Linux 环境配置文件备份，使用 [GNU Stow](https://www.gnu.org/software/stow/) 进行管理和同步。

---

## 环境概览 (System Components)

| 组件 | 选择 |
| :--- | :--- |
| **OS** | Arch Linux |
| **Shell** | Zsh (with Starship prompt) |
| **WM** | Sway / Hyprland |
| **Editor** | Neovim (LazyVim) |
| **Terminal** | Kitty |
| **File Manager** | Yazi |
| **Input Method** | Fcitx5 |

---

## 部署与安装 (Deployment)

### 1. 安装基础依赖
在链接配置前，请确保系统已安装以下核心软件包：

```bash
# 基础工具与终端
sudo pacman -S git stow zsh starship neovim kitty yazi fastfetch btop htop

# 桌面环境 (Sway/Wayland 相关)
sudo pacman -S sway waybar mako rofi-wayland fcitx5-im fcitx5-chinese-addons

# 其他实用工具
sudo pacman -S obsidian onedrive-abraunegg obs-studio python uv
```

### 2. 克隆仓库
将仓库克隆到用户家目录下的 dotfiles 文件夹中：
```bash
git clone git@github.com:wkai-cc/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 3. 使用 GNU Stow 建立链接
Stow 的逻辑是创建 软链接 (Symlink)。仓库里看到的结构，会被“映射”到家目录（~）:

#### A. 一键全量安装
如果让仓库里所有的配置立刻生效：
```bash
# 执行前确保你在 ~/dotfiles 目录下
# -v: 显示详细日志
# -R: 递归处理（适用于更新）
# -t ~: 指定链接目标为家目录
stow -v -R -t ~ .
```

#### B. 模块化安装
链接特定的配置
```bash
stow nvim    # 只链接 Neovim 配置
stow sway    # 只链接 Sway 配置
```

#### C. 如何撤销链接
想移除这些链接（不会删除仓库里的原文件）
```bash
stow -D -t ~ .
```

## 避坑

### 1. 处理文件冲突

如果运行 stow 报错提示类似 existing target is neither a link nor a directory：

原因：系统可能已经生成了同名文件（如 .zshrc），Stow 为了安全不会覆盖它。

解决方法：先备份或删除家目录下的原生文件，然后再运行 stow：
```bash
mv ~/.zshrc ~/.zshrc.bak
stow -v -R -t ~ .
```

### 2. 脚本执行权限
.local/bin/ 目录下的脚本需要手动赋予执行权限：
```bash
chmod +x ~/.local/bin/*.sh
```

## 仓库结构
.config/: 各软件的核心配置文件。

.local/bin/: 个人实用脚本工具（录屏、壁纸切换等）。

tools/: 独立的实用小工具（如 txt2epub）。

.zshrc & .vimrc: 环境入口文件。

🐧
