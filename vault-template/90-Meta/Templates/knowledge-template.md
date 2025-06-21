<%*
let category, title, fileName;

try {
    // 选择分类
    category = await tp.system.suggester(
        ["Learning (学习笔记)", "Research (研究资料)", "Reference (参考文档)"],
        ["Learning", "Research", "Reference"]
    );
    
    if (!category) {
        await tp.file.delete();
        return;
    }
    
    // 获取标题
    title = await tp.system.prompt("知识标题");
    
    if (!title || title.trim() === "") {
        await tp.file.delete();
        return;
    }
    
    // 清理标题（移除特殊字符）
    const cleanTitle = title.trim().replace(/[\/\\:*?"<>|]/g, '-');
    
    // 创建文件名
    fileName = `${category.slice(0,3)}-${cleanTitle}`;
    
    // 检查文件是否已存在
    const targetPath = `30-Knowledge/${category}/${fileName}`;
    const existingFile = tp.file.find_tfile(targetPath);
    
    if (existingFile) {
        const action = await tp.system.suggester(
            ["覆盖现有文件", "添加数字后缀", "取消创建"],
            ["overwrite", "suffix", "cancel"]
        );
        
        if (action === "cancel") {
            await tp.file.delete();
            return;
        } else if (action === "suffix") {
            let counter = 1;
            while (tp.file.find_tfile(`${targetPath}-${counter}`)) {
                counter++;
            }
            fileName = `${fileName}-${counter}`;
        }
    }
    
    // 重命名和移动文件
    await tp.file.rename(fileName);
    await tp.file.move(`30-Knowledge/${category}/${fileName}`);
    
} catch (error) {
    // 错误处理
    console.error("模板错误:", error);
    new Notice("创建知识笔记时出错，请重试");
    await tp.file.delete();
    return;
}
-%>
---
title: <% title %>
date: <% tp.date.now("YYYY-MM-DD") %>
category: <% category %>
tags: [knowledge, <% category.toLowerCase() %>]
source: 
status: draft
---

# <% title %>

## 🎯 核心要点
- 
- 
- 

## 🔧 实际应用
**适用场景**: 
**使用方法**: 
**注意事项**: 

## 🔗 相关连接
- 相关笔记: [[]]
- 相关项目: [[]]
- 原始资料: 

## 📝 后续行动
- [ ] 完善核心概念
- [ ] 添加实际案例
- [ ] 创建相关链接

## 💭 个人思考


## 📚 参考资料
<!-- 在此添加引用的书籍、文章、视频等资源 -->

<% tp.file.cursor() %>