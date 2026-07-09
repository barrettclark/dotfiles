return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- popup appears after you pause mid-sequence (vim.o.timeoutlen, 1000ms)
      spec = {
        { "<leader>a", group = "claude" },
        { "<leader>c", group = "close/copy-path" },
        { "<leader>o", group = "opencode" },
        { "<leader>r", group = "grep/rename" },
        { "<leader>s", group = "split/strip" },
      },
    },
    keys = {
      {
        "<leader>?",
        function() require("which-key").show({ global = false }) end,
        desc = "Buffer-local keymaps (which-key)",
      },
    },
  },
}
