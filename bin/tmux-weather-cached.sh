#!/bin/bash

# Cache file location
CACHE_FILE="${TMPDIR:-/tmp}/tmux-weather-cache-$USER"
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
# No location given: wttr.in geolocates by request IP, so this follows
# the machine when traveling (VPNs will report the exit node's city).
# Using format=2 for compact output without the location name: "emoji temp"
WEATHER=$(curl -sf --max-time 3 "wttr.in/?format=2" 2>/dev/null)

# Require a degree sign before caching — wttr.in rate-limit/error pages
# come back with HTTP 200 and would otherwise poison the cache
if [[ "$WEATHER" == *"°"* ]]; then
  echo "$WEATHER" > "$CACHE_FILE.tmp" && mv "$CACHE_FILE.tmp" "$CACHE_FILE"
  echo "$WEATHER"
else
  # If curl failed, try to use old cache as fallback
  if [[ -f "$CACHE_FILE" ]]; then
    cat "$CACHE_FILE"
  else
    echo "Weather unavailable"
  fi
fi
