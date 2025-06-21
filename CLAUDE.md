# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Obsidian Minimal Workflow** is a comprehensive personal knowledge management system template for Obsidian with integrated AI automation. It implements the P.A.R.A. methodology and provides a complete, production-ready vault structure with Claude Code integration for intelligent workflows.

**Key Purpose**: Transform individual productivity through structured knowledge management, automated workflows, and AI-enhanced insights.

## Common Commands

### Setup and Installation
```bash
# Primary setup command - interactive vault creation
./scripts/setup.sh

# Manual permissions setup if needed
chmod +x scripts/*.sh
```

### Maintenance Commands
```bash
# Comprehensive system health check
./scripts/health-check.sh

# Backup operations
./scripts/backup.sh full         # Complete backup
./scripts/backup.sh incremental  # Recent changes only

# Environment customization
BACKUP_DIR=~/Backups RETENTION_DAYS=60 ./scripts/backup.sh
```

### Claude Code AI Commands
```bash
# Daily workflow automation
claude /daily-note                    # Standard daily note
claude /daily-note --template fitness # Fitness tracking variant

# Analysis and insights
claude /weekly-report                 # Auto-generate weekly summary
claude /project-summary "Project Name" # Project status analysis
claude /fitness-analysis             # Health data insights
claude /learning-progress            # Study progress evaluation
claude /area-review                  # Life balance analysis across all areas
claude /area-review --period 7d --focus health # Focused area analysis

# System maintenance
claude /vault-cleanup                # Optimize file organization
claude /knowledge-connect            # Enhance knowledge linking
```

## Architecture Overview

### Core Structure Pattern
The system follows a **template-driven architecture** with three main layers:

1. **Content Layer**: Structured folders following P.A.R.A. methodology
   - `00-Dashboard/` → Navigation and overview interfaces
   - `10-Daily/` → Time-based content (daily notes)
   - `20-Projects/` → Actionable work with deadlines
   - `30-Knowledge/` → Learning, research, and reference materials
   - `40-Archive/` → Completed or inactive content

2. **System Layer**: Automation and configuration
   - `90-Meta/Templates/` → Templater-based content generation
   - `.claude/` → AI command definitions and permissions
   - `.obsidian-workflow/` → Project-specific configuration

3. **Maintenance Layer**: Scripts and tooling
   - `scripts/` → Automation and health monitoring
   - `examples/` → Sample content and demonstrations

### Key Architectural Principles

**Template-First Design**: All content generation flows through Templater templates with JavaScript logic for:
- Dynamic date handling with ISO 8601 week numbering (`%V`, `GGGG-[W]WW`, `kkkk-'W'WW`)
- Automatic file naming and organization
- Cross-platform compatibility (macOS/Linux)

**AI-Enhanced Workflows**: Claude Code commands provide:
- Intelligent content analysis and generation
- Progress tracking across projects and learning
- System optimization recommendations
- Health monitoring and maintenance automation

**Progressive Disclosure**: System supports gradual adoption:
- Week 1: Basic daily notes only
- Week 2-3: Add project management
- Week 4: Integrate knowledge management
- Month 2: Full AI automation

## Critical Configuration Files

### `.claude/settings.local.json`
Defines Claude Code permissions and security boundaries:
- Whitelisted bash commands for safe automation
- Allowed web domains for research
- File system access restrictions

### `.obsidian-workflow/config.json`  
Project-specific settings:
- Vault name and language preferences
- Backup retention policies
- Version tracking

### Template System Structure
Located in `90-Meta/Templates/`:
- `daily-template.md` → Standard daily note structure
- `daily-template-fitness.md` → Enhanced with health tracking
- `weekly-template.md` → Weekly review and analysis
- `project-template.md` → Project management structure
- `knowledge-template.md` → Learning note organization

## Development Patterns

### Template Development
Templates use Templater with cached JavaScript variables for performance:
```javascript
const dateVars = {
    fileName: tp.date.now("YYYY-MM-DD"),
    weekName: tp.date.now("GGGG-[W]WW"),  // ISO 8601 format
    dayName: tp.date.now("dddd")
};
```

**Critical**: Templater `-%>` closing tag and YAML frontmatter formatting:
- **Never add empty lines between `-%>` and `---`**
- The `-%>` tag removes only ONE trailing newline
- Extra empty lines will cause YAML frontmatter parsing to fail

**❌ Wrong - Empty line prevents YAML parsing:**
```markdown
<%*
// JavaScript code
-%>

---
date: 2024-01-01
---
```

**✅ Correct - No empty line ensures proper YAML parsing:**
```markdown
<%*
// JavaScript code
-%>
---
date: 2024-01-01
---
```

### Dataview Query Optimization
All queries include LIMIT clauses for performance:
```javascript
FROM "20-Projects" 
WHERE status = "active"
SORT priority DESC
LIMIT 10  // Always limit results
```

