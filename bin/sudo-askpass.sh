#!/usr/bin/env zsh
# sudo sanitizes PATH via secure_path, so resolve op by absolute path.
op_bin=${OP_BIN:-/opt/homebrew/bin/op}
[[ -x "$op_bin" ]] || op_bin=$(command -v op) || exit 1
"$op_bin" item get "${OP_SUDO_ITEM}" --vault Private --fields label=password --reveal
