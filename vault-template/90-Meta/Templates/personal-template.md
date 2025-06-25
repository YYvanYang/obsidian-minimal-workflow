<%*
// Simplified Personal Document Template
// Get document title
const title = await tp.system.prompt("请输入文档标题");
if (!title || title.trim() === "") {
    // User cancelled or entered empty title
    await tp.file.delete();
    return;
}

// Set filename with Personal prefix
const fileName = `Personal-${title.trim()}`;
await tp.file.rename(fileName);

// Date variables
const dateVars = {
    date: tp.date.now("YYYY-MM-DD"),
    year: tp.date.now("YYYY"),
    month: tp.date.now("MM"),
    monthName: tp.date.now("MMMM"),
    quarter: `Q${Math.ceil(parseInt(tp.date.now("MM")) / 3)}`
};
-%>
---
date: <% dateVars.date %>
type: personal
tags: [personal]
---

# <% title %>

## 概述
<% tp.file.cursor() %>

## 主要内容


## 相关资源
- 

## 备注


---
*创建于: <% dateVars.date %>*
*最后更新: `= dateformat(this.file.mtime, "yyyy-MM-dd HH:mm")`*

<!--
💡 **章节建议**（根据需要选用）：

### 📋 通用章节
- 背景说明
- 目标设定
- 具体计划
- 进度跟踪
- 总结反思

### 🎯 职业发展
- 当前状态
- 发展目标
- 技能清单
- 行动计划
- 里程碑

### 📝 个人记录
- 重要事件
- 心得体会
- 经验教训
- 未来展望

### 💼 项目文档
- 项目背景
- 关键信息
- 重要决策
- 参考资料

### 🏆 成就总结
- 主要成果
- 数据支撑
- 经验分享
- 改进方向

提示：删除此注释块，根据实际需要组织内容
-->