### Dataview Null Value Handling
**Critical**: Always handle null values in date calculations to prevent "null + duration" errors:

**❌ Wrong - Can cause null calculation errors:**
```javascript
max(date) - min(date) + dur(1 day) as "连续天数"
```

**✅ Correct - Handle null values safely:**
```javascript
choice(length(rows) > 0 AND min(rows.date) != null AND max(rows.date) != null, 
  max(rows.date) - min(rows.date) + dur(1 day), 
  dur(0 days)) as "连续天数"
FROM "10-Daily"
WHERE date != null AND date >= date(today) - dur(30 days)
```

**Best practices for date calculations:**
- Always use `WHERE date != null` at the beginning of date-based WHERE clauses
- Use `choice()` function to provide fallback values for empty results
- Check both `length(rows) > 0` AND that aggregated values are not null before calculations
- When using `min(date)` or `max(date)`, explicitly check they're not null: `min(rows.date) != null`

### Timestamp Best Practices
**Critical**: Distinguish between "current time" vs "file modification time" in Dataview queries:

**❌ Wrong - Shows viewing time, not actual update time:**
```javascript
*最后更新: `= dateformat(date(now), "yyyy-MM-dd HH:mm")`*
```

**✅ Correct - Shows actual file modification time:**
```javascript
*最后更新: `= dateformat(this.file.mtime, "yyyy-MM-dd HH:mm")`*
```

**Use `date(now)` for:**
- Real-time data displays
- "Current status" indicators
- Navigation helpers (today's note links)

**Use `this.file.mtime` for:**
- "Last updated" timestamps
- "Last cleaned" timestamps  
- Any historical record of when content was actually modified

**Templates use `tp.date.now()` correctly** - this is for initial creation time, which should be current time.

### Checkbox Design Best Practices
**Critical**: Use proper Obsidian checkbox syntax for all interactive elements:

**❌ Wrong - Non-clickable symbols:**
```markdown
- [ ] **类型**：□跑步 □力量训练 □瑜伽
```

**✅ Correct - Clickable checkboxes:**
```markdown
**运动类型**（勾选一项）：
- [ ] 跑步
- [ ] 力量训练
- [ ] 瑜伽
```

**Best practices for checkboxes:**
- Always use `- [ ]` syntax for clickable checkboxes, never use `□` symbols
- For single-choice options, add "(选择一项)" or "(勾选一项)" as hint text
- Group related options with proper indentation for clarity
- For multi-value selections (like emoji scales), convert to individual checkboxes with descriptions

**Single selection pattern:**
```markdown
**精力水平**（选择一项）：
- [ ] 😴 很疲惫 (1分)
- [ ] 😐 一般 (2分)
- [ ] 😊 不错 (3分)
```

### Cross-Platform Script Compatibility
Scripts handle both macOS and Linux:
```bash
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' "s/pattern/replacement/g" file
else
    sed -i "s/pattern/replacement/g" file
fi
```

## Date and Week Number Standards

**Critical**: The system uses **ISO 8601 week numbering** throughout:
- **Bash scripts**: `date +%Y-W%V` 
- **Templater**: `GGGG-[W]WW` format
- **Dataview**: `kkkk-'W'WW` format

This ensures consistent week numbering across all systems (Monday-based weeks, week 1 contains January 4th).

## Plugin Dependencies and Versions

**Required Plugins**:
- **Templater** (v1.16.0+): Core template system
- **Dataview** (v0.5.56+): Dynamic content queries

**Optional but Recommended**:
- **Calendar** (v1.5.10+): Enhanced navigation
- **Periodic Notes** (v0.0.17+): Automated note creation

## Health Monitoring

The system includes comprehensive health checks via `scripts/health-check.sh`:
- File structure integrity validation
- Broken link detection
- Orphaned file identification  
- Large file monitoring
- Disk space verification
- Performance optimization suggestions

## Security Considerations

- Claude Code operates within sandboxed permissions
- No external dependencies for core functionality
- Configurable backup retention prevents data loss
- Script validation prevents path traversal attacks
- Template injection protections in place

## Customization Points

1. **Templates**: Modify content generation in `90-Meta/Templates/`
2. **AI Commands**: Add custom commands in `.claude/commands/`
3. **Dashboards**: Customize Dataview queries in `00-Dashboard/`
4. **Automation**: Extend maintenance scripts in `scripts/`

## Performance Optimization

- Templates use cached date variables to reduce computation
- Dataview queries are optimized with appropriate LIMITs
- Backup scripts check available disk space before operation
- Health check script handles large file detection efficiently
- All date operations use consistent ISO 8601 formatting

## Testing and Validation

When making changes:
1. Run `./scripts/health-check.sh` to validate system integrity
2. Test template generation with various date scenarios
3. Verify Claude Code commands work within permission boundaries
4. Confirm cross-platform compatibility for script changes
5. Validate that ISO 8601 week numbering remains consistent across all systems