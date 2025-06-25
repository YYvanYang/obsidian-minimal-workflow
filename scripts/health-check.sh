#!/bin/bash

# Obsidian Vault 健康检查脚本
# 检查文件结构、链接完整性、孤立文件等

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 跨平台哈希函数
get_file_hash() {
    local file="$1"
    if command -v md5sum >/dev/null 2>&1; then
        md5sum "$file" | cut -d' ' -f1
    elif command -v md5 >/dev/null 2>&1; then
        md5 -q "$file"
    else
        echo "" # 如果没有哈希工具，返回空字符串
    fi
}

echo -e "${BLUE}🏥 执行 Obsidian Vault 健康检查...${NC}\n"

# 统计变量
TOTAL_ISSUES=0
CRITICAL_ISSUES=0
WARNINGS=0

# 报告问题的函数
report_issue() {
    local level=$1
    local message=$2
    
    case $level in
        "critical")
            echo -e "${RED}❌ 严重: $message${NC}"
            ((CRITICAL_ISSUES++))
            ((TOTAL_ISSUES++))
            ;;
        "warning")
            echo -e "${YELLOW}⚠️  警告: $message${NC}"
            ((WARNINGS++))
            ((TOTAL_ISSUES++))
            ;;
        "info")
            echo -e "${GREEN}ℹ️  信息: $message${NC}"
            ;;
    esac
}

# 1. 检查必需的文件夹结构
echo -e "${BLUE}📁 检查文件夹结构...${NC}"
REQUIRED_DIRS=("00-Dashboard" "10-Daily" "20-Projects" "30-Knowledge" "30-Knowledge/Learning" "30-Knowledge/Research" "30-Knowledge/Reference" "30-Knowledge/Personal" "40-Archive" "90-Meta" "Weekly")
MISSING_DIRS=0

for dir in "${REQUIRED_DIRS[@]}"; do
    if [ ! -d "$dir" ]; then
        report_issue "critical" "缺少必需文件夹: $dir"
        ((MISSING_DIRS++))
    else
        echo -e "  ✅ $dir"
    fi
done

if [ $MISSING_DIRS -eq 0 ]; then
    report_issue "info" "所有必需文件夹都存在"
fi

echo ""

# 2. 检查模板文件
echo -e "${BLUE}📝 检查模板文件...${NC}"
TEMPLATE_DIR="90-Meta/Templates"
if [ -d "$TEMPLATE_DIR" ]; then
    REQUIRED_TEMPLATES=("daily-template.md" "project-template.md" "knowledge-template.md" "weekly-template.md" "personal-template.md")
    for template in "${REQUIRED_TEMPLATES[@]}"; do
        if [ ! -f "$TEMPLATE_DIR/$template" ]; then
            report_issue "warning" "缺少模板文件: $template"
        else
            echo -e "  ✅ $template"
        fi
    done
else
    report_issue "critical" "模板文件夹不存在: $TEMPLATE_DIR"
fi

echo ""

# 3. 检查孤立文件（没有任何链接的文件）
echo -e "${BLUE}🔗 检查孤立文件...${NC}"
ORPHANED_FILES=()
TOTAL_MD_FILES=0

# 创建临时文件存储所有链接
TEMP_LINKS=$(mktemp)
TEMP_LINKED_FILES=$(mktemp)

# 收集所有 .md 文件中的链接
find . -name "*.md" -type f | while read -r file; do
    # 提取 [[链接]] 格式的链接
    grep -oE '\[\[([^]]+)\]\]' "$file" 2>/dev/null | sed 's/\[\[\(.*\)\]\]/\1/g' >> "$TEMP_LINKS"
done

# 处理链接，获取被链接的文件列表
sort -u "$TEMP_LINKS" | while read -r link; do
    # 移除可能的标题或块引用
    base_link=$(echo "$link" | sed 's/#.*//' | sed 's/\^.*//')
    echo "$base_link" >> "$TEMP_LINKED_FILES"
done

# 检查每个 .md 文件是否被链接
find . -name "*.md" -type f | while read -r file; do
    ((TOTAL_MD_FILES++))
    
    # 跳过模板文件和仪表盘文件
    if [[ "$file" =~ Templates|Dashboard|README|CHANGELOG|SETUP ]]; then
        continue
    fi
    
    # 获取文件名（不含路径和扩展名）
    filename=$(basename "$file" .md)
    
    # 检查文件是否被链接
    if ! grep -q "^$filename$" "$TEMP_LINKED_FILES" 2>/dev/null; then
        # 检查文件是否包含外部链接
        if ! grep -q '\[\[' "$file" 2>/dev/null; then
            ORPHANED_FILES+=("$file")
        fi
    fi
done

