<%*
// 缓存日期变量以提高性能
const dateVars = {
    fileName: tp.date.now("YYYY-MM-DD"),
    dayName: tp.date.now("dddd"),
    weekName: tp.date.now("GGGG-[W]WW"),
    shortDate: tp.date.now("MM-DD ddd")
};

await tp.file.rename(dateVars.fileName);
await tp.file.move(`10-Daily/${dateVars.fileName}`);
-%>
---
date: <% dateVars.fileName %>
day: <% dateVars.dayName %>
week: [[<% dateVars.weekName %>]]
tags: [daily]
workout_completed: false
workout_type: ""
workout_duration: 0
workout_intensity: ""
sleep_hours: 8
energy_level: 3
---

# <% dateVars.shortDate %>

## 🎯 今日重点
- [ ] 
- [ ] 
- [ ] 

## 💼 工作记录
<!-- area:work -->
### 完成
- 

### 问题
- 

### 学习
- 

## 🏠 个人时间
<!-- area:personal -->

<details>
<summary>🏋️ 健身与健康记录</summary>

### 今日运动
<!-- area:health -->
- [ ] **类型**：□跑步 □力量训练 □瑜伽 □游泳 □骑行 □其他：___
- **时长**：___分钟 | **强度**：□轻松 □中等 □高强度
- **地点**：□家里 □健身房 □户外 □其他：___

### 身体状态
- **精力水平**：😴😐😊😁🔥 (选择一个，1-5分)
- **睡眠质量**：___小时 | 质量评分：___/10
- **整体感受**：

### 健身目标进展
- [ ] 完成今日运动计划
- **本周运动**：第___次 / 目标___次
- **备注**：

</details>

### 其他个人活动
- 

## 📋 明日待办
- [ ] 
- [ ] 

## 💭 一句话总结


<% tp.file.cursor() %>