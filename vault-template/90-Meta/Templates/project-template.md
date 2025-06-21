<%*
const projectName = await tp.system.prompt("项目名称");
if (!projectName || projectName.trim() === "") {
    // 用户取消或输入为空，删除文件并退出
    await tp.file.delete();
    return;
}
const fileName = `Project-${projectName.trim()}`;
// 检查文件是否已存在
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
FROM "10-Daily" AND #daily
WHERE contains(file.content, "<% projectName %>")
SORT file.ctime DESC
LIMIT 10
```