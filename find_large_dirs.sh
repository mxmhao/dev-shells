#!/bin/zsh
# 递归查找超过指定大小的目录和文件（默认 1MB）
# 用法: ./find_large_dirs.sh [路径] [大小阈值，如 10M] [最大深度，如 3]

TARGET_DIR="${1:-.}"
SIZE_THRESHOLD="${2:-1M}"
# find -size 只认大写单位，统一转大写
SIZE_UPPER=$(echo "$SIZE_THRESHOLD" | tr '[:lower:]' '[:upper:]')
MAX_DEPTH="${3:-0}"  # 0 表示不限制深度

if [ ! -d "$TARGET_DIR" ]; then
    echo "错误: $TARGET_DIR 不是有效目录"
    exit 1
fi

BASE_DIR=$(realpath "$TARGET_DIR")

echo "========================================="
echo " 查找超过 ${SIZE_THRESHOLD} 的目录和文件"
echo " 扫描路径: ${BASE_DIR}"
if [ "$MAX_DEPTH" -gt 0 ]; then
echo " 最大深度: ${MAX_DEPTH}"
fi
echo "========================================="
echo ""

# 合并目录（du）和文件（find）的结果，按路径排序
{
    # 目录
    du -h -t "$SIZE_THRESHOLD" "$TARGET_DIR" 2>/dev/null | while IFS=$'\t' read -r size dirpath; do
        echo "${size}"$'\t'"${dirpath}"$'\t'"dir"
    done
    # 文件（用 stat 获取大小，兼容 macOS）
    find "$TARGET_DIR" -type f -size "+${SIZE_UPPER}" 2>/dev/null | while read -r filepath; do
        bytes=$(stat -f%z "$filepath" 2>/dev/null)
        human=$(numfmt --to=iec "$bytes" 2>/dev/null || echo "${bytes}B")
        echo "${human}"$'\t'"${filepath}"$'\t'"file"
    done
} | sort -k2 | while IFS=$'\t' read -r size itempath itemtype; do
    # 计算相对于扫描路径的深度
    rel="${itempath#"$BASE_DIR"}"
    rel="${rel#/}"
    if [ -z "$rel" ]; then
        depth=0
    else
        depth=$(( $(echo "$rel" | tr -cd '/' | wc -c) + 1 ))
    fi
    # 深度过滤
    if [ "$MAX_DEPTH" -gt 0 ] && [ "$depth" -gt "$MAX_DEPTH" ]; then
        continue
    fi
    indent=""
    for ((i = 0; i < depth; i++)); do
        indent="$indent  │ "
    done
    branch=""
    ((depth > 0)) && branch="├─ "
    marker=""
    [[ "$itemtype" == "file" ]] && marker=" [文件]"
    printf "%-8s %s%s%s%s\n" "$size" "$indent" "$branch" "$(basename "$itempath")" "$marker"
done

echo ""
echo "--- 扫描完成 ---"
