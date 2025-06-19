<%*
const category = await tp.system.suggester(
    ["Learning", "Research", "Reference"],
    ["Learning", "Research", "Reference"]
);
const title = await tp.system.prompt("知识标题");
const fileName = `${category.slice(0,3)}-${title}`;
await tp.file.rename(fileName);
await tp.file.move(`30-Knowledge/${category}/${fileName}`);
-%>

---
title: <% title %>
date: <% tp.date.now("YYYY-MM-DD") %>
category: <% category %>
tags: [knowledge, <% category.toLowerCase() %>]
source: 
---

# <% title %>

## 🎯 核心要点
- 
- 
- 

## 🔧 实际应用
**适用场景**: 
**使用方法**: 

## 🔗 相关连接
- 相关笔记: [[]]
- 相关项目: [[]]
- 原始资料: 

## 📝 后续行动
- [ ] 
- [ ] 

## 💭 个人思考


<% tp.file.cursor() %>