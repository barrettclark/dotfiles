-- Adaptation: installed opencode.nvim (nickjvandyke/opencode.nvim, per
-- lua/opencode.lua) exposes no toggle() function. The README's documented
-- pattern for toggling is to run the opencode server inside a
-- snacks.terminal and toggle that same terminal window. Shared here so the
-- `server.start` config and the `<leader>ot` toggle target the same
-- terminal instance (snacks.terminal keys terminals by cmd + opts).
local opencode_cmd = "opencode --port"
---@type snacks.terminal.Opts
local opencode_terminal_opts = {
  win = { position = "right", enter = false },
}

return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = {},
    keys = {
      { "<leader>ac", "<cmd>ClaudeCode<CR>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<CR>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<CR>", desc = "Resume Claude" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<CR>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<CR>", mode = "v", desc = "Send selection to Claude" },
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<CR>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<CR>", desc = "Deny diff" },
    },
  },
  {
    "NickvanDyke/opencode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        server = {
          start = function()
            require("snacks.terminal").open(opencode_cmd, opencode_terminal_opts)
          end,
        },
      }
      vim.o.autoread = true -- required for opencode_opts.events.reload
    end,
    keys = {
      -- Adaptation: no toggle() on the opencode module (see comment above);
      -- toggle the snacks.terminal running the opencode server instead.
      {
        "<leader>ot",
        function() require("snacks.terminal").toggle(opencode_cmd, opencode_terminal_opts) end,
        desc = "Toggle opencode",
      },
      -- Adaptation: installed opencode.nvim has no "@cursor"/"@selection"
      -- context placeholders (see lua/opencode/context/builtins.lua) -
      -- only "@this", which resolves to the visual selection when present,
      -- else the cursor position. Used for both modes per README example.
      { "<leader>oa", function() require("opencode").ask("@this: ") end, desc = "Ask opencode (cursor)" },
      { "<leader>oa", function() require("opencode").ask("@this: ") end, mode = "v", desc = "Ask opencode (selection)" },
      { "<leader>op", function() require("opencode").select() end, mode = { "n", "v" }, desc = "opencode prompt library" },
    },
  },
}
