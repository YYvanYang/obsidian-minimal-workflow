---
allowed-tools:
  - Read
  - Glob
  - Grep
  - Bash
  - Edit
  - Write
  - LS
description: Perform comprehensive vault maintenance and cleanup to improve organization and reduce clutter
---

# Vault Cleanup

Perform comprehensive vault maintenance and cleanup

## Usage with $ARGUMENTS

```bash
# Full vault cleanup analysis
claude /vault-cleanup

# Dry run mode - only show recommendations
claude /vault-cleanup --dry-run

# Focus on specific area
claude /vault-cleanup --area projects

# Auto-fix simple issues
claude /vault-cleanup --auto-fix
```

## Parameters

- `--dry-run`: Show recommendations without making changes
- `--area`: Focus on specific area - `projects`, `knowledge`, `daily`, or `all` (default)
- `--auto-fix`: Automatically fix simple issues like broken links

## Implementation

### Step 1: Link Analysis
Identify broken links and suggest fixes

### Step 2: Orphan Detection
Find orphaned files without any connections

### Step 3: Duplicate Detection
Detect duplicate content across notes

### Step 4: Archive Candidates
Suggest files to archive in `40-Archive/` folder

### Step 5: Organization Optimization
Optimize folder organization and naming

### Step 6: Tag Cleanup
Clean up unused tags and standardize tag naming

### Step 7: Report Generation
Generate maintenance report with recommendations

## Output

- Broken links report with fix suggestions
- Orphaned files list
- Duplicate content analysis
- Archive candidates with reasons
- Folder organization recommendations
- Tag standardization suggestions
- Vault health score
- Action priority list

## Notes

Focus on improving vault health, organization, and reducing clutter while preserving important content. The cleanup process is designed to be safe and reversible, with all major changes requiring user confirmation.