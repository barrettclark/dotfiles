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

source ~/.tautulli
PLEX_MUSIC=$(curl --silent "$TAUTULLI_URL" | jq -r ".response.data.sessions[] | select(.username==\"$TAUTULLI_USER\" and .media_type==\"track\" and .state==\"playing\") | .grandparent_title + \" - \" + .title")

# echo $APPLE_MUSIC, $SPOTIFY_MUSIC, $PLEX_MUSIC
if [ ! -z "$APPLE_MUSIC" ]; then
  echo $APPLE_MUSIC
elif [ ! -z "$SPOTIFY_MUSIC" ]; then
  echo $SPOTIFY_MUSIC
elif [ ! -z "$PLEX_MUSIC" ]; then
  echo $PLEX_MUSIC
fi
