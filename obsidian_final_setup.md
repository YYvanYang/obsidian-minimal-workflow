# obsidian-minimal-workflow 最终方案

## 📁 核心文件夹结构

```
📁 obsidian-minimal-workflow/
├── 📁 00-Dashboard/             # 仪表盘 - 入口和概览
│   ├── Home.md                  # 主页导航
│   ├── Current-Projects.md      # 当前项目仪表盘
│   └── Quick-Notes.md           # 快速记录区
│
├── 📁 10-Daily/                 # 日常记录
│   ├── 2024-12-20.md           # 每日笔记
│   └── ...
│
├── 📁 20-Projects/              # 项目管理
│   ├── Project-客户管理系统.md
│   ├── Project-个人网站重构.md
│   └── ...
│
├── 📁 30-Knowledge/             # 知识库
│   ├── 📁 Learning/             # 学习笔记
│   │   ├── Tech-API设计.md
│   │   └── ...
│   ├── 📁 Research/             # 深度研究
│   │   ├── Research-AI工具对比.md
│   │   └── ...
│   └── 📁 Reference/            # 参考资料
│       ├── Ref-快捷键列表.md
│       └── ...
│
├── 📁 40-Archive/               # 归档区域
│   ├── 📁 2024-Q1/
│   ├── 📁 2024-Q2/
│   └── ...
│
├── 📁 90-Meta/                  # 系统配置
│   ├── 📁 Templates/            # 模板库
│   │   ├── daily-template.md
│   │   ├── project-template.md
│   │   ├── knowledge-template.md
│   │   └── weekly-template.md
│   ├── 📁 Scripts/              # 自动化脚本
│   └── 📁 Attachments/          # 附件文件
│
└── 📁 Weekly/                   # 周报专区
    ├── 2024-W51.md
    └── ...
```

## 🎯 核心模板文件

### 1. 每日模板 (`90-Meta/Templates/daily-template.md`)
```markdown
<%*
const fileName = tp.date.now("YYYY-MM-DD");
await tp.file.rename(fileName);
await tp.file.move(`10-Daily/${fileName}`);
-%>

---
date: <% tp.date.now("YYYY-MM-DD") %>
day: <% tp.date.now("dddd") %>
week: [[<% tp.date.now("YYYY-[W]ww") %>]]
tags: [daily]
---

# <% tp.date.now("MM-DD ddd") %>

## 🎯 今日重点
- [ ] 
- [ ] 
- [ ] 

## 💼 工作记录
### 完成
- 

### 问题
- 

### 学习
- 

## 🏠 个人时间
- 

## 📋 明日待办
- [ ] 
- [ ] 

## 💭 一句话总结


<% tp.file.cursor() %>
```

### 2. 项目模板 (`90-Meta/Templates/project-template.md`)
```markdown
<%*
const projectName = await tp.system.prompt("项目名称");
const fileName = `Project-${projectName}`;
await tp.file.rename(fileName);
await tp.file.move(`20-Projects/${fileName}`);
-%>

---
project: <% projectName %>
status: active
start_date: <% tp.date.now("YYYY-MM-DD") %>
priority: medium
tags: [project]
---

# <% projectName %>

## 📋 项目概述
**目标**: 
**截止时间**: 
**关键人员**: 

## 📊 当前状态
进度: ▓▓▓░░░░░░░ 30%
状态: 🟡 进行中

## ✅ 本周任务
- [ ] 
- [ ] 
- [ ] 

## 📅 下周计划
- [ ] 
- [ ] 

## ⚠️ 风险和阻塞
- 

## 💡 关键决策
- 

## 🔗 相关资源
- 文档: [[]]
- 会议记录: [[]]

## 📝 项目日志
```dataview
LIST 
FROM "10-Daily"
WHERE contains(file.content, "<% projectName %>")
SORT file.name DESC
LIMIT 10
```
```

