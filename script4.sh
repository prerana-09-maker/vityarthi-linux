#!/bin/bash

# Default values for log file and keyword
LOGFILE=${1:-"/var/log/messages"}
KEYWORD=${2:-"error"}
LINES=${3:-5}  # Default to 5 lines of matching output
DATE_FILTER=${4}  # Optional: filter by date

# Print header
echo "======================================"
echo "        LOG FILE ANALYZER"
echo "======================================"
echo "File: $LOGFILE"
echo "Keyword: $KEYWORD"
echo "Matching Lines to Show: $LINES"
echo ""

# Check if the log file exists and is readable
if [ ! -f "$LOGFILE" ]; then
    echo "Error: File '$LOGFILE' not found or not readable."
    exit 1
fi

echo "Log file found."

# If a date filter is provided, apply it.
if [ -n "$DATE_FILTER" ]; then
    echo "Filtering logs by date: $DATE_FILTER"
    MATCHES=$(grep -i "$KEYWORD" "$LOGFILE" | grep "$DATE_FILTER")
else
    MATCHES=$(grep -i "$KEYWORD" "$LOGFILE")
fi

# Count the number of matches
COUNT=$(echo "$MATCHES" | grep -c .)

echo "Keyword '$KEYWORD' found $COUNT times."
