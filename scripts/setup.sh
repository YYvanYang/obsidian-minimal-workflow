#!/bin/bash

# Obsidian Minimal Workflow 设置脚本
# 自动创建 Vault 结构并初始化配置

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 安全函数：验证 Vault 名称
validate_vault_name() {
    local name="$1"
    if [[ "$name" =~ [/\\:*?\"\<\>\|] ]]; then
        echo -e "${RED}❌ 错误: Vault 名称包含非法字符${NC}"
        echo "Vault 名称不能包含: / \\ : * ? \" < > |"
        return 1
    fi
}

echo -e "${BLUE}🚀 开始设置 obsidian-minimal-workflow...${NC}"
echo ""

# 获取脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

# 配置文件路径
CONFIG_FILE=".obsidian-workflow/config.json"

# 初始化配置函数
init_config() {
    echo ""
    echo -e "${BLUE}📝 初始化项目配置...${NC}"
    
    # 检查是否已有配置
    if [ -f "$CONFIG_FILE" ]; then
        echo -e "${GREEN}✅ 发现现有配置文件，将更新配置${NC}"
    fi
    
    # 创建配置目录和文件（VAULT_NAME已在外部获取）
    mkdir -p "$(dirname "$CONFIG_FILE")"
    cat > "$CONFIG_FILE" << EOF
{
  "vault_name": "$VAULT_NAME",
  "default_language": "zh-CN",
  "backup_retention_days": 30,
  "version": "0.2.0",
  "created_date": "$(date -I)",
  "last_updated": "$(date -I)"
}
EOF
    echo -e "${GREEN}✅ 配置文件已创建${NC}"
}



# 函数：选择或创建目标目录 (遵循业界最佳实践)
choose_vault_directory() {
    # 将Vault名称转换为适合目录名的格式
    local vault_name_for_dir
    if [ -n "$VAULT_NAME" ]; then
        vault_name_for_dir=$(echo "$VAULT_NAME" | sed 's/[^a-zA-Z0-9\-]/-/g' | sed 's/--*/-/g' | sed 's/^-\|-$//g')
        if [ -z "$vault_name_for_dir" ]; then
            vault_name_for_dir="My-Vault"
        fi
    else
        vault_name_for_dir="My-Vault"
    fi
    
    echo ""
    echo -e "${BLUE}📁 选择 Vault 创建位置：${NC}"
    echo "1) 当前目录   ($(pwd)/$vault_name_for_dir)"
    echo "2) 指定目录   (自定义父目录)"
    echo "3) 现有目录   (使用现有空目录)"
    echo ""
    read -p "请选择 (1-3): " choice
    
    case $choice in
        1)
            VAULT_DIR="$(pwd)/$vault_name_for_dir"
            ;;
        2)
            read -p "请输入父目录路径 (默认: $HOME): " parent_dir
            parent_dir="${parent_dir:-$HOME}"
            parent_dir="${parent_dir/#\~/$HOME}"
            
            # 获取绝对路径
            parent_dir="$(realpath "$parent_dir" 2>/dev/null || echo "$parent_dir")"
            
            if [ ! -d "$parent_dir" ]; then
                echo -e "${RED}❌ 父目录不存在: $parent_dir${NC}"
                exit 1
            fi
            
            VAULT_DIR="$parent_dir/$vault_name_for_dir"
            ;;
        3)
            read -p "请输入目标目录的完整路径: " target_dir
            if [ -z "$target_dir" ]; then
                echo -e "${RED}❌ 目录路径不能为空${NC}"
                exit 1
            fi
            
            # 安全检查：防止路径遍历攻击
            if [[ "$target_dir" =~ \.\. ]]; then
                echo -e "${RED}❌ 错误: 路径不能包含 '..' ${NC}"
                exit 1
            fi
            
            # 展开路径中的 ~ 符号
            target_dir="${target_dir/#\~/$HOME}"
            
            # 获取绝对路径
            target_dir="$(realpath "$target_dir" 2>/dev/null || echo "$target_dir")"
            
            if [ ! -d "$target_dir" ]; then
                echo -e "${RED}❌ 目录不存在: $target_dir${NC}"
                exit 1
            fi
            
            VAULT_DIR="$target_dir"
            ;;
        *)
            echo -e "${RED}❌ 无效选择${NC}"
            exit 1
            ;;
    esac
    
    # 检查目录是否存在，如果不存在则创建
    if [ ! -d "$VAULT_DIR" ]; then
        mkdir -p "$VAULT_DIR"
        echo -e "${GREEN}✅ 已创建目录: $VAULT_DIR${NC}"
    else
        # 检查目录是否为空
        if [ "$(ls -A "$VAULT_DIR" 2>/dev/null)" ]; then
            echo ""
            echo -e "${YELLOW}⚠️  目录不为空: $VAULT_DIR${NC}"
            echo "目录内容:"
            ls -la "$VAULT_DIR" | head -5
            echo ""
            read -p "是否继续在此目录创建 Vault？(y/N): " response
            if [[ ! "$response" =~ ^[yY]$ ]]; then
                echo -e "${RED}❌ 安装已取消${NC}"
                exit 1
            fi
        fi
    fi
}

# 首先获取 Vault 名称（用于目录创建）
echo ""
echo -e "${BLUE}📝 配置 Vault 信息...${NC}"
while true; do
    read -p "请输入 Vault 名称 (默认: My Knowledge Base): " VAULT_NAME
    VAULT_NAME=${VAULT_NAME:-"My Knowledge Base"}
    if validate_vault_name "$VAULT_NAME"; then
        break
    fi
done

# 选择目标目录
choose_vault_directory

echo ""
echo -e "${BLUE}📍 Vault 将在以下目录创建: $VAULT_DIR${NC}"
echo ""

