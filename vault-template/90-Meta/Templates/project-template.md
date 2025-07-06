<%*
// Enhanced project template with organization mode selection
const projectName = await tp.system.prompt("项目名称");
if (!projectName || projectName.trim() === "") {
    // 用户取消或输入为空，删除文件并退出
    await tp.file.delete();
    return;
}

// Ask about project complexity - default to single file mode
const orgMode = await tp.system.suggester(
    [
        "📄 单文件模式 - 简单项目（推荐）",
        "📚 多文件模式 - 中等复杂项目",
        "📁 文件夹模式 - 大型复杂项目"
    ],
    ["single", "multi", "folder"],
    false,
    "选择项目组织模式（默认：单文件）"
);

// Default to single file if user cancels
const finalOrgMode = orgMode || "single";

const fileName = `Project-${projectName.trim()}`;

// Check if file exists
const existingFile = tp.file.find_tfile(fileName);
if (existingFile) {
    const overwrite = await tp.system.suggester(
        ["覆盖现有文件", "取消创建"],
        [true, false]
    );
    if (!overwrite) {
        await tp.file.delete();
        return;
    }
}

// Handle different organization modes
if (finalOrgMode === "multi") {
    // Create main control file
    await tp.file.rename(fileName);
    await tp.file.move(`20-Projects/${fileName}`);
    
    // Optionally create initial sub-files
    const createSubFiles = await tp.system.suggester(
        ["创建基础文件结构", "稍后手动创建"],
        [true, false]
    );
    
    if (createSubFiles) {
        // Create basic structure files with basic content
        const requirementContent = `# ${projectName} - 需求分析\n\n## 需求背景\n\n## 核心需求\n\n## 非功能需求\n\n## 约束条件\n`;
        const planContent = `# ${projectName} - 实施计划\n\n## 实施阶段\n\n## 时间安排\n\n## 资源需求\n\n## 风险评估\n`;
        const logContent = `# ${projectName} - 过程记录\n\n## ${tp.date.now("YYYY-MM-DD")}\n### 今日进展\n- \n\n### 问题记录\n- \n\n### 明日计划\n- \n`;
        
        // Create files in the same directory as the main file
        await tp.file.create_new(requirementContent, `${fileName}-01-需求分析`, false, "20-Projects");
        await tp.file.create_new(planContent, `${fileName}-02-实施计划`, false, "20-Projects");
        await tp.file.create_new(logContent, `${fileName}-99-过程记录`, false, "20-Projects");
    }
    
    var isMultiFile = true;
} else if (finalOrgMode === "folder") {
    // Create folder structure
    const folderPath = `20-Projects/${projectName}`;
    
    // Move current file as project overview
    await tp.file.rename("00-项目总览");
    await tp.file.move(folderPath + "/00-项目总览");
    
    // Create folder structure with basic content
    const readmeContent = `# README\n\n本文件夹用于存放相关文档。\n`;
    const meetingContent = `# 会议记录\n\n## ${tp.date.now("YYYY-MM-DD")}\n### 会议主题\n\n### 参会人员\n\n### 会议内容\n\n### 决议事项\n\n### 后续行动\n`;
    
    await tp.file.create_new(readmeContent, "README", false, folderPath + "/01-需求文档");
    await tp.file.create_new(readmeContent, "README", false, folderPath + "/02-设计方案");
    await tp.file.create_new(meetingContent, "会议记录", false, folderPath + "/99-项目管理");
    
    var isFolder = true;
} else {
    // Single file mode (default)
    await tp.file.rename(fileName);
    await tp.file.move(`20-Projects/${fileName}`);
    var isMultiFile = false;
    var isFolder = false;
}

// Date variables
const dateVars = {
    date: tp.date.now("YYYY-MM-DD"),
    week: tp.date.now("GGGG-[W]WW")
};

// Generate tags array
const tags = ["project"];
if (isMultiFile) tags.push("multi-file");
if (isFolder) tags.push("folder-project");
const tagsString = tags.join(", ");

