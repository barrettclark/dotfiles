#!/usr/bin/env bash
# Inspired by https://gist.github.com/fholgado/1982770

APPLE_MUSIC=$(osascript <<EOF
  if application "Music" is running then
    tell application "Music"
      if player state is playing then
        return " " & (get artist of current track) & " – " & (get name of current track)
      else
        return ""
      end if
    end tell
  end if
  return ""
EOF
)

SPOTIFY_MUSIC=$(osascript <<EOF
  if application "Spotify" is running then
    tell application "Spotify"
      if player state is playing then
        return "🎧 " & (get artist of current track) & " – " & (get name of current track)
      else
        return ""
      end if
    end tell
  end if
  return ""
EOF
)

if [ -n "$APPLE_MUSIC" ]; then
  echo "$APPLE_MUSIC"
elif [ -n "$SPOTIFY_MUSIC" ]; then
  echo "$SPOTIFY_MUSIC"
elif [ -f "$HOME/.plex" ] && pgrep -ix "Plexamp" &>/dev/null; then
  source "$HOME/.plex"
  PLEX_MUSIC=$(curl --silent --max-time 2 \
    -H "Accept: application/json" \
    "$PLEX_URL/status/sessions?X-Plex-Token=$PLEX_TOKEN" \
    | jq -r '
      .MediaContainer.Metadata[]?
      | select(.type == "track")
      | select(.Player.state == "playing")
      | "▶ " + .grandparentTitle + " – " + .title
    ' 2>/dev/null | head -1)
  [ -n "$PLEX_MUSIC" ] && echo "$PLEX_MUSIC"
fi