if [ ${#ORPHANED_FILES[@]} -gt 0 ]; then
    report_issue "warning" "发现 ${#ORPHANED_FILES[@]} 个孤立文件:"
    for file in "${ORPHANED_FILES[@]:0:5}"; do
        echo -e "    - $file"
    done
    if [ ${#ORPHANED_FILES[@]} -gt 5 ]; then
        echo -e "    ... 还有 $((${#ORPHANED_FILES[@]} - 5)) 个文件"
    fi
else
    report_issue "info" "没有发现孤立文件"
fi

# 清理临时文件
rm -f "$TEMP_LINKS" "$TEMP_LINKED_FILES"

echo ""

# 4. 检查断开的链接
echo -e "${BLUE}🔍 检查断开的链接...${NC}"
BROKEN_LINKS=0

find . -name "*.md" -type f | while read -r file; do
    # 提取所有 [[链接]]
    grep -oE '\[\[([^]]+)\]\]' "$file" 2>/dev/null | sed 's/\[\[\(.*\)\]\]/\1/g' | while read -r link; do
        # 移除标题和块引用
        base_link=$(echo "$link" | sed 's/#.*//' | sed 's/\^.*//')
        
        # 检查链接的文件是否存在
        if ! find . -name "${base_link}.md" -type f | grep -q .; then
            report_issue "warning" "断开的链接: [[$link]] 在文件 $file"
            ((BROKEN_LINKS++))
        fi
    done
done

if [ $BROKEN_LINKS -eq 0 ]; then
    report_issue "info" "没有发现断开的链接"
fi

echo ""

# 5. 检查重复文件
echo -e "${BLUE}👥 检查重复文件...${NC}"
DUPLICATES=0

# 使用文件内容的哈希值查找重复文件
if command -v md5sum >/dev/null 2>&1 || command -v md5 >/dev/null 2>&1; then
    # 创建临时文件存储哈希值
    TEMP_HASHES=$(mktemp)
    
    find . -name "*.md" -type f | while read -r file; do
        hash=$(get_file_hash "$file")
        if [ -n "$hash" ]; then
            echo "$hash $file" >> "$TEMP_HASHES"
        fi
    done
    
    # 查找重复的哈希值
    if [ -f "$TEMP_HASHES" ]; then
        sort "$TEMP_HASHES" | uniq -w32 -d | while read -r line; do
            if [ -n "$line" ]; then
                file=$(echo "$line" | awk '{$1=""; print $0}' | sed 's/^ //')
                report_issue "warning" "可能的重复文件: $file"
                ((DUPLICATES++))
            fi
        done
        rm -f "$TEMP_HASHES"
    fi
else
    report_issue "warning" "无法检查重复文件 - 缺少哈希工具 (md5sum 或 md5)"
fi

if [ $DUPLICATES -eq 0 ]; then
    report_issue "info" "没有发现重复文件"
fi

echo ""

# 6. 检查大文件
echo -e "${BLUE}📏 检查大文件...${NC}"
LARGE_FILES=$(find . -name "*.md" -type f -size +100k 2>/dev/null)

if [ -n "$LARGE_FILES" ]; then
    report_issue "warning" "发现大文件（超过 100KB）:"
    echo "$LARGE_FILES" | while read -r file; do
        size=$(du -h "$file" | cut -f1)
        echo -e "    - $file ($size)"
    done
else
    report_issue "info" "没有发现过大的文件"
fi

echo ""

# 7. 检查空文件
echo -e "${BLUE}📄 检查空文件...${NC}"
EMPTY_FILES=$(find . -name "*.md" -type f -empty 2>/dev/null)

if [ -n "$EMPTY_FILES" ]; then
    report_issue "warning" "发现空文件:"
    echo "$EMPTY_FILES" | head -5 | while read -r file; do
        echo -e "    - $file"
    done
    
    EMPTY_COUNT=$(echo "$EMPTY_FILES" | wc -l)
    if [ $EMPTY_COUNT -gt 5 ]; then
        echo -e "    ... 还有 $((EMPTY_COUNT - 5)) 个空文件"
    fi
else
    report_issue "info" "没有发现空文件"
fi

echo ""

# 8. 生成总结报告
echo -e "${BLUE}📊 健康检查总结${NC}"
echo -e "================================"
echo -e "总文件数: $(find . -name "*.md" -type f | wc -l) 个 Markdown 文件"
echo -e "文件夹数: $(find . -type d | wc -l) 个"
echo -e ""
echo -e "问题统计:"
echo -e "  - 严重问题: ${CRITICAL_ISSUES} 个"
echo -e "  - 警告问题: ${WARNINGS} 个"
echo -e "  - 总计问题: ${TOTAL_ISSUES} 个"
echo -e ""

if [ $CRITICAL_ISSUES -gt 0 ]; then
    echo -e "${RED}⚠️  建议立即修复严重问题！${NC}"
elif [ $WARNINGS -gt 0 ]; then
    echo -e "${YELLOW}💡 建议关注并修复警告问题。${NC}"
else
    echo -e "${GREEN}✅ Vault 状态良好！${NC}"
fi

echo -e "\n${BLUE}💡 修复建议:${NC}"
echo "1. 使用 setup.sh 脚本重新创建缺失的文件夹"
echo "2. 定期运行此健康检查脚本"
echo "3. 考虑归档或删除孤立文件"
echo "4. 修复断开的链接或删除无效引用"
echo "5. 定期备份重要数据"

# 退出码基于严重问题数
exit $CRITICAL_ISSUES