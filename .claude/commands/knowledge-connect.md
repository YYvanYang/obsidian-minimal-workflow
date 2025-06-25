---
allowed-tools:
  - Read
  - Glob
  - Grep
  - Bash
  - Edit
  - Write
description: Optimize knowledge connections and improve discoverability across the vault
---

# Knowledge Connect

Optimize knowledge connections in the vault

## Usage with $ARGUMENTS

```bash
# Full vault knowledge connection analysis
claude /knowledge-connect

# Focus on specific knowledge area
claude /knowledge-connect --area learning

# Generate detailed connection map
claude /knowledge-connect --mode detailed
```

## Parameters

- `--area`: Focus on specific area - `learning`, `research`, `reference`, or `all` (default)
- `--mode`: Analysis mode - `quick` or `detailed` (default)

## Implementation

### Step 1: Note Analysis
Analyze notes in `30-Knowledge/` for linking opportunities

### Step 2: Orphan Detection
Identify orphaned notes without backlinks

### Step 3: Connection Discovery
Suggest connections between related concepts

### Step 4: Tag Recommendations
Recommend tags for better categorization

### Step 5: Gap Analysis
Find knowledge gaps or duplicated content

### Step 6: Daily Integration
Create connection suggestions for daily notes

### Step 7: Health Report
Generate knowledge graph health report

## Output

- Orphaned notes list with suggested connections
- Related concept pairs for linking
- Tag recommendations and taxonomy
- Knowledge gap identification
- Duplicate content warnings
- Knowledge graph visualization
- Connection improvement metrics

## Notes

Focus on improving discoverability and knowledge flow across the entire vault. The analysis considers semantic similarity, topic clustering, and existing link patterns.