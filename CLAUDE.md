# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Obsidian Minimal Workflow** is a comprehensive personal knowledge management system template for Obsidian with integrated AI automation. It implements the P.A.R.A. methodology and provides a complete, production-ready vault structure with Claude Code integration for intelligent workflows.

**Key Purpose**: Transform individual productivity through structured knowledge management, automated workflows, and AI-enhanced insights.

## Coding Standards

### Templater Development
- Use `<%* %>` blocks for JavaScript code with control structures (if, for, etc.)
- Use `<% %>` tags only for simple expressions and variable output
- Always provide content when creating files with `tp.file.create_new()` to avoid template recursion
- Cache date variables in templates for performance
- Never add empty lines between `-%>` and `---` in YAML frontmatter

### File Naming Conventions
- Projects: `Project-Description.md`
- Learning: `Learning-Topic.md`
- Reference: `Reference-Content.md`
- Personal: `Personal-Type.md`
- Multi-file projects: `Project-Name-01-Description.md`

### Date Standards
- Use ISO 8601 week numbering throughout the system
- Bash scripts: `date +%Y-W%V`
- Templater: `GGGG-[W]WW` format
- Dataview: `kkkk-'W'WW` format

### Dataview Best Practices
- Always include LIMIT clauses in queries for performance
- Handle null values in date calculations with `choice()` function
- Check `length(rows) > 0` AND that aggregated values are not null
- Use `this.file.mtime` for file modification timestamps, not `date(now)`

## Common Commands

### Setup and Maintenance
```bash
# Initial setup
./scripts/setup.sh

# Health check
./scripts/health-check.sh

# Backup operations
./scripts/backup.sh full         # Complete backup
./scripts/backup.sh incremental  # Recent changes only

# Test commands
npm run lint      # Check code quality
npm run typecheck # Verify TypeScript types
```

### Claude Code Commands
```bash
# Daily workflow
claude /daily-note                    # Create daily note
claude /daily-note --template fitness # With fitness tracking

# Analysis
claude /weekly-report                 # Weekly summary
claude /project-summary "Project Name" # Project status
claude /fitness-analysis             # Health insights
claude /learning-progress            # Learning evaluation

# Personal development
claude /personal create --type review # Performance review
claude /personal analyze             # Career analysis
claude /personal extract --focus achievements # Extract achievements

# System maintenance
claude /vault-cleanup                # Optimize organization
claude /knowledge-connect            # Enhance linking
```

## Architecture Patterns

### Directory Structure
- `00-Dashboard/` → Navigation and overview interfaces
- `10-Daily/` → Time-based content (daily notes)
- `20-Projects/` → Actionable work with deadlines
- `30-Knowledge/` → Learning and reference materials
  - `Learning/` → Active learning notes
  - `Research/` → Deep research topics
  - `Reference/` → Established knowledge
  - `Personal/` → Career documents
- `40-Archive/` → Completed/inactive content
- `90-Meta/Templates/` → Templater templates

### Project Organization Modes
1. **Single File Mode (90%)**: Simple projects in one file
2. **Multi-File Mode (8%)**: Projects > 2000 words or 3+ modules
3. **Folder Mode (2%)**: Large projects with 8+ files

### Critical Configuration Files
- `.claude/settings.local.json` → Security permissions
- `.obsidian-workflow/config.json` → Project settings
- `90-Meta/Templates/` → Content generation templates

## Common Pitfalls and Solutions

### Templater Syntax Errors
**Problem**: "Unexpected token 'if'" error
**Solution**: Use `<%* if (condition) { -%>` instead of `<% if (condition) { %>`

### Template Recursion
**Problem**: Empty files trigger default template in infinite loop
**Solution**: Always provide content: `tp.file.create_new("# Title", "filename")`

### Path Nesting Issues
**Problem**: Creating nested `20-Projects/20-Projects/` directories
**Solution**: Use folder parameter: `tp.file.create_new(content, "name", false, "20-Projects")`

### Null Date Calculations
**Problem**: Dataview errors with "null + duration"
**Solution**: Check null values: `min(rows.date) != null AND max(rows.date) != null`

### Tasks Plugin Integration
**Task Syntax**: Use emoji-based metadata for dates and properties
- Due date: `📅 YYYY-MM-DD`
- Scheduled: `⏳ YYYY-MM-DD`
- Priority: `⏫` (high), `🔼` (medium), `🔽` (low)
- Recurring: `🔁 every day/week/month`

**Query Performance**: Always limit results in task queries
```tasks
not done
limit 50
```

## Cross-Platform Compatibility

Handle macOS and Linux differences:
```bash
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' "s/pattern/replacement/g" file
else
    sed -i "s/pattern/replacement/g" file
fi
```

## Testing and Validation

When making changes:
1. Run `./scripts/health-check.sh` for system integrity
2. Test templates with various date scenarios
3. Verify Claude Code commands work within permissions
4. Confirm cross-platform compatibility
5. Check ISO 8601 week numbering consistency

## Plugin Requirements

**Required**:
- Templater (v1.16.0+) - Core template system
- Dataview (v0.5.56+) - Dynamic content queries
- Obsidian Tasks (latest) - Advanced task management

**Recommended**:
- Calendar (v1.5.10+) - Enhanced navigation
- Periodic Notes (v0.0.17+) - Automated note creation