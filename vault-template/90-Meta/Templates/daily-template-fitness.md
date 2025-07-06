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
exercise: false
type: ""
duration: 0
intensity: ""
sleep: 8
energy: 3
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
**运动类型**（勾选一项）：
- [ ] 跑步
- [ ] 力量训练
- [ ] 瑜伽
- [ ] 游泳
- [ ] 骑行
- [ ] 其他：___

**运动详情**：
- **时长**：___分钟
- **强度**：
  - [ ] 轻松
  - [ ] 中等
  - [ ] 高强度
- **地点**：
  - [ ] 家里
  - [ ] 健身房
  - [ ] 户外
  - [ ] 其他：___

### 身体状态
**精力水平**（选择一项）：
- [ ] 😴 很疲惫 (1分)
- [ ] 😐 一般 (2分)
- [ ] 😊 不错 (3分)
- [ ] 😁 很好 (4分)
- [ ] 🔥 充满活力 (5分)

**睡眠情况**：
- **睡眠时长**：___小时
- **睡眠质量**（1-10分）：___

**整体感受**：

### 健身目标进展
- [ ] 完成今日运动计划
- **本周运动**：第___次 / 目标___次
- **备注**：

</details>

### 其他个人活动
- 

## 📋 明日待办
- [ ] 

## 🔄 例行任务
- [ ] 
- [ ] 

## 💭 一句话总结


<% tp.file.cursor() %>