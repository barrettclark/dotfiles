return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>t", "<cmd>FzfLua files<CR>", desc = "Files" },
      { "<leader>T", "<cmd>FzfLua git_files<CR>", desc = "Git files" },
      { "<leader>b", "<cmd>FzfLua buffers<CR>", desc = "Buffers" },
      { "<leader>m", "<cmd>FzfLua btags<CR>", desc = "Buffer tags" },
      { "<leader>M", "<cmd>FzfLua tags<CR>", desc = "Project tags" },
      { "<leader>rg", "<cmd>FzfLua live_grep<CR>", desc = "Live grep (rg)" },
    },
    opts = {},
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<C-n>", "<cmd>NvimTreeOpen<CR>", desc = "Open file tree" },
      { "<leader>d", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file tree" },
      { "<leader>f", "<cmd>NvimTreeFindFile<CR>", desc = "Reveal file in tree" },
    },
    opts = {
      filters = { dotfiles = false },  -- NERDTreeShowHidden=1 equivalent
    },
  },
}
