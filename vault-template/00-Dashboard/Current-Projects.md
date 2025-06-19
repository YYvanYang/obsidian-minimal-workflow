---
tags: [dashboard, projects]
---

# 📋 当前项目仪表盘

## 🚀 活跃项目
```dataview
TABLE 
  project as 项目名称,
  status as 状态,
  priority as 优先级,
  start_date as 开始日期
FROM "20-Projects"
WHERE status = "active"
SORT priority DESC, start_date ASC
```

## ⏸️ 暂停项目
```dataview
TABLE 
  project as 项目名称,
  status as 状态,
  start_date as 开始日期
FROM "20-Projects"
WHERE status = "paused"
SORT start_date DESC
```

## ✅ 最近完成
```dataview
TABLE 
  project as 项目名称,
  status as 状态,
  start_date as 开始日期
FROM "20-Projects"
WHERE status = "completed"
SORT start_date DESC
LIMIT 5
```

## 🎯 本周项目任务
```dataview
TASK
FROM "20-Projects"
WHERE status = "active" AND !completed
LIMIT 15
```

## 📊 项目统计
```dataview
TABLE 
  length(filter(rows, (r) => r.status = "active")) as 活跃项目,
  length(filter(rows, (r) => r.status = "paused")) as 暂停项目,
  length(filter(rows, (r) => r.status = "completed")) as 已完成项目
FROM "20-Projects"
GROUP BY "统计"
```

---
*更新时间: {{date:YYYY-MM-DD HH:mm}}*