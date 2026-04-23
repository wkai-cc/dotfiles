# wkai's Dotfiles

个人 Arch Linux 配置文件备份。

## 环境概览
- **OS**: Arch Linux
- **WM**: Sway / Hyprland
- **Shell**: Zsh (with Starship prompt)
- **Editor**: Neovim (LazyVim)
- **Terminal**: Kitty
- **File Manager**: Yazi

## 安装说明
本项目使用 [GNU Stow](https://www.gnu.org/software/stow/) 进行管理。

```bash
# 克隆仓库
git clone git@github.com:wkai-cc/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 使用 stow 链接配置（例如链接 nvim 配置）
stow nvim
