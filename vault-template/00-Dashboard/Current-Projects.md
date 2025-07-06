---
tags: [dashboard, projects]
---

# 📋 当前项目仪表盘

## 📌 今日待办
```dataview
TASK
FROM "20-Projects" OR "10-Daily"
WHERE !completed
LIMIT 10
```

## ⚡ 本周重要任务
```dataview
TASK
FROM "20-Projects"
WHERE !completed AND file.mtime >= date(now) - dur(7 days)
GROUP BY file.link
LIMIT 15
```

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
LIMIT 20
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
LIMIT 10
```

## ✅ 最近完成
```dataview
TABLE 
  project as 项目名称,
  status as 状态,
  start_date as 开始日期
FROM "20-Projects"
WHERE status = "completed"
SORT file.mtime DESC
LIMIT 5
```

## 🎯 项目任务总览
```dataview
TASK
FROM "20-Projects"
WHERE !completed
GROUP BY file.link
LIMIT 20
```

## 🔄 定期回顾任务
```dataview
TASK
FROM "20-Projects"
WHERE !completed AND contains(text, "回顾")
LIMIT 10
```

## 📊 项目统计
```dataview
TABLE WITHOUT ID
  length(filter(rows, (r) => r.status = "active")) as "🟢 活跃",
  length(filter(rows, (r) => r.status = "paused")) as "🟡 暂停",
  length(filter(rows, (r) => r.status = "completed")) as "✅ 完成"
FROM "20-Projects"
WHERE file.name != "Project-Template"
GROUP BY true
```

---
*更新时间: `= dateformat(this.file.mtime, "yyyy-MM-dd HH:mm")`*