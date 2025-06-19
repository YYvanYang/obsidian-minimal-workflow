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