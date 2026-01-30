#!/bin/bash

# Cache file location
CACHE_FILE="/tmp/tmux-weather-cache"
CACHE_DURATION=900  # 15 minutes in seconds

# Check if cache exists and is fresh
if [[ -f "$CACHE_FILE" ]]; then
  # Get cache age in seconds
  if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    CACHE_AGE=$(($(date +%s) - $(stat -f %m "$CACHE_FILE")))
  else
    # Linux
    CACHE_AGE=$(($(date +%s) - $(stat -c %Y "$CACHE_FILE")))
  fi

  # If cache is fresh, use it
  if [[ $CACHE_AGE -lt $CACHE_DURATION ]]; then
    cat "$CACHE_FILE"
    exit 0
  fi
fi

# Cache is stale or doesn't exist, fetch new data
# Using format=3 for simple output: "Location: emoji temp"
WEATHER=$(curl -s --max-time 3 "wttr.in/DFW?format=3" 2>/dev/null)

# If curl succeeded, cache and display
if [[ $? -eq 0 ]] && [[ -n "$WEATHER" ]]; then
  echo "$WEATHER" > "$CACHE_FILE"
  echo "$WEATHER"
else
  # If curl failed, try to use old cache as fallback
  if [[ -f "$CACHE_FILE" ]]; then
    cat "$CACHE_FILE"
  else
    echo "Weather unavailable"
  fi
fi