### 3. 知识模板 (`90-Meta/Templates/knowledge-template.md`)
```markdown
<%*
const category = await tp.system.suggester(
    ["Learning", "Research", "Reference"],
    ["Learning", "Research", "Reference"]
);
const title = await tp.system.prompt("知识标题");
const fileName = `${category.slice(0,3)}-${title}`;
await tp.file.rename(fileName);
await tp.file.move(`30-Knowledge/${category}/${fileName}`);
-%>

---
title: <% title %>
date: <% tp.date.now("YYYY-MM-DD") %>
category: <% category %>
tags: [knowledge, <% category.toLowerCase() %>]
source: 
---

# <% title %>

## 🎯 核心要点
- 
- 
- 

## 🔧 实际应用
**适用场景**: 
**使用方法**: 

## 🔗 相关连接
- 相关笔记: [[]]
- 相关项目: [[]]
- 原始资料: 

## 📝 后续行动
- [ ] 
- [ ] 

## 💭 个人思考


<% tp.file.cursor() %>
```

### 4. 周报模板 (`90-Meta/Templates/weekly-template.md`)
```markdown
<%*
const weekNum = tp.date.now("ww");
const fileName = tp.date.now("YYYY-[W]ww");
await tp.file.rename(fileName);
await tp.file.move(`Weekly/${fileName}`);
-%>

---
date: <% tp.date.now("YYYY-MM-DD") %>
week: <% tp.date.now("YYYY-[W]ww") %>
tags: [weekly]
---

# 第<% weekNum %>周总结 (<% tp.date.weekday("MM-DD", 1) %> - <% tp.date.weekday("MM-DD", 7) %>)

## 📊 本周概览

### 主要完成
```dataview
LIST
FROM "10-Daily"
WHERE date >= date(<% tp.date.weekday("YYYY-MM-DD", 1) %>) 
AND date <= date(<% tp.date.weekday("YYYY-MM-DD", 7) %>)
AND contains(file.content, "完成")
LIMIT 10
```

### 解决的问题
```dataview
LIST  
FROM "10-Daily"
WHERE date >= date(<% tp.date.weekday("YYYY-MM-DD", 1) %>)
AND date <= date(<% tp.date.weekday("YYYY-MM-DD", 7) %>)
AND contains(file.content, "问题")
LIMIT 5
```

### 学习收获
```dataview
LIST
FROM "10-Daily"
WHERE date >= date(<% tp.date.weekday("YYYY-MM-DD", 1) %>)
AND date <= date(<% tp.date.weekday("YYYY-MM-DD", 7) %>)
AND contains(file.content, "学习")
LIMIT 5
```

## 🚀 项目进展
```dataview
TABLE status as 状态, priority as 优先级
FROM "20-Projects"
WHERE status = "active"
```

## 🎯 下周计划
- [ ] 
- [ ] 
- [ ] 

## 💭 本周反思
### 做得好的
- 

### 需要改进
- 

### 下周重点
- 
```

### 5. 主页仪表盘 (`00-Dashboard/Home.md`)
```markdown
---
tags: [dashboard, home]
---

# 🏠 工作生活中心

## 🚀 快速导航
- [[00-Dashboard/Current-Projects|当前项目]]
- [[00-Dashboard/Quick-Notes|快速记录]]
- 今日笔记: [[10-Daily/{{date:YYYY-MM-DD}}]]
- 本周总结: [[Weekly/{{date:YYYY-[W]ww}}]]

## 📊 项目状态
```dataview
TABLE 
  status as 状态,
  priority as 优先级,
  start_date as 开始时间
FROM "20-Projects"
WHERE status = "active"
SORT priority DESC, start_date ASC
```

## 📅 最近7天
```dataview
TABLE WITHOUT ID 
  file.link as 日期,
  choice(contains(file.content, "完成"), "✅", "📝") as 状态
