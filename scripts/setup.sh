#!/bin/bash

# Obsidian Minimal Workflow 设置脚本
# 自动创建 Vault 结构并初始化配置

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

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
        echo -e "${GREEN}✅ 发现现有配置文件${NC}"
        # 读取现有配置
        GITHUB_USERNAME=$(grep -o '"github_username"[[:space:]]*:[[:space:]]*"[^"]*"' "$CONFIG_FILE" | sed 's/.*"\([^"]*\)"$/\1/')
        VAULT_NAME=$(grep -o '"vault_name"[[:space:]]*:[[:space:]]*"[^"]*"' "$CONFIG_FILE" | sed 's/.*"\([^"]*\)"$/\1/')
    else
        # 请求用户输入配置信息
        read -p "请输入您的 GitHub 用户名 (用于文档链接): " GITHUB_USERNAME
        GITHUB_USERNAME=${GITHUB_USERNAME:-"yourusername"}
        
        read -p "请输入 Vault 名称 (默认: My Knowledge Base): " VAULT_NAME
        VAULT_NAME=${VAULT_NAME:-"My Knowledge Base"}
        
        # 创建配置目录和文件
        mkdir -p "$(dirname "$CONFIG_FILE")"
        cat > "$CONFIG_FILE" << EOF
{
  "github_username": "$GITHUB_USERNAME",
  "vault_name": "$VAULT_NAME",
  "default_language": "zh-CN",
  "backup_retention_days": 30,
  "version": "0.2.0",
  "created_date": "$(date -I)",
  "last_updated": "$(date -I)"
}
EOF
        echo -e "${GREEN}✅ 配置文件已创建${NC}"
    fi
}

# 更新文档中的占位符
update_placeholders() {
    echo ""
    echo -e "${BLUE}🔄 更新文档中的占位符...${NC}"
    
    # 需要更新的文件列表
    FILES_TO_UPDATE=(
        "README.md"
        "SETUP.md"
        "docs/troubleshooting.md"
        "docs/best-practices.md"
        "docs/claude-integration.md"
        "CHANGELOG.md"
    )
    
    for file in "${FILES_TO_UPDATE[@]}"; do
        if [ -f "$file" ]; then
            # 替换 GitHub 用户名
            if [[ "$OSTYPE" == "darwin"* ]]; then
                sed -i '' "s/YYvanYang/$GITHUB_USERNAME/g" "$file"
                sed -i '' "s/yourusername/$GITHUB_USERNAME/g" "$file"
                sed -i '' "s/YOUR_USERNAME/$GITHUB_USERNAME/g" "$file"
            else
                sed -i "s/YYvanYang/$GITHUB_USERNAME/g" "$file"
                sed -i "s/yourusername/$GITHUB_USERNAME/g" "$file"
                sed -i "s/YOUR_USERNAME/$GITHUB_USERNAME/g" "$file"
            fi
            
            # 替换 Vault 名称
            if [[ "$OSTYPE" == "darwin"* ]]; then
                sed -i '' "s/My Knowledge Base/$VAULT_NAME/g" "$file" 2>/dev/null || true
            else
                sed -i "s/My Knowledge Base/$VAULT_NAME/g" "$file" 2>/dev/null || true
            fi
            
            echo -e "  ✅ 更新 $file"
        fi
    done
}

# 创建 .gitignore 文件
create_gitignore() {
    if [ ! -f ".gitignore" ]; then
        echo -e "${BLUE}📝 创建 .gitignore 文件...${NC}"
        cat > .gitignore << 'EOF'
# Obsidian
.obsidian/workspace.json
.obsidian/workspace-mobile.json
.obsidian/workspaces.json
.obsidian/cache
.obsidian/hotkeys.json
.obsidian/types.json
.obsidian/app.json

# 系统文件
.DS_Store
Thumbs.db
.directory

# 备份文件
*.bak
*.backup
*.old
*~

# 临时文件
.tmp/
.temp/
*.tmp
*.temp

# 个人配置
.obsidian-workflow/config.json

# IDE
.vscode/
.idea/
*.swp
*.swo

# 日志文件
*.log
logs/

# 附件缓存
90-Meta/Attachments/.thumbnails/
EOF
        echo -e "${GREEN}✅ .gitignore 已创建${NC}"
    fi
}

