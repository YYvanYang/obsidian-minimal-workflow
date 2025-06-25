---
allowed-tools:
  - Read
  - Glob
  - Grep
  - Bash
  - Edit
  - Write
description: Analyze and update project status with progress tracking and executive summaries
---

# Project Summary

Analyze and update project status

## Usage with $ARGUMENTS

```bash
# Analyze specific project
claude /project-summary "My Project Name"

# Analyze all active projects
claude /project-summary all

# Generate detailed project report
claude /project-summary "My Project Name" --detail high
```

## Parameters

- **$ARGUMENTS**: Project name or "all" for all projects
- `--detail`: Report detail level - `low`, `medium` (default), or `high`

## Implementation

### Step 1: Project Discovery
Find project file(s) in `20-Projects/` folder

### Step 2: Activity Scanning
Scan related mentions in daily notes (`10-Daily/`)

### Step 3: Progress Extraction
Extract recent progress, decisions, and blockers

### Step 4: Progress Calculation
Calculate progress percentage based on completed tasks

### Step 5: Risk Assessment
Identify risks and next actions

### Step 6: Status Update
Update project status and progress bar

### Step 7: Summary Generation
Generate executive summary

## Output

- Project status overview
- Progress percentage and visualization
- Recent accomplishments list
- Current blockers and risks
- Next actions and priorities
- Timeline assessment
- Resource requirements
- Executive summary

## Notes

Provide both high-level overview and detailed action items. The analysis considers project deadlines, dependencies, and resource allocation for comprehensive status reporting.