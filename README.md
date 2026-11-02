# Log Watcher and Alert Tool

A bash script that watches a log file in real time and prints (and saves) only the log lines matching the severity level(s) you care about.

## Features

- Watches a log file continuously for new lines as they're written
- Filters lines by one or more severity levels (e.g. only show `ERROR` and `WARNING`)
- Prints matching lines to the screen as they appear
- Saves matching lines to a separate file (`watch.log`) for a permanent record
- Lets you choose whether to append to or overwrite an existing `watch.log` from a previous run
- Cleans up on exit (Ctrl+C) and optionally removes the generated `watch.log`

## Requirements

- bash
- Standard Unix tools: `awk`, `tail`, `tee`, `dirname`, `basename`

## Expected Log Format

The log file you point this tool at must have each line in this format:

```
YYYY-MM-DD HH:MM:SS SEVERITY MESSAGE
```

Example:

```
2026-10-31 14:22:01 ERROR database connection failed
2026-10-31 14:22:05 INFO user logged in
```

The severity word (3rd field) is what the tool matches against.

## Usage

```bash
./logwatcher.sh -p /path/to/file.log -k 3
```

or, if the file is in the current directory:

```bash
./logwatcher.sh -f file.log -k 3,4
```

## Options

| Flag | Description |
|------|-------------|
| `-h` | Show the help menu |
| `-p` | Path to the log file (use when the file is not in the current directory) |
| `-f` | Log file name only (use when the file is in the current directory) |
| `-k` | Severity level(s) to watch for. Single value or comma-separated list, e.g. `3` or `1,3,4` |

**Note:** Use only one of `-p` or `-f` at a time, not both.

## Severity Levels

| Number | Level |
|--------|-------|
| 0 | EMERGENCY |
| 1 | ALERT |
| 2 | CRITICAL |
| 3 | ERROR |
| 4 | WARNING |
| 5 | NOTICE |
| 6 | INFO |
| 7 | DEBUG |

## Example

Watch `app.log` in the current directory for `ERROR` and `WARNING` lines only:

```bash
./logwatcher.sh -f app.log -k 3,4
```

Every time a new line is added to `app.log` with severity `ERROR` or `WARNING`, it will:
1. Print to the screen immediately
2. Be appended to `watch.log`

## Stopping the Tool

Press `Ctrl+C` to stop watching. You'll be asked whether you want to delete the generated `watch.log` file before the script exits.

## Notes

- If a `watch.log` file already exists from a previous run, you'll be prompted to either append new matches to it or clear it and start fresh.
- Lines that don't match any of the specified severity levels are ignored (not printed, not saved).