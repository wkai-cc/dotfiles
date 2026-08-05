# CachyOS dotfiles

这是我在 CachyOS 上使用的个人配置仓库。

仓库按照 Linux 家目录结构保存配置文件，并使用 GNU Stow 管理符号链接，用于新机器快速恢复个人工作环境。

该仓库记录的是我的个人使用习惯、软件选择和桌面环境配置，不是通用 Linux 配置方案。

## 仓库地址

- GitHub: https://github.com/wkai-cc/dotfiles
- Codeberg: https://codeberg.org/wkai-cc/dotfiles

## 免责声明

- 该配置主要针对我的 CachyOS 环境维护。
- 不保证适用于其他发行版、硬件或桌面环境。
- 部分配置包含个人路径、软件偏好和硬件相关设置。
- 使用前请检查配置内容，根据自己的环境调整。

不要直接复制整个仓库覆盖自己的 `$HOME`。

## 管理内容

当前主要管理：

- Shell：Zsh、Starship
- 编辑器：Neovim
- 终端：Kitty、Ghostty
- 桌面环境：Sway、Waybar、Rofi、Mako
- 文件管理器：Yazi
- 媒体播放器：mpv
- 用户脚本：`.local/bin`

仓库只保存长期维护、有跨机器价值的配置。

以下内容不会被管理：

- 缓存文件
- 应用运行状态
- 数据库文件
- 浏览记录和历史记录
- 登录信息和认证数据
- SSH/GPG 密钥
- API Token 等敏感信息

## 使用方式

安装 Git 和 GNU Stow：

```bash
sudo pacman -S git stow
```

克隆仓库：

```bash
git clone git@github.com:wkai-cc/dotfiles.git ~/dotfiles
```

进入仓库：

```bash
cd ~/dotfiles
```

首次部署前建议测试：

```bash
stow -n -v -t ~ .
```

确认没有冲突后创建链接：

```bash
stow -t ~ .
```

更新配置：

```bash
stow -R -t ~ .
```

删除本仓库创建的链接：

```bash
stow -D -t ~ .
```

Stow 只管理符号链接，不会删除仓库中的源文件。

如果目标位置已经存在配置文件，Stow 会提示冲突。

处理冲突时，请先检查文件内容，根据需要备份或手动合并，不要直接覆盖未知配置。

## 日常维护

修改配置后：

```bash
git status
```

确认变化范围。

提交前检查：

```bash
git diff
```

避免将以下内容加入仓库：

- 缓存
- 临时文件
- 软件生成的数据
- 本机运行状态
- 认证信息

新增软件配置时，应先判断：

- 是否属于长期维护的用户配置；
- 是否需要跨机器同步；
- 是否包含本机相关信息。

该仓库的目标：

保留可复用的个人配置，方便在新机器快速恢复工作环境，同时避免同步无意义数据和敏感信息。
