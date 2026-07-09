return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",  -- master is archived and its queries break on nvim 0.12+ (markdown injections)
    build = ":TSUpdate",
    lazy = false,
    config = function()
      require("nvim-treesitter").install({
        "bash", "dockerfile", "go", "gomod", "hcl", "javascript", "json",
        "lua", "markdown", "markdown_inline", "python", "ruby", "sql",
        "terraform", "toml", "typescript", "vim", "vimdoc", "yaml",
      })

      -- main branch doesn't auto-start highlighting; enable per buffer
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
        callback = function(args)
          -- silently no-ops for filetypes without an installed parser
          if pcall(vim.treesitter.start, args.buf) then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}
