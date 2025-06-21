<%*
// 缓存日期变量以提高性能
const dayOfWeek = tp.date.now("d");
const dateVars = {
    weekNum: tp.date.now("WW"),
    fileName: tp.date.now("GGGG-[W]WW"),
    currentDate: tp.date.now("YYYY-MM-DD"),
    monday: tp.date.now("YYYY-MM-DD", -dayOfWeek + 1),
    sunday: tp.date.now("YYYY-MM-DD", 7 - dayOfWeek),
    mondayFormatted: tp.date.now("MM-DD", -dayOfWeek + 1),
    sundayFormatted: tp.date.now("MM-DD", 7 - dayOfWeek)
};

await tp.file.rename(dateVars.fileName);
await tp.file.move(`Weekly/${dateVars.fileName}`);
-%>
---
date: <% dateVars.currentDate %>
week: <% dateVars.fileName %>
tags: [weekly]
---

# 第<% dateVars.weekNum %>周总结 (<% dateVars.mondayFormatted %> - <% dateVars.sundayFormatted %>)

## 📊 本周概览

### 主要完成
```dataview
LIST
FROM "10-Daily" AND #daily
WHERE date >= date("<% dateVars.monday %>") 
AND date <= date("<% dateVars.sunday %>")
AND contains(file.content, "完成")
SORT file.ctime DESC
LIMIT 10
```

### 解决的问题
```dataview
LIST  
FROM "10-Daily" AND #daily
WHERE date >= date("<% dateVars.monday %>")
AND date <= date("<% dateVars.sunday %>")
AND contains(file.content, "问题")
SORT file.ctime DESC
LIMIT 5
```

### 学习收获
```dataview
LIST
FROM "10-Daily" AND #daily
WHERE date >= date("<% dateVars.monday %>")
AND date <= date("<% dateVars.sunday %>")
AND contains(file.content, "学习")
SORT file.ctime DESC
LIMIT 5
```

## 🚀 项目进展
```dataview
TABLE status as 状态, priority as 优先级
FROM "20-Projects" AND #project
WHERE status = "active"
SORT priority DESC
LIMIT 10
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