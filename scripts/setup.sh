#!/bin/bash

echo "🚀 开始设置 obsidian-minimal-workflow..."
echo ""

# 获取脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

# 函数：选择或创建目标目录
choose_vault_directory() {
    echo "📁 请选择Vault的创建方式："
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
                echo "⚠️  当前目录不为空，建议使用空目录创建Vault"
                echo "目录内容:"
                ls -la "$VAULT_DIR" | head -10
                echo ""
                read -p "是否继续在此目录创建？(y/N): " response
                if [[ ! "$response" =~ ^[yY]$ ]]; then
                    echo "❌ 安装已取消"
                    exit 1
                fi
            fi
            ;;
        2)
            read -p "请输入目标目录路径: " target_dir
            if [ -z "$target_dir" ]; then
                echo "❌ 目录路径不能为空"
                exit 1
            fi
            
            # 展开路径中的 ~ 符号
            target_dir="${target_dir/#\~/$HOME}"
            
            if [ ! -d "$target_dir" ]; then
                echo "❌ 目录不存在: $target_dir"
                exit 1
            fi
            
            VAULT_DIR="$target_dir"
            if [ "$(ls -A "$VAULT_DIR" 2>/dev/null)" ]; then
                echo ""
                echo "⚠️  目录不为空: $VAULT_DIR"
                read -p "是否继续？(y/N): " response
                if [[ ! "$response" =~ ^[yY]$ ]]; then
                    echo "❌ 安装已取消"
                    exit 1
                fi
            fi
            ;;
        3)
            read -p "请输入新目录名称: " dir_name
            if [ -z "$dir_name" ]; then
                echo "❌ 目录名称不能为空"
                exit 1
            fi
            
            read -p "请输入父目录路径 (默认: $HOME): " parent_dir
            parent_dir="${parent_dir:-$HOME}"
            parent_dir="${parent_dir/#\~/$HOME}"
            
            VAULT_DIR="$parent_dir/$dir_name"
            
            if [ -d "$VAULT_DIR" ]; then
                echo "❌ 目录已存在: $VAULT_DIR"
                exit 1
            fi
            
            mkdir -p "$VAULT_DIR"
            echo "✅ 已创建目录: $VAULT_DIR"
            ;;
        *)
            echo "❌ 无效选择"
            exit 1
            ;;
    esac
}

# 选择目标目录
choose_vault_directory

echo ""
echo "📍 Vault将在以下目录创建: $VAULT_DIR"
echo ""

# 切换到目标目录
cd "$VAULT_DIR" || exit 1

# 1. 复制文件夹结构
echo "📁 创建文件夹结构..."
cp -r "$PROJECT_DIR/vault-template"/* ./
echo "✅ 文件夹结构已创建"

# 2. 复制Claude Code命令
echo "🤖 配置Claude Code集成..."
cp -r "$PROJECT_DIR/.claude" ./
echo "✅ Claude Code集成已配置"

# 3. 创建第一个每日笔记
echo "📝 创建今日笔记..."
DATE=$(date +%Y-%m-%d)
if [ ! -f "10-Daily/${DATE}.md" ]; then
    cp "$PROJECT_DIR/examples/sample-daily-note.md" "10-Daily/${DATE}.md"
    # 兼容 macOS 和 Linux 的 sed 命令
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' "s/2024-12-20/${DATE}/g" "10-Daily/${DATE}.md"
    else
        sed -i "s/2024-12-20/${DATE}/g" "10-Daily/${DATE}.md"
    fi
    echo "✅ 今日笔记已创建: 10-Daily/${DATE}.md"
else
    echo "ℹ️  今日笔记已存在: 10-Daily/${DATE}.md"
fi

# 4. 创建本周周报
echo "📊 创建本周周报..."
WEEK=$(date +%Y-W%U)
if [ ! -f "Weekly/${WEEK}.md" ]; then
    cp "$PROJECT_DIR/examples/sample-weekly-report.md" "Weekly/${WEEK}.md"
    # 兼容 macOS 和 Linux 的 sed 命令
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' "s/2024-W51/${WEEK}/g" "Weekly/${WEEK}.md"
    else
        sed -i "s/2024-W51/${WEEK}/g" "Weekly/${WEEK}.md"
    fi
    echo "✅ 本周周报已创建: Weekly/${WEEK}.md"
else
    echo "ℹ️  本周周报已存在: Weekly/${WEEK}.md"
fi

# 5. 创建示例项目
echo "🎯 创建示例项目..."
if [ ! -f "20-Projects/Project-示例项目.md" ]; then
    cp "$PROJECT_DIR/examples/sample-project.md" "20-Projects/Project-示例项目.md"
    echo "✅ 示例项目已创建"
else
    echo "ℹ️  示例项目已存在"
fi

# 6. 创建示例知识笔记
echo "📚 创建示例知识笔记..."
if [ ! -f "30-Knowledge/Learning/Lea-示例学习笔记.md" ]; then
    cp "$PROJECT_DIR/examples/sample-knowledge.md" "30-Knowledge/Learning/Lea-示例学习笔记.md"
    echo "✅ 示例知识笔记已创建"
else
    echo "ℹ️  示例知识笔记已存在"
fi

echo ""
echo "🎉 设置完成！"
echo ""
echo "📍 Vault位置: $VAULT_DIR"
echo ""
echo "📚 接下来的步骤："
echo "1. 在Obsidian中打开以下文件夹作为Vault: $VAULT_DIR"
echo "2. 安装必需插件: Templater, Dataview, Calendar"
echo "3. 配置Templater插件指向 90-Meta/Templates 文件夹"
echo "4. 打开 00-Dashboard/Home.md 开始使用"
echo ""
echo "💡 建议按照渐进式采用计划："
echo "   第1周: 只使用每日笔记和主页仪表盘"
echo "   第2-3周: 开始使用项目管理功能"
echo "   第4周: 添加知识管理和周报"
echo "   第2个月: 使用Claude Code自动化"
echo ""
echo "📖 详细文档请参考项目根目录的 docs/ 文件夹"