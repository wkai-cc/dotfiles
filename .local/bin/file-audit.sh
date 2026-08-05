#!/bin/bash

OUT="$HOME/file-audit-$(date +%Y%m%d-%H%M%S).txt"

exec > >(tee "$OUT") 2>&1

echo "===================================="
echo " CachyOS File Audit"
echo " $(date)"
echo "===================================="


echo
echo "========== Home目录 =========="
ls -lah ~


echo
echo "========== Home目录大小 =========="
du -h --max-depth=1 ~ 2>/dev/null | sort -h


echo
echo "========== 最大目录 TOP30 =========="
du -h --max-depth=2 ~ 2>/dev/null \
| sort -h \
| tail -30


echo
echo "========== 备份文件 =========="
find ~ \
-type f \
\( \
-name "*.bak" -o \
-name "*.backup" -o \
-name "*.old" -o \
-name "*.save" -o \
-name "*~" -o \
-name "*.orig" \
\) 2>/dev/null


echo
echo "========== 备份目录 =========="
find ~ \
-type d \
\( \
-name "backup" -o \
-name "Backup" -o \
-name "backups" -o \
-name "Backups" -o \
-name "old" -o \
-name "archive" \
\) 2>/dev/null


echo
echo "========== 隐藏目录大小 =========="
du -h --max-depth=1 ~/.config 2>/dev/null | sort -h

echo

du -h --max-depth=1 ~/.local 2>/dev/null | sort -h


echo
echo "========== 大文件 >1GB =========="
find ~ \
-type f \
-size +1G \
-exec ls -lh {} \; \
2>/dev/null


echo
echo "========== 下载目录 =========="
if [ -d ~/Downloads ]; then
    du -h --max-depth=1 ~/Downloads | sort -h
fi


echo
echo "========== 视频目录 =========="
if [ -d ~/Videos ]; then
    du -h --max-depth=1 ~/Videos | sort -h
fi


echo
echo "========== 文档目录 =========="
if [ -d ~/Documents ]; then
    du -h --max-depth=1 ~/Documents | sort -h
fi


echo
echo "========== 图片目录 =========="
if [ -d ~/Pictures ]; then
    du -h --max-depth=1 ~/Pictures | sort -h
fi


echo
echo "========== pacman缓存 =========="
du -sh /var/cache/pacman/pkg 2>/dev/null


echo
echo "========== journal日志 =========="
journalctl --disk-usage


echo
echo "========== 临时文件 =========="
du -sh /tmp ~/.cache 2>/dev/null


echo
echo "========== 最近修改的大文件 =========="
find ~ \
-type f \
printf '%TY-%Tm-%Td %TH:%TM %s %p\n' {} \; \
2>/dev/null \
| sort -k3 -n \
| tail -30


echo
echo "========== Git仓库 =========="
find ~ \
-name ".git" \
-type d \
2>/dev/null


echo
echo "========== 符号链接 =========="
find ~ \
-type l \
-maxdepth 3 \
-ls 2>/dev/null


echo
echo "===================================="
echo "完成"
echo "报告:"
echo "$OUT"