// Generate project type string
let projectType = "单文件项目";
if (finalOrgMode === "multi") {
    projectType = "多文件项目";
} else if (finalOrgMode === "folder") {
    projectType = "文件夹项目";
}

// Generate mode string for decision record
let modeString = "单文件";
if (finalOrgMode === "multi") {
    modeString = "多文件";
} else if (finalOrgMode === "folder") {
    modeString = "文件夹";
}
-%>
---
project: <% projectName %>
status: active
start_date: <% dateVars.date %>
priority: medium
tags: [<% tagsString %>]
organization: <% finalOrgMode %>
---

# 📋 <% projectName %>

## 🎯 项目概述
**目标**: 
**截止时间**: 
**负责人**: 
**参与人员**: 
**项目类型**: <% projectType %>

## 📊 当前状态
进度: ▓▓▓░░░░░░░ 30%  
状态: 🟡 进行中  
阶段: 规划阶段

<%* if (isMultiFile) { -%>
## 📚 项目文件
1. **[[<% fileName %>-01-需求分析]]** - 需求文档 ⏳
2. **[[<% fileName %>-02-实施计划]]** - 实施方案 ⏳
3. **[[<% fileName %>-99-过程记录]]** - 工作日志 ⏳

> 💡 提示：这是一个多文件项目。随着项目发展，可以添加更多编号文件。
<%* } else if (isFolder) { -%>
## 📁 项目结构
```
📁 <% projectName %>/
├── 📋 00-项目总览.md (当前文件)
├── 📁 01-需求文档/
├── 📁 02-设计方案/
├── 📁 03-实施跟踪/
└── 📁 99-项目管理/
```

> 💡 提示：这是一个文件夹项目。适合大型复杂项目的组织管理。
<%* } -%>

## ✅ 核心任务清单
### 本周任务 (<% dateVars.week %>)
- [ ] 
- [ ] 
- [ ] 

### 下周计划
- [ ] 
- [ ] 

### 待办事项池
- [ ] 

### 定期回顾
- [ ] 
- [ ] 

## 📅 里程碑计划
| 里程碑 | 目标日期 | 状态 | 备注 |
|--------|---------|------|------|
| 项目启动 | <% dateVars.date %> | 🟡进行中 | |
| 需求确认 | | ⏳待开始 | |
| 方案设计 | | ⏳待开始 | |
| 实施完成 | | ⏳待开始 | |
| 项目交付 | | ⏳待开始 | |

## ⚠️ 风险和问题
### 当前风险
- 🟡 风险1: 
- 🟢 风险2: 

### 已解决问题
- ✅ 

## 💡 关键决策记录
| 日期 | 决策内容 | 决策人 | 影响 |
|------|---------|--------|------|
| <% dateVars.date %> | 采用<% modeString %>模式组织项目 | | 项目文件组织方式 |

## 🔗 相关资源
### 内部文档
- [[Reference-项目管理最佳实践]]
<%* if (isMultiFile || isFolder) { -%>
- [[Template-子文档模板]]
<%* } -%>

### 外部链接
- 

### 会议记录
- 

## 📝 项目日志
```dataview
TABLE dateformat(file.ctime, "MM-dd HH:mm") as "时间", 
      file.link as "日志"
FROM "10-Daily"
WHERE contains(file.content, "<% projectName %>")
SORT file.ctime DESC
LIMIT 10
```

<%* if (finalOrgMode === "single") { -%>
## 📄 详细内容
<!-- 由于这是单文件项目，所有内容都在本文件中记录 -->

### 1. 背景说明


### 2. 具体方案


### 3. 实施步骤


### 4. 预期成果


<%* } -%>

## 🔄 更新记录
| 日期 | 更新内容 | 更新人 |
|------|---------|--------|
| <% dateVars.date %> | 创建项目 | |

---
*最后更新: `= dateformat(this.file.mtime, "yyyy-MM-dd HH:mm")`*