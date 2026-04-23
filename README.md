# wkai's Dotfiles 🚀

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
