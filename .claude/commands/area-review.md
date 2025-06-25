---
allowed-tools:
  - Read
  - Glob
  - Grep
  - Bash
  - Edit
  - Write
description: Analyze life area balance and provide optimization suggestions across work, health, learning, and personal domains
---

# Area Review

分析生活各领域的平衡性并提供优化建议

## Usage with $ARGUMENTS

```bash
# 分析最近30天的生活平衡
claude /area-review

# 分析最近7天，聚焦健康领域
claude /area-review --period 7d --focus health

# 季度生活回顾
claude /area-review --period 90d
```

## Parameters

- `--period`: Analysis timeframe - `30d` (default), `7d`, or `90d`
- `--focus`: Focus on specific area - `work`, `personal`, `health`, or `learning`

## Implementation

### Step 1: Data Collection
扫描指定时期内的所有日常笔记 (`10-Daily/`)

### Step 2: Area Classification
识别并分类不同生活领域的活动：
- **工作领域**: 项目进展、会议、任务完成情况
- **健康领域**: 运动记录、睡眠质量、精力水平
- **学习领域**: 知识获取、技能提升、阅读记录
- **个人领域**: 家庭活动、兴趣爱好、社交互动

### Step 3: Balance Analysis
分析各领域的时间和精力分配：
- 计算每个领域的活动频率
- 评估各领域的满意度（基于情绪词汇）
- 识别被忽视的领域

### Step 4: Pattern Detection
检测生活平衡模式：
- 工作与生活的平衡度
- 持续高压或低活跃期
- 领域间的相互影响

### Step 5: Recommendations
生成个性化建议：
- 需要加强关注的领域
- 可能的时间重新分配方案
- 具体的行动建议

### Step 6: Visualization
创建可视化平衡报告

## Output

- 生活领域平衡轮图
- 各领域活动统计和趋势
- 平衡性评分（1-10）
- 具体改进建议清单
- 下阶段重点关注领域

## Notes

- 使用自然语言处理识别活动类别
- 基于关键词和上下文判断领域归属
- 考虑用户的个人目标和价值观
- 提供可执行的改进建议而非空泛建议