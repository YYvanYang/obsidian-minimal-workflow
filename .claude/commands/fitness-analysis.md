---
allowed-tools:
  - Read
  - Glob
  - Grep
  - Bash
  - Edit
  - Write
description: Analyze fitness data and provide comprehensive health insights with trends and recommendations
---

# Fitness Analysis

Analyze fitness data and provide comprehensive health insights

## Usage with $ARGUMENTS

```bash
# Default 30-day fitness analysis
claude /fitness-analysis

# Weekly fitness summary
claude /fitness-analysis --period 7d

# Detailed 90-day fitness report
claude /fitness-analysis --period 90d --type detailed
```

## Parameters

- `--period`: Analysis timeframe - `30d` (default), `7d`, or `90d`
- `--type`: Report depth - `summary` (default) or `detailed`

## Implementation

### Step 1: Data Collection
Scan daily notes in `10-Daily/` for fitness data

### Step 2: Metric Extraction
Extract workout metrics from front matter:
- exercise, type, duration
- intensity, sleep, energy

### Step 3: Statistical Analysis
Calculate fitness statistics:
- Weekly/monthly workout frequency
- Average workout duration by type
- Energy level correlations with exercise
- Sleep quality patterns

### Step 4: Trend Identification
Identify trends and insights:
- Most effective workout types for energy
- Consistency patterns and streaks
- Recovery and rest day analysis

### Step 5: Recommendations
Generate actionable recommendations:
- Optimal workout schedule suggestions
- Goal adjustments based on progress
- Areas for improvement

### Step 6: Visualization
Create visual data summary for dashboard

## Output

- Workout frequency charts
- Energy correlation analysis
- Goal progress tracking
- Personalized recommendations for sustainable fitness habits
- Recovery patterns and insights