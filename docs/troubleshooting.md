# 🔧 故障排除指南

## 常见问题解决方案

### 📝 模板相关问题

#### Q: 模板无法自动应用到新文件
**现象**: 在指定文件夹创建新文件时，模板没有自动填充内容

**解决方案**:
1. **检查Templater配置**
   - 打开 Settings → Community plugins → Templater
   - 确认 "Template folder location" 设置为 `90-Meta/Templates`
   - 确认开启了 "Trigger Templater on new file creation"

2. **检查文件夹触发器**
   ```javascript
   // 在Templater设置的"Folder Templates"中添加：
   10-Daily → daily-template
   20-Projects → project-template
   30-Knowledge/Learning → knowledge-template
   30-Knowledge/Research → knowledge-template
   30-Knowledge/Reference → knowledge-template
   Weekly → weekly-template
   ```

3. **重启Obsidian**
   - 完全关闭Obsidian
   - 重新打开并测试

#### Q: 模板中的日期和变量没有正确替换
**现象**: 看到 `<% tp.date.now() %>` 或 `<% tp.file.cursor() %>` 等语法原样输出而不是实际内容

**解决方案**:
1. **确认Templater插件配置正确**（最常见原因）
   - 打开 Settings → Community plugins → Templater
   - 确认以下设置已开启：
     - ✅ **Trigger Templater on new file creation**（必须开启）
     - ✅ **Enable Folder Templates**（必须开启）
   - 检查 **Template folder location** 是否设置为 `90-Meta/Templates`

2. **检查文件创建方式**
   - ❌ 错误：直接复制粘贴模板内容到新文件
   - ❌ 错误：使用 Obsidian 核心的 Templates 插件
   - ✅ 正确：在配置了 Folder Templates 的文件夹中创建新文件
   - ✅ 正确：使用 `Templater: Create new note from template` 命令

3. **手动触发模板处理**
   - 如果文件已创建但显示原始语法：
   - `Cmd+P` (Mac) 或 `Ctrl+P` (Windows/Linux)
   - 输入并选择 "Templater: Replace templates in the active file"
   - 模板语法会被立即处理

4. **验证 Folder Templates 映射**
   - 在 Templater 设置的 **Folder Templates** 部分，确保有以下映射：
     ```
     10-Daily → daily-template
     20-Projects → project-template
     30-Knowledge/Learning → knowledge-template
     30-Knowledge/Research → knowledge-template
     30-Knowledge/Reference → knowledge-template
     Weekly → weekly-template
     ```

5. **重启 Obsidian**
   - 有时配置更改需要重启才能生效
   - 完全关闭 Obsidian，然后重新打开

#### Q: 文件无法移动到指定文件夹
**现象**: 新建的文件没有自动移动到目标文件夹

**解决方案**:
1. 确认目标文件夹已存在
2. 检查文件夹名称大小写是否匹配
3. 查看Templater控制台错误: Developer Tools → Console

### 📊 Dataview相关问题

#### Q: Dataview查询不显示任何内容
**现象**: 查询代码块显示为空或显示"No results"

**解决方案**:
1. **检查插件状态**
   - 确认Dataview插件已安装并启用
   - 检查插件是否需要更新

2. **验证文件的front matter**
   ```markdown
   ---
   date: 2025-06-20
   tags: [daily]
   status: active
   ---
   ```

3. **简化查询测试**
   ```javascript
   // 测试基础查询
   LIST
   FROM ""
   LIMIT 5
   ```

4. **检查文件路径**
   - 确认文件在正确的文件夹中
   - 检查文件夹名称是否匹配查询中的路径

#### Q: Dataview查询运行缓慢
**现象**: 查询需要很长时间才能显示结果

**解决方案**:
1. **优化查询范围**
   ```javascript
   // ✅ 好的查询 - 限制范围
   FROM "20-Projects"
   WHERE status = "active"
   
   // ❌ 避免的查询 - 全库扫描
   FROM ""
   WHERE contains(file.content, "某个词")
   ```

2. **使用LIMIT限制结果数量**
   ```javascript
   LIST
   FROM "10-Daily"
   LIMIT 10
   ```

3. **添加WHERE条件过滤**
   ```javascript
   TABLE status, priority
   FROM "20-Projects"
   WHERE date >= date(today) - dur(30 days)
   ```

### 🤖 Claude Code集成问题

#### Q: Claude命令无法找到或执行
**现象**: 运行 `claude /daily-note` 时提示命令不存在

