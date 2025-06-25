---
allowed-tools:
  - Read
  - Glob
  - Grep
  - Bash
  - Edit
  - Write
description: Generate comprehensive weekly report with insights and actionable goals
---

# Weekly Report

Generate comprehensive weekly report by analyzing the Obsidian vault

## Usage with $ARGUMENTS

```bash
# Generate current week report
claude /weekly-report

# Generate report for specific week
claude /weekly-report --week 2024-W45

# Include detailed metrics
claude /weekly-report --detail high
```

## Parameters

- `--week`: Specific week to analyze (format: YYYY-Www), defaults to current week
- `--detail`: Report detail level - `low`, `medium` (default), or `high`

## Implementation

### Step 1: Daily Note Analysis
Scan all daily notes from this week (`10-Daily/` folder)

### Step 2: Achievement Extraction
Extract completed tasks and achievements

### Step 3: Learning Capture
Identify problems solved and lessons learned

### Step 4: Project Progress
Summarize project progress from `20-Projects/` folder

### Step 5: Goal Setting
Create actionable next week's goals

### Step 6: Template Application
Use weekly template from `90-Meta/Templates/weekly-template.md`

### Step 7: Report Storage
Save to `Weekly/` folder with proper naming (YYYY-Www)

## Output

- Week overview with key metrics
- Completed tasks and achievements
- Project progress summary
- Problems solved and lessons learned
- Time allocation analysis
- Next week's priorities and goals
- Personal and professional insights
- Areas for improvement

## Notes

Focus on insights and measurable outcomes. Include both personal and professional progress. The report should balance retrospective analysis with forward-looking planning.