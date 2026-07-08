local opt = vim.opt

opt.showcmd = true

-- Whitespace
opt.expandtab = true
opt.wrap = false
opt.tabstop = 2
opt.shiftwidth = 2
opt.list = true
opt.listchars = { tab = "▸ ", trail = "·", nbsp = "_" }

-- Searching
opt.ignorecase = true
opt.smartcase = true

-- UI
opt.cursorline = true
opt.linebreak = true
opt.number = true
opt.scrolloff = 4
opt.showmatch = true
opt.showmode = true
opt.textwidth = 100
opt.colorcolumn = "72," .. table.concat(vim.fn.range(80, 120), ",")

-- Persistent undo (default dir: ~/.local/state/nvim/undo)
opt.undofile = true

-- Folding
opt.foldmethod = "indent"
opt.foldlevelstart = 2
opt.foldcolumn = "2"
opt.foldenable = false

-- Colors
opt.termguicolors = true

-- Git responsiveness (gitsigns) / no sign-column jumping
opt.updatetime = 300
opt.signcolumn = "yes"

-- macOS clipboard
if vim.fn.has("macunix") == 1 then
  opt.clipboard = "unnamed"
end
