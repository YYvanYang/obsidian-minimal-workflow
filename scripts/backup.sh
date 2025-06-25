#!/bin/bash

# Obsidian Minimal Workflow 增强备份脚本
# 支持完整备份和增量备份

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}🔄 开始备份 Obsidian Vault...${NC}"

# 配置
BACKUP_DIR="${BACKUP_DIR:-$HOME/Documents/Obsidian-Backups}"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_TYPE="${1:-full}"  # full 或 incremental
BACKUP_NAME="obsidian-backup-${DATE}"
FULL_BACKUP_PATH="${BACKUP_DIR}/${BACKUP_NAME}"

# 检查磁盘空间
check_disk_space() {
    if command -v df >/dev/null 2>&1; then
        AVAILABLE_SPACE=$(df -h "$BACKUP_DIR" 2>/dev/null | awk 'NR==2 {print $4}')
        echo -e "${GREEN}💾 可用空间: $AVAILABLE_SPACE${NC}"
        
        # 检查是否有足够空间（至少需要 100MB）
        AVAILABLE_KB=$(df "$BACKUP_DIR" 2>/dev/null | awk 'NR==2 {print $4}')
        if [ -n "$AVAILABLE_KB" ] && [ "$AVAILABLE_KB" -lt 102400 ]; then
            echo -e "${RED}❌ 错误: 磁盘空间不足！至少需要 100MB 可用空间。${NC}"
            exit 1
        fi
    fi
}

# 创建备份目录
mkdir -p "${BACKUP_DIR}"

# 检查磁盘空间
check_disk_space

echo -e "${GREEN}📁 备份目录: ${FULL_BACKUP_PATH}${NC}"
echo -e "${GREEN}📦 备份类型: ${BACKUP_TYPE}${NC}"

# 创建备份目录
mkdir -p "${FULL_BACKUP_PATH}"

# 执行备份
if [ "$BACKUP_TYPE" == "incremental" ]; then
    echo -e "${YELLOW}📂 执行增量备份（最近7天修改的文件）...${NC}"
    
    # 备份最近修改的 Markdown 文件
    find . -name "*.md" -mtime -7 -type f | while read -r file; do
        # 保持目录结构
        dir=$(dirname "$file")
        mkdir -p "${FULL_BACKUP_PATH}/${dir}"
        cp "$file" "${FULL_BACKUP_PATH}/${file}"
    done
    
    # 始终备份配置文件
    [ -d ".claude" ] && cp -r .claude "${FULL_BACKUP_PATH}/"
    [ -d ".obsidian" ] && cp -r .obsidian "${FULL_BACKUP_PATH}/"
    
else
    echo -e "${GREEN}📦 执行完整备份...${NC}"
    
    # 备份核心内容
    for dir in "00-Dashboard" "10-Daily" "20-Projects" "30-Knowledge" "40-Archive" "90-Meta" "Weekly"; do
        if [ -d "$dir" ]; then
            echo -e "  📁 备份 $dir/"
            cp -r "$dir" "${FULL_BACKUP_PATH}/"
        fi
    done
    
    # 备份配置文件
    if [ -d ".claude" ]; then
        echo -e "  🤖 备份 Claude 配置"
        cp -r .claude "${FULL_BACKUP_PATH}/"
    fi
    
    if [ -d ".obsidian" ]; then
        echo -e "  ⚙️  备份 Obsidian 配置"
        cp -r .obsidian "${FULL_BACKUP_PATH}/"
    fi
fi

# 创建备份清单
echo -e "${GREEN}📋 创建备份清单...${NC}"
cat > "${FULL_BACKUP_PATH}/backup-info.txt" << EOF
备份信息
========
备份时间: $(date)
备份类型: ${BACKUP_TYPE}
备份路径: ${FULL_BACKUP_PATH}

备份内容:
--------
$([ "$BACKUP_TYPE" == "incremental" ] && echo "- 最近7天修改的 Markdown 文件" || echo "- 所有文件夹和文件")
- .claude/ (Claude Code命令)
- .obsidian/ (Obsidian配置)

统计信息:
--------
- 总文件数: $(find "${FULL_BACKUP_PATH}" -type f | wc -l)
- Markdown文件数: $(find "${FULL_BACKUP_PATH}" -name "*.md" | wc -l)
- 备份大小: $(du -sh "${FULL_BACKUP_PATH}" | cut -f1)

文件夹统计:
----------
EOF

# 添加各文件夹的文件数统计
for dir in "00-Dashboard" "10-Daily" "20-Projects" "30-Knowledge" "40-Archive" "90-Meta" "Weekly"; do
    if [ -d "${FULL_BACKUP_PATH}/$dir" ]; then
        count=$(find "${FULL_BACKUP_PATH}/$dir" -name "*.md" 2>/dev/null | wc -l)
        echo "- $dir: $count 个文件" >> "${FULL_BACKUP_PATH}/backup-info.txt"
    fi
done

# 压缩备份
echo -e "${GREEN}🗜️  压缩备份文件...${NC}"
cd "${BACKUP_DIR}"
tar -czf "${BACKUP_NAME}.tar.gz" "${BACKUP_NAME}"

# 计算压缩率
ORIGINAL_SIZE=$(du -sk "${BACKUP_NAME}" | cut -f1)
COMPRESSED_SIZE=$(du -sk "${BACKUP_NAME}.tar.gz" | cut -f1)
if [ "$ORIGINAL_SIZE" -gt 0 ]; then
    COMPRESSION_RATIO=$((100 - (COMPRESSED_SIZE * 100 / ORIGINAL_SIZE)))
    echo -e "${GREEN}📊 压缩率: ${COMPRESSION_RATIO}%${NC}"
fi

# 删除未压缩的备份文件夹
rm -rf "${BACKUP_NAME}"

echo -e "${GREEN}✅ 备份完成！${NC}"
echo -e "${GREEN}📂 备份文件: ${BACKUP_DIR}/${BACKUP_NAME}.tar.gz${NC}"
echo -e "${GREEN}💾 文件大小: $(du -h "${BACKUP_DIR}/${BACKUP_NAME}.tar.gz" | cut -f1)${NC}"

# 清理旧备份
RETENTION_DAYS="${RETENTION_DAYS:-30}"
echo -e "${YELLOW}🧹 清理 ${RETENTION_DAYS} 天前的旧备份...${NC}"
find "${BACKUP_DIR}" -name "obsidian-backup-*.tar.gz" -mtime +${RETENTION_DAYS} -print -delete

# 显示现有备份
echo -e "\n${GREEN}📚 现有备份列表:${NC}"
ls -lht "${BACKUP_DIR}"/obsidian-backup-*.tar.gz 2>/dev/null | head -5

echo -e "\n${GREEN}💡 提示:${NC}"
echo "- 使用 '$0 incremental' 进行增量备份"
echo "- 使用 '$0 full' 进行完整备份"
echo "- 设置 BACKUP_DIR 环境变量自定义备份位置"
echo "- 设置 RETENTION_DAYS 环境变量自定义保留天数"
echo "- 建议定期将备份同步到云存储"

# 可选：自动同步到云存储
if command -v rclone >/dev/null 2>&1 && [ -n "$RCLONE_REMOTE" ]; then
    echo -e "\n${GREEN}☁️  同步到云存储...${NC}"
    rclone copy "${BACKUP_DIR}/${BACKUP_NAME}.tar.gz" "${RCLONE_REMOTE}:obsidian-backups/"
fi