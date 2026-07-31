local map = vim.keymap.set

-- Clear search highlighting
map("n", "<leader><CR>", "<cmd>noh<CR>", { desc = "Clear search highlight" })

-- Git blame (fugitive, installed in Task 5)
map("n", "<leader>gb", "<cmd>Git blame<CR>", { desc = "Git blame" })

-- Copy paths to system clipboard
map("n", "<leader>cf", function() vim.fn.setreg("*", vim.fn.expand("%")) end, { desc = "Copy relative path" })
map("n", "<leader>cF", function() vim.fn.setreg("*", vim.fn.expand("%:p")) end, { desc = "Copy absolute path" })

-- Window splitting
map("n", "<leader>v", "<cmd>vsplit<CR><C-w><C-w>", { desc = "Vertical split" })
map("n", "<leader>s", "<cmd>split<CR><C-w><C-w>", { desc = "Horizontal split" })

-- Close buffer without closing window
map("n", "<leader>c", "<cmd>bp<bar>bd #<CR>", { desc = "Close buffer" })

-- Strip trailing whitespace
map("n", "<leader>ss", function() require("functions").strip_whitespace() end, { desc = "Strip trailing whitespace" })

-- Next diagnostic (replaces ALE <C-e> ale_next_wrap)
map("n", "<C-e>", function() vim.diagnostic.jump({ count = 1, float = true, wrap = true }) end, { desc = "Next diagnostic" })

-- Comment toggle (mirrors old <Leader>__ from tcomment)
map("n", "<leader>__", "gcc", { desc = "Comment line", remap = true })
map("v", "<leader>__", "gc", { desc = "Comment selection", remap = true })
