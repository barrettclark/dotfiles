#!/bin/bash
#
# Weather
# =======
#
# Based on the work of...
# By Jezen Thomas <jezen@jezenthomas.com>
#
# https://jezenthomas.com/showing-the-weather-in-tmux/

# This script sends a couple of requests over the network to retrieve
# approximate location data, and the current weather for that location. This is
# useful if for example you want to display the current weather in your tmux
# status bar.

# There are three things you will need to do before using this script.
#
# 1. Install jq with your package manager of choice (homebrew, apt-get, etc.)
# 2. Sign up for a free account with forecast.io to grab your API key
# 3. Add your forecast.io API key where it says API_KEY

# Limit the rate of calls to every 2 minutes
SECONDS=$(date +"%s")
FILESTAT=$(stat -f "%m" ~/Dropbox/code/weather.txt)
# if [ $((MINUTE%5)) -ne 10 ]; then
if [ "$(($SECONDS - $FILESTAT))" -lt "600" ]; then
  echo "Using cached file"
  WEATHER_STATUS="`cat ~/Dropbox/code/weather.txt`"
  printf "%s" "$WEATHER_STATUS"
  exit
fi
echo "Getting hot fresh data"

API_KEY=5bf8fb371e81bccec63711c7a3f67d12

set -e

# https://darksky.net/dev/docs/response#data-point
weather_icon() {
  case $1 in
    clear-day) echo 😎
      ;;
    clear-night) echo 🌃
      ;;
    rain) echo ☔️
      ;;
    snow) echo ❄️
      ;;
    sleet|hail) echo 🌨
      ;;
    wind) echo 🌬
      ;;
    fog) echo 🌫
      ;;
    cloudy) echo ☁️
      ;;
    partly-cloudy-day) echo 🌥
      ;;
    partly-cloudy-night) echo ☁︎
      ;;
    thunderstorm) echo ⛈
      ;;
    tornado) echo 🌪
      ;;
    *) echo 🌎 $1
  esac
}

# LOCATION=$(curl --silent http://ip-api.com/csv)
# CITY=$(echo "$LOCATION" | cut -d , -f 6)
# LAT=$(echo "$LOCATION" | cut -d , -f 8)
# LON=$(echo "$LOCATION" | cut -d , -f 9)
# LOCATION=$(CoreLocationCLI) || true
LOCATION=$(curl -s https://ipinfo.io | jq -r '.loc')
# LAT=$(echo $LOCATION | awk '{ print $1 }')
# LON=$(echo $LOCATION | awk '{ print $2 }')
# if [ "$LAT" == "LOCATION" ]; then
#   # CoreLocationCLI error - fallback to Coppell
#   LAT=32.961022
#   LON=-97.013186
# fi

URL="https://api.darksky.net/forecast/$API_KEY/$LOCATION?exclude=hourly,minutely,daily,alerts,flags"
WEATHER=$(curl --silent $URL)

SUMMARY=$(echo "$WEATHER" | jq .currently.summary | sed s/\"//g)
ICON=$(echo "$WEATHER" | jq .currently.icon | sed s/\"//g)
TEMP="$(echo "$WEATHER" | jq .currently.temperature | xargs printf "%.*f\n" 0)°F"
WIND_SPEED="$(echo "$WEATHER" | jq .currently.windSpeed | xargs printf "%.*f" 0) MPH"
EMOJI=$(weather_icon $ICON)

WEATHER_STATUS="$EMOJI $SUMMARY $TEMP, $WIND_SPEED"
echo $WEATHER_STATUS > ~/Dropbox/code/weather.txt
rm -rf ~/Dropbox/code/weather\ *txt
printf "%s" "$WEATHER_STATUS"
