return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      {
        "mason-org/mason-lspconfig.nvim",
        opts = {
          -- installs the servers and auto-enables them (mason-lspconfig v2)
          ensure_installed = {
            "gopls", "terraformls", "pyright", "ruff",
            "ts_ls", "eslint", "ruby_lsp", "jsonls",
          },
        },
      },
      { "b0o/schemastore.nvim" },
    },
    config = function()
      -- JSON schemas (new capability vs ALE)
      vim.lsp.config("jsonls", {
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      })

      -- Ruby: ruby-lsp runs RuboCop diagnostics by default when the
      -- project has a .rubocop.yml; no extra config needed.

      -- LSP keymaps on attach (gd/gr/K are Neovim 0.11 defaults; add rename/code action)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local opts = { buffer = args.buf }
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        end,
      })
    end,
  },
}
