<%*
const fileName = tp.date.now("YYYY-MM-DD");
await tp.file.rename(fileName);
await tp.file.move(`10-Daily/${fileName}`);
-%>

---
date: <% tp.date.now("YYYY-MM-DD") %>
day: <% tp.date.now("dddd") %>
week: [[<% tp.date.now("YYYY-[W]ww") %>]]
tags: [daily]
---

# <% tp.date.now("MM-DD ddd") %>

## 🎯 今日重点
- [ ] 
- [ ] 
- [ ] 

## 💼 工作记录
### 完成
- 

### 问题
- 

### 学习
- 

## 🏠 个人时间
- 

## 📋 明日待办
- [ ] 
- [ ] 

## 💭 一句话总结


<% tp.file.cursor() %>