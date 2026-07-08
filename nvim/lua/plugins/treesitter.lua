return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = {
        "bash", "dockerfile", "go", "gomod", "hcl", "javascript", "json",
        "lua", "markdown", "markdown_inline", "python", "ruby", "sql",
        "terraform", "typescript", "vim", "vimdoc", "yaml",
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
}
