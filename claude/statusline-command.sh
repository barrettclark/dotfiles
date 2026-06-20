#!/bin/bash
input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name')
DIR=$(echo "$input" | jq -r '.workspace.current_dir')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
DURATION_MS=$(echo "$input" | jq -r '.cost.total_duration_ms // 0')
FIVE_PCT=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')

CYAN='\033[36m'; GREEN='\033[32m'; RED='\033[31m'
ORANGE='\033[38;5;214m'; RESET='\033[0m'

# Context bar color: warn at 75%+, critical at 90%+
if [ "$PCT" -ge 90 ]; then BAR_COLOR="$RED"
elif [ "$PCT" -ge 75 ]; then BAR_COLOR="$ORANGE"
else BAR_COLOR="$GREEN"; fi

FILLED=$((PCT / 10)); EMPTY=$((10 - FILLED))
printf -v FILL "%${FILLED}s"; printf -v PAD "%${EMPTY}s"
BAR="${FILL// /█}${PAD// /░}"

MINS=$((DURATION_MS / 60000)); SECS=$(((DURATION_MS % 60000) / 1000))

BRANCH=""
GITHUB_REPO=""
if git -C "$DIR" rev-parse --git-dir > /dev/null 2>&1; then
  BRANCH=" | 🌿 $(git -C "$DIR" branch --show-current 2>/dev/null)"
  REMOTE=$(git -C "$DIR" remote get-url origin 2>/dev/null)
  if [[ "$REMOTE" == *"github.com"* ]]; then
    GITHUB_REPO=$(echo "$REMOTE" | sed 's|.*github\.com[:/]\(.*\)\.git$|\1|;s|.*github\.com[:/]\(.*\)$|\1|')
    GITHUB_REPO=" (${GITHUB_REPO})"
  fi
fi

echo -e "${CYAN}[${MODEL}]${RESET} 📁 ${DIR##*/}${GITHUB_REPO}${BRANCH}"

LINE2="${BAR_COLOR}${BAR} ${PCT}%${RESET} | ⏱️ ${MINS}m ${SECS}s"

# 5-hour rate limit — silent fallback when not populated
if [ -n "$FIVE_PCT" ]; then
  FIVE_INT=$(printf "%.0f" "$FIVE_PCT")
  if   [ "$FIVE_INT" -ge 90 ]; then RATE_COLOR="$RED"
  elif [ "$FIVE_INT" -ge 75 ]; then RATE_COLOR="$ORANGE"
  else RATE_COLOR="$GREEN"; fi
  LINE2="${LINE2} | ${RATE_COLOR}⏳ 5h ${FIVE_INT}%${RESET}"
fi

echo -e "$LINE2"
