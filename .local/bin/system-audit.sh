#!/bin/bash

OUT="$HOME/system-audit-$(date +%Y%m%d-%H%M%S).txt"

exec > >(tee "$OUT") 2>&1

echo "=============================="
echo " CachyOS System Audit"
echo " $(date)"
echo "=============================="

echo
echo "========== 系统信息 =========="
hostnamectl
echo

echo
echo "========== 内核 =========="
uname -a
echo

echo
echo "========== CPU =========="
lscpu | grep -E "Model name|CPU\(s\)|Thread|Core|Socket|Virtualization"
echo

echo
echo "========== GPU =========="
lspci | grep -Ei "vga|3d|display"
echo

echo
echo "========== 内存 =========="
free -h
echo

echo
echo "========== 磁盘 =========="
lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINTS
echo

echo
echo "========== 已安装包数量 =========="
echo "全部:"
pacman -Q | wc -l

echo "显式安装:"
pacman -Qe | wc -l

echo "AUR:"
yay -Qm 2>/dev/null | wc -l


echo
echo "========== 显式安装软件 =========="
pacman -Qe


echo
echo "========== AUR 软件 =========="
yay -Qm 2>/dev/null


echo
echo "========== Flatpak =========="
flatpak list 2>/dev/null || echo "没有 Flatpak"


echo
echo "========== Snap =========="
snap list 2>/dev/null || echo "没有 Snap"


echo
echo "========== 开机启动(system) =========="
systemctl list-unit-files --state=enabled


echo
echo "========== 用户开机启动 =========="
systemctl --user list-unit-files --state=enabled


echo
echo "========== 当前运行服务 =========="
systemctl --type=service --state=running


echo
echo "========== 用户运行服务 =========="
systemctl --user --type=service --state=running


echo
echo "========== Rust =========="
rustup show 2>/dev/null || echo "Rust 未安装"


echo
echo "========== Python =========="
python --version 2>/dev/null
pip list 2>/dev/null


echo
echo "========== Node =========="
node -v 2>/dev/null || echo "Node 未安装"
npm -v 2>/dev/null || true


echo
echo "========== Docker =========="
docker --version 2>/dev/null
docker ps 2>/dev/null


echo
echo "========== 虚拟化 =========="
echo "KVM:"
lsmod | grep kvm

echo
echo "libvirt:"
virsh uri 2>/dev/null
virsh list --all 2>/dev/null


echo
echo "========== Shell =========="
echo "SHELL=$SHELL"
zsh --version 2>/dev/null
starship --version 2>/dev/null


echo
echo "========== 桌面应用数量 =========="
ls /usr/share/applications 2>/dev/null | wc -l


echo
echo "========== 大型安装包(前50) =========="
if command -v expac >/dev/null; then
    expac -H M '%-30n %10m' | sort -k2 -h | tail -50
else
    echo "未安装 expac"
fi


echo
echo "========== 孤立包 =========="
pacman -Qtdq 2>/dev/null || echo "没有孤立包"


echo
echo "========== pacman缓存 =========="
du -sh /var/cache/pacman/pkg


echo
echo "========== 完成 =========="
echo "报告保存:"
echo "$OUT"
