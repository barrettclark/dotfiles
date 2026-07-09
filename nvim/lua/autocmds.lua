-- Filetype detection (ports .vimrc au BufRead,BufNewFile lines)
vim.filetype.add({
  extension = {
    bdy = "sql", fnc = "sql", grt = "sql", mvw = "sql", pkb = "sql",
    pkg = "sql", prc = "sql", spc = "sql", tab = "sql", usr = "sql",
    vw = "sql",
    hcl = "terraform",
    todotxt = "todo",
  },
  pattern = {
    ["Dockerfile.*"] = "dockerfile",
  },
})

-- Commit messages wrap at 72
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  callback = function() vim.opt_local.textwidth = 72 end,
})

-- Show staged diff in a split when committing (kept as vimscript — a
-- direct port of the .vimrc function, verified working under nvim)
vim.cmd([[
autocmd VimEnter COMMIT_EDITMSG call OpenCommitMessageDiff()
function OpenCommitMessageDiff()
  let old_z = getreg("z")
  let old_z_type = getregtype("z")

  try
    call cursor(1, 0)
    let diff_start = search("^diff --git")
    if diff_start == 0
      let @z = system("git diff --cached -M -C")
    else
      :.,$yank z
      call cursor(1, 0)
    endif

    if winwidth(0) >= 144
      vnew
    else
      new
    endif

    normal! V"zP
  finally
    call setreg("z", old_z, old_z_type)
  endtry

  set filetype=diff noswapfile nomodified readonly
  silent file [Changes\ to\ be\ committed]
  wincmd p
endfunction
]])
