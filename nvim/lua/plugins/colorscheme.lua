return {
  {
    "junegunn/seoul256.vim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.seoul256_background = 234
      vim.cmd.colorscheme("seoul256")
      vim.cmd([[
        highlight CursorLine ctermbg=black term=none cterm=none
        highlight Error cterm=reverse ctermbg=white ctermfg=red
        highlight ColorColumn ctermbg=235 guibg=#2c2d27
      ]])
    end,
  },
}
