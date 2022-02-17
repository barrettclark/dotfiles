#!/usr/bin/env bash
# Inspired by https://gist.github.com/fholgado/1982770

APPLE_MUSIC=$( osascript <<EOF
  if application "Music" is running then
    tell application "Music"
      if player state is playing then
        return "♫ " & (get artist of current track) & " – " & (get name of current track)
      else
        return ""
      end if
    end tell
  end if
  return ""
EOF
)

SPOTIFY_MUSIC=$( osascript <<EOF
  if application "Spotify" is running then
    tell application "Spotify"
      if player state is playing then
        return "♫ " & (get artist of current track) & " – " & (get name of current track)
      else
        return ""
      end if
    end tell
  end if
  return ""
EOF
)

# echo $APPLE_MUSIC, $SPOTIFY_MUSIC
if [ ! -z "$APPLE_MUSIC" ]; then
  echo $APPLE_MUSIC
elif [ ! -z "$SPOTIFY_MUSIC" ]; then
  echo $SPOTIFY_MUSIC
fi
