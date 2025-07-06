---
tags: [dashboard, tasks]
---

# 📋 任务中心

## 🎯 今日焦点
```tasks
not done
(due today) OR (scheduled today)
description does not include #placeholder
limit 20
```

## 📅 本周任务
### 高优先级
```tasks
not done
priority is high
(due after yesterday) AND (due before in 7 days)
```

### 中优先级
```tasks
not done
priority is medium
(due after yesterday) AND (due before in 7 days)
```

### 低优先级
```tasks
not done
priority is low
(due after yesterday) AND (due before in 7 days)
```

## ⏰ 逾期任务
```tasks
not done
due before today
group by priority
```

## 🔄 循环任务
```tasks
not done
is recurring
group by recurrence
```

## 📊 任务统计
### 按项目分组
```tasks
not done
path includes 20-Projects
group by filename
hide recurrence rule
```

### 按标签分组
```tasks
not done
group by tags
limit 20
```

## 🏷️ 无日期任务
```tasks
not done
no due date
path includes 20-Projects
limit 30
```

## ✅ 最近完成
```tasks
done
done in the last 7 days
sort by done reverse
limit 20
```

---
*更新时间: `= dateformat(this.file.mtime, "yyyy-MM-dd HH:mm")`*