FROM "10-Daily"
WHERE date >= date(today) - dur(7 days)
SORT file.name DESC
```

## 🎯 待办事项
```dataview
TASK
FROM "10-Daily" OR "20-Projects"
WHERE !completed
LIMIT 10
```

## 📚 最近学习
```dataview
LIST
FROM "30-Knowledge"
WHERE date >= date(today) - dur(14 days)
SORT date DESC
LIMIT 5
```

---
*最后更新: {{date:YYYY-MM-DD HH:mm}}*
```

## 🤖 Claude Code集成

### `.claude/commands/` 目录结构
```
.claude/
└── commands/
    ├── daily-note.md           # 创建每日笔记
    ├── weekly-report.md        # 生成周报
    ├── project-summary.md      # 项目总结
    ├── knowledge-connect.md    # 知识连接
    └── vault-cleanup.md        # 清理维护
```

### 核心命令文件

#### `daily-note.md`
```markdown
Create today's daily note using the Obsidian minimal workflow system:

1. Use the daily template from `90-Meta/Templates/daily-template.md`
2. Create file with today's date (YYYY-MM-DD.md) in `10-Daily/` folder
3. Auto-populate all date fields and template structure
4. Link to current week's summary
5. Set cursor position for immediate editing

Template includes: daily targets, work log, personal notes, tomorrow tasks, and summary.
```

#### `weekly-report.md`
```markdown
Generate comprehensive weekly report by analyzing the Obsidian vault:

1. Scan all daily notes from this week (`10-Daily/` folder)
2. Extract completed tasks and achievements
3. Identify problems solved and lessons learned  
4. Summarize project progress from `20-Projects/` folder
5. Create actionable next week's goals
6. Use weekly template from `90-Meta/Templates/weekly-template.md`
7. Save to `Weekly/` folder with proper naming (YYYY-Www)

Focus on insights and measurable outcomes. Include both personal and professional progress.
```

#### `project-summary.md`
```markdown
Analyze and update project status:

Parameters: $ARGUMENTS (project name or "all" for all projects)

Steps:
1. Find project file(s) in `20-Projects/` folder
2. Scan related mentions in daily notes (`10-Daily/`)
3. Extract recent progress, decisions, and blockers
4. Calculate progress percentage based on completed tasks
5. Identify risks and next actions
6. Update project status and progress bar
7. Generate executive summary

Provide both high-level overview and detailed action items.
```

#### `knowledge-connect.md`
```markdown
Optimize knowledge connections in the vault:

1. Analyze notes in `30-Knowledge/` for linking opportunities
2. Identify orphaned notes without backlinks
3. Suggest connections between related concepts
4. Recommend tags for better categorization
5. Find knowledge gaps or duplicated content
6. Create connection suggestions for daily notes
7. Generate knowledge graph health report

Focus on improving discoverability and knowledge flow across the entire vault.
```

## ⚙️ 快速设置指南

### 1. 必需插件
```json
{
  "core_plugins": [
    "templater-obsidian",
    "dataview", 
    "calendar",
    "periodic-notes"
  ],
  "optional_plugins": [
    "quickadd",
    "advanced-tables",
    "excalidraw"
  ]
}
```

### 2. Templater配置
```json
{
  "template_folder": "90-Meta/Templates",
  "trigger_on_file_creation": true,
  "enable_system_commands": true,
  "shell_path": "",
  "script_folder": "90-Meta/Scripts"
}
```

### 3. 快捷键设置
```json
{
  "app:go-back": "Cmd+[",
  "app:go-forward": "Cmd+]",
  "daily-notes": "Cmd+T",
  "templater-obsidian:insert-templater": "Cmd+Shift+T",
  "command-palette:open": "Cmd+P",
  "global-search": "Cmd+Shift+F"
}
```

### 4. 文件夹自动化规则
```javascript
// 在Templater设置中配置文件夹规则
const folderRules = {
  "10-Daily": "daily-template",
  "20-Projects": "project-template", 
  "30-Knowledge/Learning": "knowledge-template",
  "30-Knowledge/Research": "knowledge-template",
  "30-Knowledge/Reference": "knowledge-template",
  "Weekly": "weekly-template"
};
```

