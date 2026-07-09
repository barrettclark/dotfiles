local M = {}

-- Port of .vimrc StripWhitespace(): preserve cursor and last search
function M.strip_whitespace()
  local save_cursor = vim.fn.getpos(".")
  local old_query = vim.fn.getreg("/")
  vim.cmd([[%s/\s\+$//e]])
  vim.fn.setpos(".", save_cursor)
  vim.fn.setreg("/", old_query)
end

return M
