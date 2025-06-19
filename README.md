# 🧠 Obsidian Minimal Workflow

> 一个简洁、高效的个人知识管理系统，集成Claude Code智能化功能

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Obsidian](https://img.shields.io/badge/Obsidian-Compatible-purple)](https://obsidian.md/)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-Integrated-blue)](https://claude.ai/code)

## ✨ 特性亮点

- 🎯 **渐进式采用**: 从简单日记到完整知识管理系统
- 🤖 **AI增强**: 集成Claude Code实现智能洞察和自动化
- 📊 **动态仪表盘**: Dataview驱动的实时数据展示
- 🔄 **自动化模板**: Templater驱动的智能文件创建
- 📁 **科学分类**: 基于P.A.R.A.方法论的文件夹结构
- 🛠️ **开箱即用**: 5分钟快速设置，立即可用

## 🚀 快速开始

### 一键安装

```bash
git clone https://github.com/YYvanYang/obsidian-minimal-workflow.git
cd obsidian-minimal-workflow
chmod +x scripts/setup.sh
./scripts/setup.sh
```

### 手动安装

1. **下载并设置**
   ```bash
   git clone https://github.com/YYvanYang/obsidian-minimal-workflow.git
   cd obsidian-minimal-workflow
   cp -r vault-template/* ./
   ```

2. **在Obsidian中打开**
   - 打开Obsidian
   - 选择"Open folder as vault"
   - 选择项目目录

3. **安装必需插件**
   - Templater (模板系统)
   - Dataview (动态查询)
   - Calendar (日历视图)

4. **开始使用**
   - 打开 `00-Dashboard/Home.md` 查看主页
   - 按 `Cmd+T` 创建今日笔记

## 📁 文件夹结构

```
📁 你的工作空间/
├── 📁 00-Dashboard/          # 🏠 仪表盘 - 一切的入口
│   ├── Home.md              # 主页导航中心
│   ├── Current-Projects.md   # 项目状态总览
│   └── Quick-Notes.md       # 快速记录捕获
│
├── 📁 10-Daily/             # 📅 每日记录
│   ├── 2024-12-20.md       # 今日笔记
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
│   └── Scripts/             # 自动化脚本
│
└── 📁 Weekly/               # 📊 周报专区
```

## 🎯 核心工作流程

### 📅 日常使用 (每天5分钟)

1. **晨间规划** (2分钟)
   - 按 `Cmd+T` 创建今日笔记
   - 设定3个今日重点任务

2. **过程记录** (随时)
   - 记录完成的工作
   - 捕获遇到的问题
   - 记录学到的知识

3. **晚间回顾** (3分钟)
   - 总结今日成果
   - 设置明日待办
   - 写下一句话反思

### 📊 每周回顾

- **周五**: 运行 `claude /weekly-report` 自动生成周报
- **周日**: 回顾本周，规划下周重点

### 🧹 月度维护

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

### AI辅助特性

- **智能周报生成**: 自动分析一周的笔记，提取关键成果和洞察
- **项目进度跟踪**: 基于日常记录分析项目状态和风险
- **知识连接发现**: 识别相关知识点，建议创建双向链接
- **系统健康检查**: 发现孤立文件、重复内容、优化建议

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
# 在模板front matter中添加自定义字段
mood: 😊          # 心情记录
energy: 8/10      # 精力水平  
weather: sunny    # 天气状况
custom_tag: work  # 自定义标签
---
```

### 扩展Claude命令

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

### Dataview高级查询

```javascript
// 显示本月高优先级项目
TABLE priority, status, start_date
FROM "20-Projects" 
WHERE priority = "high" AND start_date >= date(today) - dur(30 days)
SORT start_date DESC
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

### 第1周: 基础习惯建立
- ✅ 每天创建并填写日常笔记
- ✅ 使用主页仪表盘导航
- ✅ 熟悉基础快捷键

### 第2-3周: 项目管理
- ✅ 创建第一个项目文件
- ✅ 在日常笔记中关联项目
- ✅ 使用项目仪表盘跟踪进度

### 第4周: 知识管理
- ✅ 开始记录学习笔记
- ✅ 创建知识之间的双向链接
- ✅ 使用周报功能回顾

### 第2个月: AI增强
- ✅ 配置Claude Code集成
- ✅ 使用智能命令自动化工作流
- ✅ 定制个人专用命令

## 🛠️ 技术支持

### 系统要求

- **Obsidian**: v1.0.0+
- **操作系统**: Windows/macOS/Linux
- **Claude Code**: v1.0.0+ (可选，用于AI功能)

### 必需插件

| 插件 | 用途 | 必需性 |
|------|------|--------|
| Templater | 模板系统 | ✅ 必需 |
| Dataview | 动态查询 | ✅ 必需 |
| Calendar | 日历视图 | 🔸 推荐 |
| Periodic Notes | 周期笔记 | 🔸 推荐 |

### 故障排除

常见问题请查看 [troubleshooting.md](docs/troubleshooting.md)

## 🤝 贡献指南

欢迎提交改进建议！

1. Fork 此仓库
2. 创建特性分支: `git checkout -b feature/amazing-feature`
3. 提交更改: `git commit -m 'Add amazing feature'`
4. 推送分支: `git push origin feature/amazing-feature`
5. 创建 Pull Request

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 🙏 致谢

- [Obsidian](https://obsidian.md/) - 优秀的知识管理平台
- [P.A.R.A. Method](https://fortelabs.co/blog/para/) - 文件组织方法论
- [Claude](https://claude.ai/) - AI助手支持
- 所有贡献者和使用者的反馈

---

**开始你的知识管理之旅** 🚀

如果这个项目对你有帮助，请给个 ⭐️ 支持一下！
