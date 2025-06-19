#!/bin/bash

# Obsidian Minimal Workflow 备份脚本
# 用于定期备份重要的笔记和配置文件

echo "🔄 开始备份 Obsidian Vault..."

# 配置备份目录
BACKUP_DIR="$HOME/Documents/Obsidian-Backups"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="obsidian-backup-${DATE}"
FULL_BACKUP_PATH="${BACKUP_DIR}/${BACKUP_NAME}"

# 创建备份目录
mkdir -p "${BACKUP_DIR}"

echo "📁 备份目录: ${FULL_BACKUP_PATH}"

# 创建备份
echo "📦 创建完整备份..."
mkdir -p "${FULL_BACKUP_PATH}"

# 备份核心内容
cp -r 00-Dashboard "${FULL_BACKUP_PATH}/"
cp -r 10-Daily "${FULL_BACKUP_PATH}/"
cp -r 20-Projects "${FULL_BACKUP_PATH}/"
cp -r 30-Knowledge "${FULL_BACKUP_PATH}/"
cp -r 90-Meta "${FULL_BACKUP_PATH}/"
cp -r Weekly "${FULL_BACKUP_PATH}/"

# 备份配置文件
cp -r .claude "${FULL_BACKUP_PATH}/"
if [ -d ".obsidian" ]; then
    cp -r .obsidian "${FULL_BACKUP_PATH}/"
fi

# 创建备份清单
echo "📋 创建备份清单..."
cat > "${FULL_BACKUP_PATH}/backup-info.txt" << EOF
备份时间: $(date)
备份内容:
- 00-Dashboard/ (仪表盘文件)
- 10-Daily/ (每日笔记)  
- 20-Projects/ (项目文件)
- 30-Knowledge/ (知识库)
- 90-Meta/ (模板和配置)
- Weekly/ (周报)
- .claude/ (Claude Code命令)
- .obsidian/ (Obsidian配置，如果存在)

统计信息:
- 每日笔记数量: $(find 10-Daily -name "*.md" | wc -l)
- 项目数量: $(find 20-Projects -name "*.md" | wc -l)  
- 知识笔记数量: $(find 30-Knowledge -name "*.md" | wc -l)
- 周报数量: $(find Weekly -name "*.md" | wc -l)
EOF

# 压缩备份（可选）
echo "🗜️  压缩备份文件..."
cd "${BACKUP_DIR}"
tar -czf "${BACKUP_NAME}.tar.gz" "${BACKUP_NAME}"
rm -rf "${BACKUP_NAME}"

echo "✅ 备份完成！"
echo "📂 备份文件: ${BACKUP_DIR}/${BACKUP_NAME}.tar.gz" 
echo "💾 文件大小: $(du -h "${BACKUP_DIR}/${BACKUP_NAME}.tar.gz" | cut -f1)"

# 清理旧备份 (保留最近30天)
echo "🧹 清理30天前的旧备份..."
find "${BACKUP_DIR}" -name "obsidian-backup-*.tar.gz" -mtime +30 -delete
echo "✅ 清理完成"

echo ""
echo "💡 建议："
echo "- 每周运行一次此脚本进行备份"
echo "- 重要内容可以同步到云存储"
echo "- 定期验证备份文件的完整性"