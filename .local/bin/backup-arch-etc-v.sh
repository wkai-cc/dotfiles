#!/bin/bash

# =================================================================
# 脚本名称: backup-arch-etc-v.sh
# 功能描述: 备份 Arch Linux 的 LUKS Header、分区表、包列表及关键系统配置
# 使用建议: 建议在系统重大更新前或定期插入备份 U 盘后运行
# =================================================================

# 1. 基础路径配置
# U 盘挂载路径
USB_PATH="/run/media/wkai/Lua"
PARENT_DIR="$USB_PATH/03_Backup/ArchLinux/etc-configs"

# 生成带日期的文件夹名称 (例如: etc-configs-20260427)
DATE_STR=$(date +%Y%m%d)
BACKUP_DIR="$PARENT_DIR/etc-configs-$DATE_STR"

# 具体子目录映射
LUKS_DIR="$BACKUP_DIR/luks"
CONF_DIR="$BACKUP_DIR/system-configs"
PART_DIR="$BACKUP_DIR/partition"
PKG_DIR="$BACKUP_DIR/packages"

# 2. 环境检查
# 检查 U 盘是否在线
if [ ! -d "$USB_PATH" ]; then
    echo "❌ 错误: U 盘未挂载 (路径: $USB_PATH)"
    exit 1
fi

# 检查磁盘空间 (确保 U 盘剩余空间大于 500MB)
FREE_SPACE=$(df "$USB_PATH" | awk 'NR==2 {print $4}')
if [ "$FREE_SPACE" -lt 512000 ]; then
    echo "⚠️ 警告: U 盘剩余空间不足 500MB，备份可能失败。"
    read -p "是否继续? (y/n): " confirm
    [[ $confirm != [yY] ]] && exit 1
fi

# 创建备份目录结构
mkdir -p "$LUKS_DIR" "$CONF_DIR" "$PART_DIR" "$PKG_DIR"
echo "📂 正在备份至: $BACKUP_DIR"

# 3. 备份 LUKS Header (核心：防止磁盘损坏导致无法解密)
TARGET_PART="/dev/nvme0n1p2"
if [ -b "$TARGET_PART" ]; then
    echo "🔒 备份 LUKS Header..."
    # 使用 sudo 执行，确保有权限读取底层块设备
    sudo cryptsetup luksHeaderBackup "$TARGET_PART" --header-backup-file "$LUKS_DIR/nvme0n1p2_header.img"
else
    echo "❌ 未找到加密分区 $TARGET_PART，跳过 Header 备份。"
fi

# 4. 备份分区表与磁盘布局 (方便重装系统时快速复现)
echo "🗺️ 备份磁盘分区信息..."
sudo sfdisk -d /dev/nvme0n1 >"$PART_DIR/nvme0n1_ptable.txt"
lsblk -f >"$PART_DIR/lsblk_layout.txt"

# 5. 备份已安装包列表 (方便快速找回软件环境)
echo "📦 备份 Pacman 与 AUR 包列表..."
pacman -Qqen >"$PKG_DIR/pacman-native.txt" # 官方仓库包
pacman -Qqem >"$PKG_DIR/aur-packages.txt"  # AUR 上的包

# 6. 备份系统关键配置文件 (涵盖引导、解密、挂载、网络等)
echo "⚙️ 备份系统配置文件..."
FILES_TO_BACKUP=(
    "/etc/fstab"           # 挂载配置
    "/etc/crypttab"        # 解密配置
    "/etc/mkinitcpio.conf" # 内存盘配置 (包含钩子信息)
    "/etc/default/grub"    # 引导参数 (如果你用 GRUB)
    "/etc/locale.conf"     # 语言设置
    "/etc/vconsole.conf"   # 终端字体
    "/etc/hostname"        # 主机名
    "/etc/hosts"           # 本地解析
)

for file in "${FILES_TO_BACKUP[@]}"; do
    if [ -f "$file" ]; then
        sudo cp "$file" "$CONF_DIR/"
        echo "   已复制: $file"
    fi
done

# 7. 权限修复与安全加固
# 将备份文件的所有权改回当前用户 wkai，并限制权限为仅自己可见
echo "🔐 正在调整备份文件权限..."
sudo chown -R $USER:$USER "$BACKUP_DIR"
chmod -R 700 "$BACKUP_DIR"

echo "✅ 备份完成！请安全弹出 U 盘。"