# 函数：选择或创建目标目录
choose_vault_directory() {
    echo -e "${BLUE}📁 请选择 Vault 的创建方式：${NC}"
    echo "1) 在当前目录创建 ($(pwd))"
    echo "2) 选择其他目录"
    echo "3) 创建新目录"
    echo ""
    read -p "请输入选择 (1-3): " choice
    
    case $choice in
        1)
            VAULT_DIR="$(pwd)"
            if [ "$(ls -A "$VAULT_DIR" 2>/dev/null)" ]; then
                echo ""
                echo -e "${YELLOW}⚠️  当前目录不为空，建议使用空目录创建 Vault${NC}"
                echo "目录内容:"
                ls -la "$VAULT_DIR" | head -10
                echo ""
                read -p "是否继续在此目录创建？(y/N): " response
                if [[ ! "$response" =~ ^[yY]$ ]]; then
                    echo -e "${RED}❌ 安装已取消${NC}"
                    exit 1
                fi
            fi
            ;;
        2)
            read -p "请输入目标目录路径: " target_dir
            if [ -z "$target_dir" ]; then
                echo -e "${RED}❌ 目录路径不能为空${NC}"
                exit 1
            fi
            
            # 展开路径中的 ~ 符号
            target_dir="${target_dir/#\~/$HOME}"
            
            if [ ! -d "$target_dir" ]; then
                echo -e "${RED}❌ 目录不存在: $target_dir${NC}"
                exit 1
            fi
            
            VAULT_DIR="$target_dir"
            if [ "$(ls -A "$VAULT_DIR" 2>/dev/null)" ]; then
                echo ""
                echo -e "${YELLOW}⚠️  目录不为空: $VAULT_DIR${NC}"
                read -p "是否继续？(y/N): " response
                if [[ ! "$response" =~ ^[yY]$ ]]; then
                    echo -e "${RED}❌ 安装已取消${NC}"
                    exit 1
                fi
            fi
            ;;
        3)
            read -p "请输入新目录名称: " dir_name
            if [ -z "$dir_name" ]; then
                echo -e "${RED}❌ 目录名称不能为空${NC}"
                exit 1
            fi
            
            read -p "请输入父目录路径 (默认: $HOME): " parent_dir
            parent_dir="${parent_dir:-$HOME}"
            parent_dir="${parent_dir/#\~/$HOME}"
            
            VAULT_DIR="$parent_dir/$dir_name"
            
            if [ -d "$VAULT_DIR" ]; then
                echo -e "${RED}❌ 目录已存在: $VAULT_DIR${NC}"
                exit 1
            fi
            
            mkdir -p "$VAULT_DIR"
            echo -e "${GREEN}✅ 已创建目录: $VAULT_DIR${NC}"
            ;;
        *)
            echo -e "${RED}❌ 无效选择${NC}"
            exit 1
            ;;
    esac
}

# 选择目标目录
choose_vault_directory

echo ""
echo -e "${BLUE}📍 Vault 将在以下目录创建: $VAULT_DIR${NC}"
echo ""

# 切换到目标目录
cd "$VAULT_DIR" || exit 1

# 初始化配置
init_config

