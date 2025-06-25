---
allowed-tools:
  - Read
  - Glob
  - Grep
  - Bash
  - Edit
  - Write
description: Analyze learning progress and provide educational insights with personalized recommendations
---

# Learning Progress

Analyze learning progress and provide educational insights

## Usage with $ARGUMENTS

```bash
# General learning progress analysis
claude /learning-progress

# Focus on specific subject
claude /learning-progress --subject "Machine Learning"

# Weekly learning review
claude /learning-progress --period 7d

# Quarterly learning assessment
claude /learning-progress --period 90d --subject "Python"
```

## Parameters

- `--subject`: Focus on specific learning area (optional)
- `--period`: Analysis timeframe - `30d` (default), `7d`, or `90d`

## Implementation

### Step 1: Note Scanning
- Scan learning notes in `30-Knowledge/Learning/` folder
- Analyze daily notes for learning-related activities

### Step 2: Metric Extraction
Extract learning metrics:
- Note creation frequency and topics
- Knowledge connections and cross-references
- Learning sources and methods used
- Completed learning tasks and projects

### Step 3: Effectiveness Evaluation
Evaluate learning effectiveness:
- Knowledge retention patterns
- Topic mastery progression
- Learning velocity by subject
- Active recall and spaced repetition usage

### Step 4: Pattern Identification
Identify learning patterns:
- Peak learning times and conditions
- Most effective learning methods
- Knowledge gaps and missing connections
- Abandoned or incomplete learning paths

### Step 5: Recommendations
Generate improvement recommendations:
- Optimal learning schedule suggestions
- Subject-specific study strategies
- Knowledge consolidation opportunities
- Next learning priorities and goals

### Step 6: Visualization
Create learning dashboard with progress visualization

## Output

- Learning velocity charts
- Knowledge map analysis
- Mastery assessments
- Personalized study plan recommendations
- Learning streak tracking
- Subject proficiency scores
- Time investment analysis

## Notes

The analysis focuses on continuous improvement through data-driven insights. It considers both quantitative metrics (note count, study time) and qualitative factors (connection quality, concept mastery).