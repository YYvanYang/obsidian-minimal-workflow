---
allowed-tools: [Read, Write, Edit, LS]
description: Create today's daily note with optional fitness tracking
---

# Daily Note Creation

Create today's daily note using the Obsidian minimal workflow system.

## Usage

`$ARGUMENTS`

## Parameters 
- Optional: `--template fitness` to use fitness tracking template

## Implementation
1. Choose template:
   - Default: `90-Meta/Templates/daily-template.md` (standard daily note)
   - Fitness: `90-Meta/Templates/daily-template-fitness.md` (includes fitness tracking)
2. Create file with today's date (YYYY-MM-DD.md) in `10-Daily/` folder
3. Auto-populate all date fields and template structure
4. Link to current week's summary
5. Set cursor position for immediate editing

## Template Features
- Standard: daily targets, work log, personal notes, tomorrow tasks, summary
- Fitness: all above + collapsible fitness tracking section with health metrics