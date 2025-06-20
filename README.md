# 🧠 Obsidian Minimal Workflow

> 一个简洁、高效的个人知识管理系统，集成 Claude Code 智能化功能

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Obsidian](https://img.shields.io/badge/Obsidian-Compatible-purple)](https://obsidian.md/)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-Integrated-blue)](https://claude.ai/code)
[![Version](https://img.shields.io/badge/Version-0.2.0-green)](https://github.com/YYvanYang/obsidian-minimal-workflow/releases)

## ✨ 特性亮点

- 🎯 **渐进式采用**: 从简单日记到完整知识管理系统
- 🤖 **AI 增强**: 集成 Claude Code 实现智能洞察和自动化
- 📊 **动态仪表盘**: Dataview 驱动的实时数据展示
- 🔄 **自动化模板**: Templater 驱动的智能文件创建
- 📁 **科学分类**: 基于 P.A.R.A. 方法论的文件夹结构
- 🛠️ **开箱即用**: 5 分钟快速设置，立即可用
- 🏥 **健康检查**: 内置 Vault 健康检查和维护工具
- 💾 **智能备份**: 支持完整和增量备份策略

## 🚀 快速开始

### 一键安装

```bash
git clone https://github.com/YYvanYang/obsidian-minimal-workflow.git
cd obsidian-minimal-workflow
chmod +x scripts/setup.sh
./scripts/setup.sh
```

设置脚本提供三种选项：
1. 在当前目录创建 Vault
2. 选择现有目录
3. 创建新目录

脚本会自动：
- ✅ 创建完整的文件夹结构
- ✅ 初始化项目配置
- ✅ 替换文档中的占位符
- ✅ 创建今日笔记和示例文件
- ✅ 运行初始健康检查

### 手动安装

如果你更喜欢手动控制安装过程：

1. **克隆项目**
   ```bash
   git clone https://github.com/YYvanYang/obsidian-minimal-workflow.git
   cd obsidian-minimal-workflow
   ```

2. **复制文件结构**
   ```bash
   cp -r vault-template/* ./
   cp -r .claude ./
   cp -r docs ./
   cp -r scripts ./
   chmod +x scripts/*.sh
   ```

3. **在 Obsidian 中打开**
   - 打开 Obsidian
   - 选择 "Open folder as vault"
   - 选择项目目录

4. **安装必需插件**
   - **Templater** (v1.16.0+) - 模板系统核心
   - **Dataview** (v0.5.56+) - 动态内容查询  
   - **Calendar** (v1.5.10+) - 日历视图
   - **Periodic Notes** (v0.0.17+) - 周期性笔记

## 📁 文件夹结构

```
📁 你的工作空间/
├── 📁 00-Dashboard/          # 🏠 仪表盘 - 一切的入口
│   ├── Home.md              # 主页导航中心
│   ├── Current-Projects.md   # 项目状态总览
│   └── Quick-Notes.md       # 快速记录捕获
│
├── 📁 10-Daily/             # 📅 每日记录
│   ├── 2024-06-20.md       # 今日笔记
│   └── ...                 # 历史每日笔记
│
├── 📁 20-Projects/          # 🎯 项目管理
│   ├── Project-客户系统.md   # 具体项目文件
│   └── ...                 # 其他项目
│
├── 📁 30-Knowledge/         # 📚 知识宝库
│   ├── 📁 Learning/         # 学习笔记
│   ├── 📁 Research/         # 深度研究
│   └── 📁 Reference/        # 参考资料
│
├── 📁 40-Archive/           # 📦 归档区域
├── 📁 90-Meta/              # ⚙️ 系统配置
│   ├── Templates/           # 模板库
│   ├── Scripts/             # 自动化脚本
│   └── Attachments/         # 附件存储
│
├── 📁 Weekly/               # 📊 周报专区
├── 📁 .claude/              # 🤖 Claude Code 命令
├── 📁 .obsidian-workflow/   # 🔧 项目配置
├── 📁 docs/                 # 📚 文档资料
└── 📁 scripts/              # 🛠️ 实用脚本
```

## 🎯 核心工作流程

### 📅 日常使用 (每天 5 分钟)

1. **晨间规划** (2 分钟)
   - 按 `Cmd+T` 创建今日笔记
   - 设定 3 个今日重点任务

2. **过程记录** (随时)
   - 记录完成的工作
   - 捕获遇到的问题
   - 记录学到的知识

3. **晚间回顾** (3 分钟)
   - 总结今日成果
   - 设置明日待办
   - 写下一句话反思

### 📊 每周回顾

- **周五**: 运行 `claude /weekly-report` 自动生成周报
- **周日**: 回顾本周，规划下周重点

### 🧹 月度维护

- 运行 `./scripts/health-check.sh` 检查系统健康
- 运行 `claude /vault-cleanup` 整理文件
- 运行 `claude /knowledge-connect` 优化知识连接
- 归档旧内容到 `40-Archive`

## 🤖 Claude Code 集成

### 智能命令

```bash
# 创建今日笔记
claude /daily-note

# 生成周报
claude /weekly-report  

# 项目状态分析
claude /project-summary "项目名称"

# 知识图谱优化
claude /knowledge-connect

# 系统清理维护
claude /vault-cleanup
```

### AI 辅助特性

- **智能周报生成**: 自动分析一周的笔记，提取关键成果和洞察
- **项目进度跟踪**: 基于日常记录分析项目状态和风险
- **知识连接发现**: 识别相关知识点，建议创建双向链接
- **系统健康检查**: 发现孤立文件、重复内容、优化建议

## 🛠️ 实用脚本

### 健康检查脚本
```bash
# 运行 Vault 健康检查
./scripts/health-check.sh

# 检查内容包括：
# - 文件夹结构完整性
# - 孤立文件检测
# - 断开链接查找
# - 重复文件识别
# - 大文件和空文件警告
```

### 备份脚本
```bash
# 完整备份
./scripts/backup.sh full

# 增量备份（仅备份最近 7 天的更改）
./scripts/backup.sh incremental

# 自定义备份位置和保留天数
BACKUP_DIR=~/Backups RETENTION_DAYS=60 ./scripts/backup.sh
```

## 🎨 自定义指南

### 模板个性化

所有模板位于 `90-Meta/Templates/`，可根据个人习惯调整：

- `daily-template.md` - 每日笔记结构
- `project-template.md` - 项目管理模板  
- `knowledge-template.md` - 知识笔记模板
- `weekly-template.md` - 周报生成模板

### 添加自定义字段

```markdown
---
# 在模板 front matter 中添加自定义字段
mood: 😊          # 心情记录
energy: 8/10      # 精力水平  
weather: sunny    # 天气状况
custom_tag: work  # 自定义标签
---
```

### 扩展 Claude 命令

在 `.claude/commands/` 中创建新的命令文件：

```markdown
# .claude/commands/my-custom-command.md
分析我的学习进展并提供改进建议：

1. 扫描 30-Knowledge/Learning/ 文件夹
2. 统计学习笔记数量和主题分布
3. 识别学习模式和偏好
4. 提供个性化学习建议
```

## 📚 进阶使用

### Dataview 高级查询

```javascript
// 显示本月高优先级项目
TABLE priority, status, start_date
FROM "20-Projects" 
WHERE priority = "high" AND start_date >= date(today) - dur(30 days)
SORT start_date DESC
LIMIT 10
```

### 模板高级语法

```javascript
<%*
// 智能文件命名和移动
const category = await tp.system.suggester(
    ["工作", "学习", "生活"],
    ["work", "study", "life"]
);
const title = await tp.system.prompt("笔记标题");
const fileName = `${category}-${title}`;
await tp.file.rename(fileName);
-%>
```

## 🔄 渐进式采用计划

### 第 1 周: 基础习惯建立
- ✅ 每天创建并填写日常笔记
- ✅ 使用主页仪表盘导航
- ✅ 熟悉基础快捷键

### 第 2-3 周: 项目管理
- ✅ 创建第一个项目文件
- ✅ 在日常笔记中关联项目
- ✅ 使用项目仪表盘跟踪进度

### 第 4 周: 知识管理
- ✅ 开始记录学习笔记
- ✅ 创建知识之间的双向链接
- ✅ 使用周报功能回顾

### 第 2 个月: AI 增强
- ✅ 配置 Claude Code 集成
- ✅ 使用智能命令自动化工作流
- ✅ 定制个人专用命令

## 🛡️ 系统要求

### 软件版本
- **Obsidian**: v1.0.0+ (推荐 v1.5.0+)
- **操作系统**: Windows/macOS/Linux
- **Claude Code**: v1.0.0+ (可选，用于 AI 功能)

### 必需插件

| 插件 | 用途 | 最低版本 | 必需性 |
|------|------|----------|--------|
| Templater | 模板系统 | v1.16.0 | ✅ 必需 |
| Dataview | 动态查询 | v0.5.56 | ✅ 必需 |
| Calendar | 日历视图 | v1.5.10 | 🔸 推荐 |
| Periodic Notes | 周期笔记 | v0.0.17 | 🔸 推荐 |

## 🚨 故障排除

常见问题请查看 [troubleshooting.md](docs/troubleshooting.md)

快速解决方案：
- **模板不工作**: 检查 Templater 设置中的模板文件夹路径
- **查询无结果**: 确认 Dataview 插件已启用
- **文件未移动**: 检查目标文件夹是否存在

## 🤝 贡献指南

欢迎提交改进建议！

1. Fork 此仓库
2. 创建特性分支: `git checkout -b feature/amazing-feature`
3. 提交更改: `git commit -m 'Add amazing feature'`
4. 推送分支: `git push origin feature/amazing-feature`
5. 创建 Pull Request

详见 [CONTRIBUTING.md](CONTRIBUTING.md)

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 🙏 致谢

- [Obsidian](https://obsidian.md/) - 优秀的知识管理平台
- [P.A.R.A. Method](https://fortelabs.co/blog/para/) - 文件组织方法论
- [Claude](https://claude.ai/) - AI 助手支持
- [Templater](https://github.com/SilentVoid13/Templater) - 强大的模板插件
- [Dataview](https://github.com/blacksmithgu/obsidian-dataview) - 数据查询引擎
- 所有贡献者和使用者的反馈

## 📈 项目状态

- **当前版本**: v0.2.0
- **最后更新**: 2024-06-20
- **开发状态**: 活跃维护中
- **下个版本**: v0.3.0 (计划中)

## 🌟 Star 历史

[![Star History Chart](https://api.star-history.com/svg?repos=YYvanYang/obsidian-minimal-workflow&type=Date)](https://star-history.com/#YYvanYang/obsidian-minimal-workflow&Date)

---

**开始你的知识管理之旅** 🚀

如果这个项目对你有帮助，请给个 ⭐️ 支持一下！

有问题或建议？欢迎 [提交 Issue](https://github.com/YYvanYang/obsidian-minimal-workflow/issues) 或加入 [Discussions](https://github.com/YYvanYang/obsidian-minimal-workflow/discussions)。