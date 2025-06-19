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