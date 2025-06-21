---
tags: [dashboard, balance, areas]
---

# 🌟 生活平衡仪表盘

## 📊 本月各领域活动分布

### 💼 工作领域
```dataview
TABLE WITHOUT ID
  week as "📅 周",
  length(rows) as "📝 记录数",
  choice(length(filter(rows, (r) => contains(r.file.content, "<!-- area:work -->"))) > 0, "💼 有工作", "📝 常规") as "特征"
FROM "10-Daily"
WHERE date >= date(today) - dur(30 days)
  AND (contains(file.content, "工作") 
    OR contains(file.content, "项目")
    OR contains(file.content, "<!-- area:work -->"))
GROUP BY dateformat(date, "kkkk-'W'WW") as week
SORT week DESC
LIMIT 4
```

### 🏃 健康领域
```dataview
TABLE WITHOUT ID
  week as "📅 周",
  length(rows) as "📝 记录数",
  choice(length(filter(rows, (r) => r.workout_duration AND typeof(r.workout_duration) = "number" AND r.workout_duration > 0)) > 0, 
    sum(filter(rows.workout_duration, (x) => typeof(x) = "number" AND x > 0)), 
    "暂无") as "⏱️ 运动时长(分钟)",
  choice(length(filter(rows, (r) => r.sleep_hours AND typeof(r.sleep_hours) = "number" AND r.sleep_hours > 0)) > 0,
    round(avg(filter(rows.sleep_hours, (x) => typeof(x) = "number" AND x > 0)), 1),
    "暂无") as "😴 平均睡眠(小时)"
FROM "10-Daily"
WHERE date >= date(today) - dur(30 days)
  AND (contains(file.content, "<!-- area:health -->") OR contains(file.content, "健身"))
GROUP BY dateformat(date, "kkkk-'W'WW") as week
SORT week DESC
LIMIT 4
```

### 📚 学习领域
```dataview
LIST
FROM "30-Knowledge/Learning"
WHERE date >= date(today) - dur(30 days)
SORT date DESC
LIMIT 10
```

### 🏠 个人生活
```dataview
TABLE WITHOUT ID
  file.link as "📅 日期",
  choice(contains(file.content, "家庭") OR contains(file.content, "朋友"), "👥 社交", "🎯 个人") as "🏷️ 类型"
FROM "10-Daily"
WHERE date >= date(today) - dur(30 days)
  AND (contains(file.content, "<!-- area:personal -->") OR contains(file.content, "个人时间"))
SORT date DESC
LIMIT 8
```

## 🎯 平衡性指标

### 最近7天各领域活跃度
```dataview
TABLE WITHOUT ID
  "💼 工作" as "🏷️ 领域",
  length(filter(rows, (r) => contains(r.file.content, "<!-- area:work -->") OR contains(r.file.content, "工作"))) as "📊 活动天数"
FROM "10-Daily"
WHERE date >= date(today) - dur(7 days)
GROUP BY true
LIMIT 1
```

```dataview
TABLE WITHOUT ID
  "🏃 健康" as "🏷️ 领域", 
  length(filter(rows, (r) => contains(r.file.content, "<!-- area:health -->") OR (r.workout_duration AND typeof(r.workout_duration) = "number" AND r.workout_duration > 0))) as "📊 活动天数"
FROM "10-Daily"
WHERE date >= date(today) - dur(7 days)
GROUP BY true
LIMIT 1
```

```dataview
TABLE WITHOUT ID
  "🏠 个人" as "🏷️ 领域",
  length(filter(rows, (r) => contains(r.file.content, "<!-- area:personal -->") OR contains(r.file.content, "个人时间"))) as "📊 活动天数"
FROM "10-Daily"
WHERE date >= date(today) - dur(7 days)
GROUP BY true
LIMIT 1
```

## 💡 快速洞察

### 🔥 连续记录
```dataview
TABLE WITHOUT ID
  max(date) - min(date) + dur(1 day) as "📅 连续天数",
  length(rows) as "📝 总记录数"
FROM "10-Daily"
WHERE date >= date(today) - dur(30 days)
GROUP BY true
```

### ⚠️ 需要关注的领域
- [ ] 检查本周是否有运动记录
- [ ] 回顾学习笔记是否更新
- [ ] 确认个人时间是否充足
- [ ] 评估工作与生活平衡

## 🔄 定期回顾

### 使用 Claude 分析
```bash
# 运行生活平衡分析
claude /area-review

# 聚焦健康领域分析
claude /area-review --focus health

# 查看长期趋势
claude /area-review --period 90d
```

### 手动回顾问题
1. **工作**: 是否有过度工作的趋势？
2. **健康**: 运动和睡眠是否规律？
3. **学习**: 知识获取是否持续？
4. **个人**: 是否有足够的放松时间？

---
*更新时间: `= dateformat(this.file.mtime, "yyyy-MM-dd HH:mm")`*