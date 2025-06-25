---
allowed-tools: [Read, Write, Edit, Grep, Glob, LS, Task]
description: Manage and analyze personal career development documents
---

# Personal Career Document Management

Create, analyze, and organize personal career development documents including resumes, performance reviews, career plans, and goal tracking.

## Usage

`$ARGUMENTS`

## Parameters
- Required: action type
  - `create` - 创建新的个人文档
  - `analyze` - 分析职业发展轨迹
  - `extract` - 提取关键成就和技能
  - `prepare` - 准备面试或述职材料
- Optional: `--type resume|review|plan|goals` (for create action)
- Optional: `--period 1y` (default) or `3m`, `6m`, `2y` 
- Optional: `--focus skills|achievements|growth`

## Implementation

### Action: create
1. 根据类型选择合适的模板结构：
   - `resume`: 简历模板（教育、工作经历、技能、项目）
   - `review`: 绩效/述职报告（工作成果、挑战、成长、计划）
   - `plan`: 职业规划（短期目标、长期愿景、行动计划）
   - `goals`: 年度目标（SMART目标设定、季度分解）
2. 扫描现有项目和学习笔记，提取相关内容
3. 在 `30-Knowledge/Personal/` 创建文档
4. 自动填充可用信息，标记需要补充的部分

### Action: analyze
1. 扫描 Personal 文件夹中的历史文档
2. 从项目文件中提取完成的重要工作
3. 从学习笔记中识别技能提升
4. 分析职业发展轨迹：
   - 技能成长曲线
   - 责任范围变化
   - 关键转折点
5. 识别发展模式和未来机会

### Action: extract
1. 扫描指定时期的所有相关文档
2. 提取并分类：
   - **关键成就**: 量化的业务成果
   - **技能清单**: 技术栈、软技能、领域知识
   - **项目亮点**: 重要项目及个人贡献
   - **成长记录**: 学习历程、认证、培训
3. 生成 STAR 格式的成就描述
4. 创建技能矩阵（技能等级评估）

### Action: prepare
1. 根据目标（面试/述职/晋升）定制内容
2. 整合最相关的成就和经验
3. 生成针对性的自我介绍
4. 提供可能的问题和回答建议
5. 创建一页纸简历或述职提纲

## Output
- 创建的文档路径和初始内容
- 职业发展分析报告和可视化
- 整理后的成就清单和技能矩阵
- 定制化的面试/述职准备材料

## Examples
```bash
# 创建年度述职报告
claude /personal create --type review

# 分析过去一年的职业发展
claude /personal analyze --period 1y

# 提取关键成就用于更新简历
claude /personal extract --focus achievements

# 准备面试材料
claude /personal prepare
```

## Integration Notes
- 自动链接到相关项目文件
- 与学习进度分析联动
- 支持导出为 PDF/Word 格式
- 保护隐私敏感信息