**解决方案**:
1. **检查Claude Code安装**
   ```bash
   claude --version
   ```

2. **验证命令文件存在**
   ```bash
   ls .claude/commands/
   # 应该看到: daily-note.md, weekly-report.md 等文件
   ```

3. **检查文件权限**
   ```bash
   chmod 644 .claude/commands/*.md
   ```

4. **重新初始化Claude Code**
   ```bash
   cd 项目目录
   claude init
   ```

#### Q: Claude命令执行但没有预期效果
**现象**: 命令运行了但没有创建或修改文件

**解决方案**:
1. 检查命令文件内容是否正确
2. 确认当前工作目录是vault根目录
3. 查看Claude的详细输出和错误信息

### 📱 同步相关问题

#### Q: 文件在不同设备间没有同步
**现象**: 在一个设备上的更改没有出现在另一个设备上

**解决方案**:
1. **Obsidian Sync用户**
   - 检查网络连接
   - 查看同步状态指示器
   - 手动触发同步: Settings → Sync

2. **云存储同步用户**
   - 确认云存储应用正在运行
   - 检查是否有冲突文件
   - 避免同时在多设备编辑同一文件

3. **检查文件大小**
   - 某些同步服务对文件大小有限制
   - 考虑压缩大型附件

#### Q: 出现文件冲突
**现象**: 看到类似 "file.md.conflict-xxx" 的文件

**解决方案**:
1. 比较冲突文件内容
2. 手动合并重要更改
3. 删除冲突文件
4. 建立编辑时间规则避免冲突

### 🔧 性能相关问题

#### Q: Obsidian启动缓慢或卡顿
**现象**: 打开vault需要很长时间，或者操作响应慢

**解决方案**:
1. **减少插件数量**
   - 禁用不必要的插件
   - 一次只启用一个新插件测试

2. **优化文件结构**
   - 将大量旧文件移动到Archive文件夹
   - 删除不需要的附件文件
   - 避免过深的文件夹嵌套

3. **清理Dataview缓存**
   - 重启Obsidian
   - 禁用后重新启用Dataview插件

### 📚 内容组织问题

#### Q: 找不到之前创建的笔记
**现象**: 记得创建了某个笔记，但找不到了

**解决方案**:
1. **使用全局搜索**
   - `Cmd+Shift+F` 搜索关键词
   - 尝试搜索日期或标签

2. **检查常见位置**
   - 查看 `00-Dashboard/Quick-Notes.md`
   - 检查 `40-Archive` 文件夹
   - 查看最近修改的文件

3. **使用未链接提及**
   - 右侧面板 → Backlinks → Unlinked mentions

#### Q: 链接断裂或无法点击
**现象**: 双链显示但点击没有反应，或显示为红色

**解决方案**:
1. **检查文件名**
   - 确认目标文件确实存在
   - 检查文件名拼写和大小写

2. **更新链接格式**
   ```markdown
   # 旧格式（可能有问题）
   [[文件名.md]]
   
   # 推荐格式
   [[文件名]]
   [[文件夹/文件名]]
   ```

3. **重新构建链接**
   - 删除旧链接
   - 重新输入 `[[` 让Obsidian自动补全

## 🚨 紧急情况处理

### 数据丢失或损坏
1. **立即停止操作**
2. **检查备份**
   - Obsidian自动备份 (.obsidian/backup)
   - 云存储版本历史
   - 手动备份文件
3. **联系支持**
   - Obsidian官方支持
   - 云存储服务支持

### 插件冲突导致崩溃
1. **安全模式启动**
   - 禁用所有第三方插件
   - 逐个启用插件找出问题源
2. **重置插件配置**
   - 删除 `.obsidian/plugins` 文件夹
   - 重新安装必需插件

## 📞 获取更多帮助

### 官方资源
- [Obsidian帮助文档](https://help.obsidian.md/)
- [Obsidian论坛](https://forum.obsidian.md/)
- [Claude支持](https://support.anthropic.com/)

### 社区资源
- Obsidian Discord服务器
- Reddit r/ObsidianMD
- 本项目GitHub Issues

### 日志收集
如果问题持续存在，收集以下信息有助于诊断：
1. Obsidian版本号
2. 操作系统版本
3. 插件列表和版本
4. 错误信息截图
5. 问题复现步骤

记住：**大多数问题都有解决方案，保持耐心并逐步排查**。