## 📦 仓库最终结构

```
obsidian-minimal-workflow/
├── README.md                           # 项目介绍和快速开始
├── SETUP.md                           # 详细安装指南
├── .claude/                           # Claude Code集成
│   └── commands/
│       ├── daily-note.md
│       ├── weekly-report.md
│       ├── project-summary.md
│       ├── knowledge-connect.md
│       └── vault-cleanup.md
├── vault-template/                    # Vault模板文件
│   ├── 00-Dashboard/
│   │   ├── Home.md
│   │   ├── Current-Projects.md
│   │   └── Quick-Notes.md
│   ├── 10-Daily/
│   │   └── .gitkeep
│   ├── 20-Projects/
│   │   └── .gitkeep
│   ├── 30-Knowledge/
│   │   ├── Learning/
│   │   ├── Research/
│   │   └── Reference/
│   ├── 40-Archive/
│   │   └── .gitkeep
│   ├── 90-Meta/
│   │   ├── Templates/
│   │   │   ├── daily-template.md
│   │   │   ├── project-template.md
│   │   │   ├── knowledge-template.md
│   │   │   └── weekly-template.md
│   │   ├── Scripts/
│   │   └── Attachments/
│   └── Weekly/
│       └── .gitkeep
├── examples/                          # 示例文件
│   ├── sample-daily-note.md
│   ├── sample-project.md
│   ├── sample-knowledge.md
│   └── sample-weekly-report.md
├── assets/                           # 图片和演示
│   ├── folder-structure.png
│   ├── dashboard-demo.png
│   └── workflow-demo.gif
├── docs/                             # 详细文档
│   ├── best-practices.md
│   ├── claude-integration.md
│   ├── customization-guide.md
│   └── troubleshooting.md
├── scripts/                          # 设置脚本
│   ├── setup.sh                     # 自动化设置脚本
│   └── backup.sh                    # 备份脚本
├── .obsidian/                        # Obsidian配置
│   ├── plugins/
│   ├── templates/
│   └── app.json
├── LICENSE                           # 开源协议
└── CHANGELOG.md                      # 版本更新记录
```

## 🚀 5分钟快速开始

### 一键设置脚本 (`scripts/setup.sh`)
```bash
#!/bin/bash

echo "🚀 开始设置 obsidian-minimal-workflow..."

# 1. 复制文件夹结构
cp -r vault-template/* ./
echo "✅ 文件夹结构已创建"

# 2. 复制Obsidian配置
cp -r .obsidian ./
echo "✅ Obsidian配置已应用"

# 3. 复制Claude Code命令
cp -r .claude ./
echo "✅ Claude Code集成已配置"

# 4. 创建第一个每日笔记
DATE=$(date +%Y-%m-%d)
cp examples/sample-daily-note.md "10-Daily/${DATE}.md"
echo "✅ 今日笔记已创建: 10-Daily/${DATE}.md"

echo "🎉 设置完成！请打开Obsidian并导航到主页仪表盘开始使用。"
echo "📚 详细文档请参考: docs/best-practices.md"
```

## 🎯 使用工作流

### 日常使用流程
1. **晨间(3分钟)**: 打开今日笔记，设定3个重点任务
2. **工作中**: 随时记录完成事项、遇到问题、新学知识
3. **晚间(5分钟)**: 总结今日，设置明日待办，一句话反思

### 每周回顾
- **周五**: 运行 `claude /weekly-report` 自动生成周报
- **周日**: 回顾本周，规划下周，调整项目优先级

### 月度优化  
- **清理**: 运行 `claude /vault-cleanup` 整理文件
- **连接**: 运行 `claude /knowledge-connect` 优化知识图谱
- **归档**: 将旧内容移动到 `40-Archive` 文件夹

这套方案平衡了功能性和简洁性，既能满足日常需求，又保持了系统的可维护性。核心理念是**先使用，再优化**，让系统自然成长。