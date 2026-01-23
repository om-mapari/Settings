# grep (ripgrep) Quick Reference

The `grep` alias uses `rg` (ripgrep) for fast searching.

## Basic Usage

```powershell
# Search in file
grep "text" file.txt

# Case-insensitive
grep -i "error" app.log

# Search all files (recursive by default)
grep "TODO" .

# With line numbers
grep -n "function" script.js

# Count matches
grep -c "import" *.js
```

## Common Patterns

```powershell
# Show context (3 lines before/after)
grep -C 3 "error" app.log

# Invert match (exclude)
grep -v "debug" app.log

# List files with matches
grep -l "database" *.config

# Whole word match
grep -w "log" app.js

# Multiple patterns
grep "error|warning" app.log
```

## Important: Search Everything

```powershell
# rg ignores .gitignore by default
# To search like Linux grep:
grep --hidden --no-ignore "text" .
```

## Pipe Usage

```powershell
cat app.log | grep "error"
Get-Process | grep "chrome"
```

## File Type Filtering

```powershell
grep -t js "function" .
grep -t py "def " .
```
