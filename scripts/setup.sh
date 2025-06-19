#!/bin/bash

echo "🚀 开始设置 obsidian-minimal-workflow..."

# 检查当前目录是否为空
if [ "$(ls -A . 2>/dev/null)" ]; then
    echo "⚠️  当前目录不为空，建议在空目录中运行此脚本"
    echo "是否继续？(y/N)"
    read -r response
    if [[ ! "$response" =~ ^[yY]$ ]]; then
        echo "❌ 安装已取消"
        exit 1
    fi
fi

# 1. 复制文件夹结构
echo "📁 创建文件夹结构..."
cp -r vault-template/* ./
echo "✅ 文件夹结构已创建"

# 2. 复制Claude Code命令
echo "🤖 配置Claude Code集成..."
cp -r .claude ./
echo "✅ Claude Code集成已配置"

# 3. 创建第一个每日笔记
echo "📝 创建今日笔记..."
DATE=$(date +%Y-%m-%d)
if [ ! -f "10-Daily/${DATE}.md" ]; then
    cp examples/sample-daily-note.md "10-Daily/${DATE}.md"
    # 更新日期
    sed -i '' "s/2024-12-20/${DATE}/g" "10-Daily/${DATE}.md"
    echo "✅ 今日笔记已创建: 10-Daily/${DATE}.md"
else
    echo "ℹ️  今日笔记已存在: 10-Daily/${DATE}.md"
fi

# 4. 创建本周周报
echo "📊 创建本周周报..."
WEEK=$(date +%Y-W%U)
if [ ! -f "Weekly/${WEEK}.md" ]; then
    cp examples/sample-weekly-report.md "Weekly/${WEEK}.md"
    # 更新周数
    sed -i '' "s/2024-W51/${WEEK}/g" "Weekly/${WEEK}.md"
    echo "✅ 本周周报已创建: Weekly/${WEEK}.md"
else
    echo "ℹ️  本周周报已存在: Weekly/${WEEK}.md"
fi

# 5. 创建示例项目
echo "🎯 创建示例项目..."
if [ ! -f "20-Projects/Project-示例项目.md" ]; then
    cp examples/sample-project.md "20-Projects/Project-示例项目.md"
    echo "✅ 示例项目已创建"
else
    echo "ℹ️  示例项目已存在"
fi

# 6. 创建示例知识笔记
echo "📚 创建示例知识笔记..."
if [ ! -f "30-Knowledge/Learning/Lea-示例学习笔记.md" ]; then
    cp examples/sample-knowledge.md "30-Knowledge/Learning/Lea-示例学习笔记.md"
    echo "✅ 示例知识笔记已创建"
else
    echo "ℹ️  示例知识笔记已存在"
fi

echo ""
echo "🎉 设置完成！"
echo ""
echo "📚 接下来的步骤："
echo "1. 在Obsidian中打开当前文件夹作为Vault"
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
echo "📖 详细文档请参考: docs/best-practices.md"
echo "🔧 故障排除请参考: docs/troubleshooting.md"