# 1. 复制文件夹结构
echo -e "${BLUE}📁 创建文件夹结构...${NC}"
cp -r "$PROJECT_DIR/vault-template"/* ./
echo -e "${GREEN}✅ 文件夹结构已创建${NC}"

# 2. 复制 Claude Code 命令
echo -e "${BLUE}🤖 配置 Claude Code 集成...${NC}"
cp -r "$PROJECT_DIR/.claude" ./
echo -e "${GREEN}✅ Claude Code 集成已配置${NC}"

# 3. 复制文档文件
echo -e "${BLUE}📚 复制文档文件...${NC}"
cp -r "$PROJECT_DIR/docs" ./
cp "$PROJECT_DIR/README.md" ./
cp "$PROJECT_DIR/SETUP.md" ./
cp "$PROJECT_DIR/CHANGELOG.md" ./
cp "$PROJECT_DIR/LICENSE" ./
echo -e "${GREEN}✅ 文档文件已复制${NC}"

# 4. 复制脚本文件
echo -e "${BLUE}🛠️  复制脚本文件...${NC}"
mkdir -p scripts
cp "$PROJECT_DIR/scripts"/*.sh ./scripts/
chmod +x ./scripts/*.sh
echo -e "${GREEN}✅ 脚本文件已复制${NC}"

# 更新文档中的占位符
update_placeholders

# 创建 .gitignore
create_gitignore

# 5. 创建第一个每日笔记
echo -e "${BLUE}📝 创建今日笔记...${NC}"
DATE=$(date +%Y-%m-%d)
if [ ! -f "10-Daily/${DATE}.md" ]; then
    cp "$PROJECT_DIR/examples/sample-daily-note.md" "10-Daily/${DATE}.md"
    # 兼容 macOS 和 Linux 的 sed 命令
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' "s/2024-12-20/${DATE}/g" "10-Daily/${DATE}.md"
        sed -i '' "s/Friday/$(date +%A)/g" "10-Daily/${DATE}.md"
        sed -i '' "s/12-20/$(date +%m-%d)/g" "10-Daily/${DATE}.md"
        sed -i '' "s/Fri/$(date +%a)/g" "10-Daily/${DATE}.md"
    else
        sed -i "s/2024-12-20/${DATE}/g" "10-Daily/${DATE}.md"
        sed -i "s/Friday/$(date +%A)/g" "10-Daily/${DATE}.md"
        sed -i "s/12-20/$(date +%m-%d)/g" "10-Daily/${DATE}.md"
        sed -i "s/Fri/$(date +%a)/g" "10-Daily/${DATE}.md"
    fi
    echo -e "${GREEN}✅ 今日笔记已创建: 10-Daily/${DATE}.md${NC}"
else
    echo -e "${YELLOW}ℹ️  今日笔记已存在: 10-Daily/${DATE}.md${NC}"
fi

# 6. 创建本周周报
echo -e "${BLUE}📊 创建本周周报...${NC}"
WEEK=$(date +%Y-W%U)
if [ ! -f "Weekly/${WEEK}.md" ]; then
    cp "$PROJECT_DIR/examples/sample-weekly-report.md" "Weekly/${WEEK}.md"
    # 兼容 macOS 和 Linux 的 sed 命令
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' "s/2024-W51/${WEEK}/g" "Weekly/${WEEK}.md"
        sed -i '' "s/第51周/第$(date +%U)周/g" "Weekly/${WEEK}.md"
    else
        sed -i "s/2024-W51/${WEEK}/g" "Weekly/${WEEK}.md"
        sed -i "s/第51周/第$(date +%U)周/g" "Weekly/${WEEK}.md"
    fi
    echo -e "${GREEN}✅ 本周周报已创建: Weekly/${WEEK}.md${NC}"
else
    echo -e "${YELLOW}ℹ️  本周周报已存在: Weekly/${WEEK}.md${NC}"
fi

# 7. 创建示例项目
echo -e "${BLUE}🎯 创建示例项目...${NC}"
if [ ! -f "20-Projects/Project-示例项目.md" ]; then
    cp "$PROJECT_DIR/examples/sample-project.md" "20-Projects/Project-示例项目.md"
    echo -e "${GREEN}✅ 示例项目已创建${NC}"
else
    echo -e "${YELLOW}ℹ️  示例项目已存在${NC}"
fi

# 8. 创建示例知识笔记
echo -e "${BLUE}📚 创建示例知识笔记...${NC}"
if [ ! -f "30-Knowledge/Learning/Lea-示例学习笔记.md" ]; then
    cp "$PROJECT_DIR/examples/sample-knowledge.md" "30-Knowledge/Learning/Lea-示例学习笔记.md"
    echo -e "${GREEN}✅ 示例知识笔记已创建${NC}"
else
    echo -e "${YELLOW}ℹ️  示例知识笔记已存在${NC}"
fi

# 9. 运行初始健康检查
echo ""
echo -e "${BLUE}🏥 运行初始健康检查...${NC}"
if [ -x "./scripts/health-check.sh" ]; then
    ./scripts/health-check.sh || true
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
echo "- 详细文档: $VAULT_DIR/docs/"
echo "- 快速开始: $VAULT_DIR/README.md"
echo "- 故障排除: $VAULT_DIR/docs/troubleshooting.md"
echo ""
echo -e "${GREEN}祝您使用愉快！🚀${NC}"