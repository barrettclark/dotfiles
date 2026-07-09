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
            "dockerls", "eslint", "gopls", "jsonls",
            "marksman", "pyright", "ruff", "ruby_lsp",
            "sqls", "taplo", "terraformls", "ts_ls", "yamlls",
          },
        },
      },
      { "b0o/schemastore.nvim" },
    },
    config = function()
      -- Advertise nvim-cmp completion capabilities to all LSP servers
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      vim.lsp.config("*", { capabilities = capabilities })

      -- JSON schemas (new capability vs ALE)
      vim.lsp.config("jsonls", {
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      })

      -- YAML schemas (mirrors jsonls + schemastore setup)
      vim.lsp.config("yamlls", {
        settings = {
          yaml = {
            schemas = require("schemastore").yaml.schemas(),
            validate = true,
            schemaStore = { enable = false, url = "" }, -- use schemastore.nvim instead
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
