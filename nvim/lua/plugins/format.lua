return {
  {
    "stevearc/conform.nvim",
    -- "keys" alone would only load conform once <leader>F is pressed,
    -- which means format_on_save would never fire on a fresh session.
    -- Load eagerly enough to have the BufWritePre autocmd in place.
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>F",
        function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        go = { "goimports" },
        javascript = { "eslint_d", "prettier" },
        json = { "jq" },
        markdown = { "prettier" },
        python = { "ruff_format" },
        sql = { "sqlformat" },
        terraform = { "terraform_fmt" },
        toml = { "taplo" },
        typescript = { "eslint_d", "prettier" },
        yaml = { "prettier" },
        ["_"] = { "trim_whitespace", "trim_newlines" }, -- ALE '*' fixers
      },
      formatters = {
        -- conform has no built-in "sqlformat" formatter (only sqlfmt,
        -- sqlfluff, sql_formatter), so it must be fully defined here to
        -- shell out to the python-sqlparse `sqlformat` CLI on stdin.
        sqlformat = {
          command = "sqlformat",
          args = { "-r", "-k", "upper", "-" },
          stdin = true,
        },
      },
      format_on_save = function(bufnr)
        local ft = vim.bo[bufnr].filetype
        if ft == "go" or ft == "terraform" then
          -- goimports cold start is ~1.1s (module cache scan); warm runs are ~30ms
          return { timeout_ms = 3000, lsp_format = "fallback" }
        end
        return nil -- all other filetypes: manual <leader>F only
      end,
    },
  },
}
