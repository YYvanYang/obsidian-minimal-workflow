<%*
const weekNum = tp.date.now("ww");
const fileName = tp.date.now("YYYY-[W]ww");
await tp.file.rename(fileName);
await tp.file.move(`Weekly/${fileName}`);
// 计算本周的起止日期
const currentDate = tp.date.now("YYYY-MM-DD");
const dayOfWeek = tp.date.now("d");
const monday = tp.date.now("YYYY-MM-DD", -dayOfWeek + 1);
const sunday = tp.date.now("YYYY-MM-DD", 7 - dayOfWeek);
const mondayFormatted = tp.date.now("MM-DD", -dayOfWeek + 1);
const sundayFormatted = tp.date.now("MM-DD", 7 - dayOfWeek);
-%>

---
date: <% tp.date.now("YYYY-MM-DD") %>
week: <% tp.date.now("YYYY-[W]ww") %>
tags: [weekly]
---

# 第<% weekNum %>周总结 (<% mondayFormatted %> - <% sundayFormatted %>)

## 📊 本周概览

### 主要完成
```dataview
LIST
FROM "10-Daily"
WHERE date >= date("<% monday %>") 
AND date <= date("<% sunday %>")
AND contains(file.content, "完成")
LIMIT 10
```

### 解决的问题
```dataview
LIST  
FROM "10-Daily"
WHERE date >= date("<% monday %>")
AND date <= date("<% sunday %>")
AND contains(file.content, "问题")
LIMIT 5
```

### 学习收获
```dataview
LIST
FROM "10-Daily"
WHERE date >= date("<% monday %>")
AND date <= date("<% sunday %>")
AND contains(file.content, "学习")
LIMIT 5
```

## 🚀 项目进展
```dataview
TABLE status as 状态, priority as 优先级
FROM "20-Projects"
WHERE status = "active"
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