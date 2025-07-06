---
tags: [dashboard, tasks]
---

# 📋 任务中心

## 🚀 快速操作
- [[90-Meta/Templates/daily-template|📅 新建日记]]
- [[90-Meta/Templates/project-template|📁 项目模板]]
- [[00-Dashboard/Current-Projects|🎯 当前项目]]
- 使用 `claude /weekly-report` 生成周报告

## 🎯 今日焦点
```tasks
not done
(due today) OR (scheduled today)
path includes 20-Projects OR path includes 10-Daily
limit 8
```

## 📅 本周任务
### 按优先级排序
```tasks
not done
due this week
group by priority
limit 25
```

### 明日任务 📆
```tasks
not done
due tomorrow
sort by priority reverse
limit 5
```

## ⏰ 逾期任务
```tasks
not done
due before today
group by priority
limit 15
```

## 🔄 循环任务
```tasks
not done
is recurring
group by recurrence
limit 10
```

## 📊 任务统计
### 按项目分组
```tasks
not done
path includes 20-Projects
group by filename
hide recurrence rule
limit 20
```

### 按标签分组
```tasks
not done
group by tags
limit 10
```

## 🏷️ 无日期任务
```tasks
not done
no due date
no scheduled date
path includes 20-Projects
limit 15
```

## ✅ 最近完成
```tasks
done
done in the last 7 days
sort by done reverse
limit 20
```

## 🔥 紧急且重要
```tasks
not done
(tags include #urgent) OR (priority is high)
(due today) OR (due before tomorrow)
limit 5
```

## ⚡ 快速任务（<15分钟）
```tasks
not done
tags include #quick
(due today) OR (scheduled today)
limit 10
```

## 📊 今日统计
- 待完成：`$= dv.pages("20-Projects" or "10-Daily").file.tasks.where(t => !t.completed && t.due && t.due.toFormat("yyyy-MM-dd") == dv.date("today").toFormat("yyyy-MM-dd")).length`
- 已完成：`$= dv.pages("20-Projects" or "10-Daily").file.tasks.where(t => t.completed && t.completion && t.completion.toFormat("yyyy-MM-dd") == dv.date("today").toFormat("yyyy-MM-dd")).length`
- 完成率：`$= "" + Math.round((dv.pages("20-Projects" or "10-Daily").file.tasks.where(t => t.completed && t.completion && t.completion.toFormat("yyyy-MM-dd") == dv.date("today").toFormat("yyyy-MM-dd")).length / (dv.pages("20-Projects" or "10-Daily").file.tasks.where(t => t.due && t.due.toFormat("yyyy-MM-dd") == dv.date("today").toFormat("yyyy-MM-dd")).length || 1)) * 100) + "%"`

---
*更新时间: `= dateformat(this.file.mtime, "yyyy-MM-dd HH:mm")`*