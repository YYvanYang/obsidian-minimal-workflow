# 贡献指南

感谢您对 Obsidian Minimal Workflow 项目的关注！我们欢迎各种形式的贡献。

## 🤝 如何贡献

### 报告问题
1. 在 [Issues](https://github.com/YYvanYang/obsidian-minimal-workflow/issues) 页面搜索是否已有相似问题
2. 使用问题模板创建新 Issue
3. 提供详细的问题描述和复现步骤
4. 附上相关的错误信息和截图

### 提交功能建议
1. 在 [Discussions](https://github.com/YYvanYang/obsidian-minimal-workflow/discussions) 中提出想法
2. 描述功能的使用场景和价值
3. 参与讨论，完善提案

### 代码贡献
1. Fork 本仓库
2. 创建功能分支：`git checkout -b feature/your-feature-name`
3. 提交更改：`git commit -m 'Add: 新功能描述'`
4. 推送分支：`git push origin feature/your-feature-name`
5. 创建 Pull Request

## 📋 开发规范

### Git 提交信息格式
```
<type>: <subject>

<body>

<footer>
```

**Type 类型**：
- `Add`: 新增功能
- `Fix`: 修复问题
- `Update`: 更新功能
- `Remove`: 移除功能
- `Refactor`: 重构代码
- `Docs`: 文档更新
- `Style`: 代码格式调整
- `Test`: 测试相关
- `Chore`: 构建过程或辅助工具的变动

**示例**：
```
Add: 添加项目归档功能

- 实现项目状态检查
- 自动移动到归档文件夹
- 更新相关文档

Closes #123
```

### 代码风格
- Shell 脚本使用 Bash 编写
- 使用 2 空格缩进
- 添加必要的注释
- 错误处理要完善
- 考虑跨平台兼容性

### 文档规范
- 使用中文为主，技术术语可保留英文
- 保持简洁清晰的表达
- 提供充分的示例
- 及时更新相关文档

## 🧪 测试要求

### 功能测试
1. 在 macOS 和 Linux 上测试脚本
2. 测试 Obsidian 不同版本的兼容性
3. 验证模板在各种场景下的表现

### 提交前检查
- [ ] 代码符合项目规范
- [ ] 相关文档已更新
- [ ] 通过所有测试
- [ ] 没有引入新的问题

## 🎯 重点关注领域

当前项目特别需要以下方面的贡献：
- 跨平台兼容性改进
- 性能优化建议
- 新的实用模板
- Claude Code 命令扩展
- 多语言支持

## 📞 联系方式

- GitHub Issues: 技术问题和功能建议
- GitHub Discussions: 想法交流和讨论
- Email: [维护者邮箱]

## 📄 许可证

通过提交代码，您同意您的贡献将按照项目的 MIT 许可证进行授权。

---

再次感谢您的贡献！让我们一起打造更好的知识管理工具。