# 切换到目标目录
cd "$VAULT_DIR" || exit 1

# 初始化配置（此时已有VAULT_NAME）
init_config

# 1. 复制文件夹结构
echo -e "${BLUE}📁 创建文件夹结构...${NC}"
cp -r "$PROJECT_DIR/vault-template"/* ./
echo -e "${GREEN}✅ 文件夹结构已创建${NC}"

# 2. 复制 Claude Code 命令
echo -e "${BLUE}🤖 配置 Claude Code 集成...${NC}"
cp -r "$PROJECT_DIR/.claude" ./
echo -e "${GREEN}✅ Claude Code 集成已配置${NC}"

# 3. 创建第一个每日笔记
echo -e "${BLUE}📝 创建今日笔记...${NC}"
DATE=$(date +%Y-%m-%d)
if [ ! -f "10-Daily/${DATE}.md" ]; then
    cp "$PROJECT_DIR/examples/sample-daily-note.md" "10-Daily/${DATE}.md"
    # 兼容 macOS 和 Linux 的 sed 命令
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' "s/2025-06-20/${DATE}/g" "10-Daily/${DATE}.md"
        sed -i '' "s/Friday/$(date +%A)/g" "10-Daily/${DATE}.md"
        sed -i '' "s/06-20/$(date +%m-%d)/g" "10-Daily/${DATE}.md"
        sed -i '' "s/Fri/$(date +%a)/g" "10-Daily/${DATE}.md"
    else
        sed -i "s/2025-06-20/${DATE}/g" "10-Daily/${DATE}.md"
        sed -i "s/Friday/$(date +%A)/g" "10-Daily/${DATE}.md"
        sed -i "s/06-20/$(date +%m-%d)/g" "10-Daily/${DATE}.md"
        sed -i "s/Fri/$(date +%a)/g" "10-Daily/${DATE}.md"
    fi
    echo -e "${GREEN}✅ 今日笔记已创建: 10-Daily/${DATE}.md${NC}"
else
    echo -e "${YELLOW}ℹ️  今日笔记已存在: 10-Daily/${DATE}.md${NC}"
fi

# 4. 创建本周周报
echo -e "${BLUE}📊 创建本周周报...${NC}"
WEEK=$(date +%Y-W%V)
if [ ! -f "Weekly/${WEEK}.md" ]; then
    cp "$PROJECT_DIR/examples/sample-weekly-report.md" "Weekly/${WEEK}.md"
    # 兼容 macOS 和 Linux 的 sed 命令
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' "s/2025-W25/${WEEK}/g" "Weekly/${WEEK}.md"
        sed -i '' "s/第25周/第$(date +%V)周/g" "Weekly/${WEEK}.md"
    else
        sed -i "s/2025-W25/${WEEK}/g" "Weekly/${WEEK}.md"
        sed -i "s/第25周/第$(date +%V)周/g" "Weekly/${WEEK}.md"
    fi
    echo -e "${GREEN}✅ 本周周报已创建: Weekly/${WEEK}.md${NC}"
else
    echo -e "${YELLOW}ℹ️  本周周报已存在: Weekly/${WEEK}.md${NC}"
fi

# 5. 创建示例项目
echo -e "${BLUE}🎯 创建示例项目...${NC}"
if [ ! -f "20-Projects/Project-示例项目.md" ]; then
    cp "$PROJECT_DIR/examples/sample-project.md" "20-Projects/Project-示例项目.md"
    echo -e "${GREEN}✅ 示例项目已创建${NC}"
else
    echo -e "${YELLOW}ℹ️  示例项目已存在${NC}"
fi

# 6. 创建示例知识笔记
echo -e "${BLUE}📚 创建示例知识笔记...${NC}"
if [ ! -f "30-Knowledge/Learning/Lea-示例学习笔记.md" ]; then
    cp "$PROJECT_DIR/examples/sample-knowledge.md" "30-Knowledge/Learning/Lea-示例学习笔记.md"
    echo -e "${GREEN}✅ 示例知识笔记已创建${NC}"
else
    echo -e "${YELLOW}ℹ️  示例知识笔记已存在${NC}"
fi


echo ""
echo -e "${GREEN}🎉 设置完成！${NC}"
echo ""
echo -e "${BLUE}📍 Vault 位置: $VAULT_DIR${NC}"
echo ""
echo -e "${BLUE}📚 接下来的步骤：${NC}"
echo "1. 在 Obsidian 中打开以下文件夹作为 Vault: $VAULT_DIR"
echo "2. 安装必需插件: Templater, Dataview, Calendar"
echo "3. 配置 Templater 插件指向 90-Meta/Templates 文件夹"
echo "4. 打开 00-Dashboard/Home.md 开始使用"
echo ""
echo -e "${BLUE}⚙️  插件配置提醒：${NC}"
echo "- Templater: 设置模板文件夹为 '90-Meta/Templates'"
echo "- Templater: 开启 'Trigger on new file creation'"
echo "- Dataview: 确保插件已启用"
echo "- Periodic Notes: 配置每日、周报等模板"
echo ""
echo -e "${BLUE}💡 建议按照渐进式采用计划：${NC}"
echo "   第1周: 只使用每日笔记和主页仪表盘"
echo "   第2-3周: 开始使用项目管理功能"
echo "   第4周: 添加知识管理和周报"
echo "   第2个月: 使用 Claude Code 自动化"
echo ""
echo -e "${BLUE}📖 文档和帮助：${NC}"
echo "- 项目主页: https://github.com/YYvanYang/obsidian-minimal-workflow"
echo "- 详细文档: 项目 README.md 和 docs/ 文件夹"
echo "- Claude Code 集成: .claude/ 文件夹"
echo ""
echo -e "${GREEN}祝您使用愉快！🚀${NC}"