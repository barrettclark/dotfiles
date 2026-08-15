#!/usr/bin/env bash

TRUE_FULL_SCREEN="$1"

start_terminal_and_run_tmux() {
	osascript <<-APPLESCRIPT
	tell application "Ghostty"
		activate
		delay 2
		tell application "System Events" to tell process "Ghostty"
			set frontmost to true
			keystroke "tmux"
			key code 36
		end tell
	end tell
	APPLESCRIPT
}

resize_to_true_full_screen() {
	osascript <<-APPLESCRIPT
	tell application "Ghostty"
		activate
		delay 1
		tell application "System Events" to tell process "Ghostty"
			keystroke "f" using {control down, command down}
		end tell
	end tell
	APPLESCRIPT
}

main() {
	start_terminal_and_run_tmux
	if [ "$TRUE_FULL_SCREEN" == "fullscreen" ]; then
		resize_to_true_full_screen
	fi
}
main
