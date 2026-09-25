#!/usr/bin/env zsh
# sudo's env_reset strips almost everything (including OP_SUDO_ITEM) before
# running the askpass helper, so the 1Password item can't come in via the
# environment -- it has to be resolved here instead.
# Jamf presence indicates a HashiCorp-managed (work) laptop; otherwise personal.
if [[ -d "/Library/Application Support/JAMF" ]]; then
  op_item="HashiCorp Laptop"
else
  op_item="Barrett MBA"
fi

# sudo sanitizes PATH via secure_path, so resolve op by absolute path.
op_bin=${OP_BIN:-/opt/homebrew/bin/op}
[[ -x "$op_bin" ]] || op_bin=$(command -v op) || exit 1
"$op_bin" item get "$op_item" --vault Private --fields label=password --reveal
