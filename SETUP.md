# 🚀 Obsidian Minimal Workflow 安装指南

## 快速开始 (5分钟设置)

### 方法1: 自动化设置脚本

```bash
# 克隆仓库
git clone https://github.com/YYvanYang/obsidian-minimal-workflow.git
cd obsidian-minimal-workflow

# 运行自动化设置
chmod +x scripts/setup.sh
./scripts/setup.sh
```

**设置流程:**
1. **输入 Vault 名称** - 脚本会自动转换为合适的目录名
2. **选择创建位置** - 提供三种选项：
   - **当前目录** - 在当前目录创建以 Vault 名称命名的文件夹
   - **指定目录** - 在自定义父目录中创建 Vault 文件夹
   - **现有目录** - 使用现有的空目录作为 Vault

**示例创建路径:**
- 当前目录: `./My-Knowledge-Base/`
- 指定目录: `~/Documents/My-Knowledge-Base/`
- 现有目录: `/path/to/existing/empty/folder/`

### 方法2: 手动设置

1. **下载项目**
   ```bash
   git clone https://github.com/YYvanYang/obsidian-minimal-workflow.git
   cd obsidian-minimal-workflow
   ```

2. **复制文件结构**
   ```bash
   cp -r vault-template/* ./
   cp -r vault-template/.obsidian ./  # 复制预设配置
   cp -r .claude ./
   ```

3. **创建初始文件**
   ```bash
   # 创建今日笔记
   DATE=$(date +%Y-%m-%d)
   cp examples/sample-daily-note.md "10-Daily/${DATE}.md"
   
   # 创建示例项目
   cp examples/sample-project.md "20-Projects/Project-示例项目.md"
   ```

## 📋 必需插件安装

在Obsidian中安装以下核心插件：

### 核心插件 (必装)
1. **Templater** - 模板系统核心
2. **Dataview** - 动态内容查询  
3. **Calendar** - 日历视图
4. **Periodic Notes** - 周期性笔记

### 推荐插件 (可选)
1. **QuickAdd** - 快速创建内容
2. **Advanced Tables** - 表格编辑增强
3. **Excalidraw** - 手绘图表

## ⚙️ 插件配置

### 🎯 自动配置说明
运行 `setup.sh` 后，以下配置已自动完成：
- ✅ **附件存储路径**设置为 `90-Meta/Attachments`
- ✅ **Templater** 插件配置和文件夹模板映射
- ✅ **Dataview** 中文界面设置
- ✅ **Calendar** 和 **Periodic Notes** 的 ISO 8601 周数格式

**您只需要：**
1. 从社区商店安装插件
2. 重启 Obsidian 即可使用

### 1. Templater 配置（已自动完成）
```json
{
  "templates_folder": "90-Meta/Templates",
  "trigger_on_file_creation": true,
  "auto_jump_to_cursor": true,
  "enable_folder_templates": true
}
```

### 2. 文件夹模板映射（已自动完成）
| 文件夹 | 模板 |
|--------|------|
| `10-Daily` | `daily-template` |
| `20-Projects` | `project-template` |
| `30-Knowledge/Learning` | `knowledge-template` |
| `30-Knowledge/Research` | `knowledge-template` |
| `30-Knowledge/Reference` | `knowledge-template` |
| `30-Knowledge/Personal` | `personal-template` |
| `Weekly` | `weekly-template` |

### 3. Daily Notes 配置（已自动完成）
```json
{
  "format": "YYYY-MM-DD",
  "folder": "10-Daily",
  "template": "90-Meta/Templates/daily-template"
}
```

### 4. Periodic Notes 配置（已自动完成）
```json
{
  "weekly": {
    "enabled": true,
    "format": "GGGG-[W]WW",
    "folder": "Weekly",
    "template": "90-Meta/Templates/weekly-template"
  }
}
```

### 5. 手动配置（如需调整）
如果需要修改自动配置，可以在 Obsidian 设置中调整：
- **Settings → Files & Links** - 修改附件存储路径
- **Settings → Community plugins → 各插件** - 调整插件设置

## ⌨️ 推荐快捷键

```json
{
  "app:go-back": "Cmd+[",
  "app:go-forward": "Cmd+]",
  "daily-notes": "Cmd+T",
  "templater-obsidian:insert-templater": "Cmd+Shift+T",
  "command-palette:open": "Cmd+P",
  "global-search": "Cmd+Shift+F",
  "quick-switcher:open": "Cmd+O"
}
```

## 🔧 Claude Code 集成设置

### 1. 确保Claude Code已安装
```bash
# 检查Claude Code
claude --version
```

### 2. 验证命令集成
```bash
# 测试命令
claude /daily-note
claude /weekly-report
claude /project-summary all
```

### 3. 自定义命令路径
如果需要自定义命令位置，修改 `.claude/commands/` 目录中的文件。

## 📱 移动端设置

### iOS/Android Obsidian App
1. 同步设置保持一致
2. 核心插件自动同步
3. 推荐开启 "Mobile toolbar" 快速访问

## 🔄 数据同步设置

### 方法1: Obsidian Sync (推荐)
- 官方同步服务，最稳定
- 支持版本历史和冲突解决

### 方法2: iCloud/OneDrive/Dropbox
- 免费选项
- 注意避免同时编辑造成冲突

### 方法3: Git同步
```bash
# 定期备份到Git
git add .
git commit -m "Daily sync $(date +%Y-%m-%d)"
git push
```

## 🚨 常见问题排查

### Q: 模板无法自动应用
**A:** 检查Templater配置:
1. 确认模板文件夹路径正确
2. 确认开启了"Trigger on new file creation"
3. 重启Obsidian

### Q: Dataview查询不显示内容  
**A:** 检查以下几点:
1. 确认Dataview插件已开启
2. 检查文件的front matter格式
3. 确认查询语法正确

### Q: 文件无法移动到正确文件夹
**A:** 检查Templater脚本:
1. 确认目标文件夹已存在
2. 检查文件夹名称大小写
3. 查看Templater控制台错误信息

### Q: Claude Code命令不工作
**A:** 验证设置:
1. 确认`.claude/commands/`目录存在
2. 检查命令文件权限
3. 验证Claude Code版本兼容性

## 📊 性能优化建议

### 大型Vault优化
1. **Dataview查询优化**
   - 使用WHERE条件限制范围
   - 避免全库扫描查询
   - 适当使用LIMIT限制结果数量

2. **文件管理**
   - 定期归档旧文件到`40-Archive`
   - 清理未使用的附件
   - 保持合理的文件夹深度

3. **插件管理**
   - 只开启必需插件
   - 定期更新插件版本
   - 监控插件性能影响

## 🛠️ 自定义建议

### 个人化配置
1. 修改模板内容适应个人习惯
2. 调整文件夹结构
3. 自定义Dataview查询
4. 添加个人专用的Claude命令

### 团队使用
1. Fork仓库进行团队定制
2. 建立团队模板库
3. 制定命名规范
4. 设置共享知识库区域

## 📞 获取帮助

- **问题报告**: [GitHub Issues](https://github.com/YYvanYang/obsidian-minimal-workflow/issues)
- **功能建议**: [GitHub Discussions](https://github.com/YYvanYang/obsidian-minimal-workflow/discussions)
- **文档**: `docs/` 文件夹中的详细指南