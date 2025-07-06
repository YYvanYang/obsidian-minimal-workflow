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
- 

## 📋 明日待办
- [ ] 

## 🔄 例行任务
<!-- 根据需要添加你的例行任务，例如：
- [ ] 晨间冥想 🔁 every day
- [ ] 健身打卡 🔁 every weekday
- [ ] 周报准备 🔁 every Friday
--> 

## 💭 一句话总结


<% tp.file.cursor() %>