#!/bin/bash

# 1. 基础路径配置
PARENT_DIR="/run/media/wkai/Lua/03_Backup/ArchLinux/etc-configs"
# 生成带日期的文件夹名称 (例如: etc-configs-20260423)
DATE_STR=$(date +%Y%m%d)
BACKUP_DIR="$PARENT_DIR/etc-configs-$DATE_STR"

# 具体子目录
LUKS_DIR="$BACKUP_DIR/luks"
CONF_DIR="$BACKUP_DIR/system-configs"
PART_DIR="$BACKUP_DIR/partition"

# 2. 环境检查
if [ ! -d "/run/media/wkai/Lua" ]; then
    echo "错误: U 盘未挂载 (路径: /run/media/wkai/Lua)"
    exit 1
fi

# 如果今天的文件夹已经存在，脚本会直接在里面更新/覆盖
mkdir -p "$LUKS_DIR" "$CONF_DIR" "$PART_DIR"

echo "正在备份至: $BACKUP_DIR"

# 3. 备份 LUKS Header
TARGET_PART="/dev/nvme0n1p2"
if [ -b "$TARGET_PART" ]; then
    echo "备份 LUKS Header..."
    sudo cryptsetup luksHeaderBackup "$TARGET_PART" --header-backup-file "$LUKS_DIR/nvme0n1p2_header.img"
fi

# 4. 备份分区表与磁盘布局
echo "备份磁盘分区信息..."
sudo sfdisk -d /dev/nvme0n1 >"$PART_DIR/nvme0n1_ptable.txt"
lsblk -f >"$PART_DIR/lsblk_layout.txt"

# 5. 备份系统关键配置文件
echo "备份系统配置文件..."
FILES_TO_BACKUP=(
    "/etc/fstab"
    "/etc/crypttab"
    "/etc/mkinitcpio.conf"
    "/etc/default/grub"
    "/etc/locale.conf"
    "/etc/vconsole.conf"
    "/etc/hostname"
)

for file in "${FILES_TO_BACKUP[@]}"; do
    if [ -f "$file" ]; then
        sudo cp "$file" "$CONF_DIR/"
    fi
done

# 7. 权限修复
sudo chown -R $USER:$USER "$BACKUP_DIR"
chmod -R 700 "$BACKUP_DIR"

echo "备份完成！"
