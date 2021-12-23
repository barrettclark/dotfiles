" Vim needs a POSIX-Compliant shell. Fish is not.
if $SHELL =~ 'bin/fish'
  set shell=/bin/sh
endif

"" Default launchpoint http://mislav.uniqpath.com/2011/12/vim-revisited/
set nocompatible                " choose no compatibility with legacy vi

" vim-plug config
" Brief help
" :PlugInstall    - installs plugins; append `!` to update or just :PlugUpdate
" :PlugUpdate     - update plugins
" :PlugClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" :PlugUpgrade    - upgrade vim-plug itself
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'bling/vim-bufferline'
Plug 'craigemery/vim-autotag'   " update ctags on the fly
Plug 'jeetsukumaran/vim-buffergator'
Plug 'preservim/tagbar'         " F8 opens tagbar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'

" Utilities
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'      " change the working directory to the project root when you open a file or directory
Plug 'ctrlpvim/ctrlp.vim'
Plug 'danro/rename.vim'
Plug 'dbeniamine/todo.txt-vim'
Plug 'godlygeek/tabular'        " Let vim line things up automatically
Plug 'jiangmiao/auto-pairs'     " Insert or delete brackets, parens, quotes in pair
Plug 'junegunn/gv.vim'          " :GV git commit browser to highlight pairs
Plug 'kamykn/spelunker.vim'
Plug 'mileszs/ack.vim'          " :Ack in vim
Plug 'tomtom/tcomment_vim'      " comment lines with <Leader>__ (and other cool tricks)
Plug 'tpope/vim-endwise'        " end structures automatically
Plug 'tpope/vim-fugitive'       " vim Git wrapper
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'zivyangll/git-blame.vim'

" Language-related
Plug 'Quramy/vim-js-pretty-template'
Plug 'git@github.com:AndrewRadev/ember_tools.vim.git'
Plug 'b4b4r07/vim-sqlfmt'
Plug 'dag/vim-fish'
Plug 'dsawardekar/ember.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'hail2u/vim-css3-syntax'
Plug 'hashivim/vim-hashicorp-tools'
Plug 'joukevandermaas/vim-ember-hbs'
Plug 'kballard/vim-swift'
Plug 'leafgarland/typescript-vim'
Plug 'moll/vim-node'            " gf inside require("...") to jump to source and module files
Plug 'mzlogin/vim-markdown-toc' " :GenTocGFM"
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': 'yarn install --frozen-lockfile'}
Plug 'nullvoxpopuli/coc-ember'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'
Plug 'tmux-plugins/vim-tmux'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'vim-ruby/vim-ruby'

" Color scheme for vim
Plug 'junegunn/seoul256.vim'

" Initialize plugin system
call plug#end()

syntax enable
set encoding=utf-8
set showcmd                     " display incomplete commands
filetype plugin indent on       " load file type plugins + indentation

"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode

" Carriage return will clear search highlighting, `n` will still find next
noremap <leader><CR> :noh<CR>

" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,nbsp:_
set list

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

"" My settings
set linebreak                  " break lines at word (requires wrap lines)
set showbreak=+++              " wrap broken line prefix
set textwidth=100              " linewrap
set formatoptions+=1           " break before single-character word
set formatoptions+=2           " use the indentation of the second line
set showmatch                  " highlight matching brace
set autoindent                 " auto-indent new lines
set cursorline
set showmode
set autochdir
set mouse=n
nnoremap : :set nu<CR>:
cnoremap <silent> <CR> <CR>:set nonu<CR>

" fold in the cheese
set foldmethod=indent
set foldlevelstart=2
set foldcolumn=2
set nofoldenable

" Keep the plugin up to date
let g:coc_global_extensions = [
  \ 'coc-css',
  \ 'coc-ember',
  \ 'coc-go',
  \ 'coc-highlight',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-tsserver',
  \ 'coc-yaml',
\ ]

" Git Blame
nnoremap <Leader>gs :<C-u>call gitblame#echo()<CR>

" Show commits for every source line
nnoremap <Leader>gb :Git blame<CR>  " git blame

"" Color scheme settings
let g:seoul256_background = 234
colorscheme seoul256
highlight ColorColumn ctermbg=235 guibg=#2c2d27
let &colorcolumn="72,".join(range(80,120),",")

"" Filetypes for syntax highlighting
au BufRead,BufNewFile *.bdy setfiletype sql
au BufRead,BufNewFile *.fnc setfiletype sql
au BufRead,BufNewFile *.grt setfiletype sql
au BufRead,BufNewFile *.mvw setfiletype sql
au BufRead,BufNewFile *.pkb setfiletype sql
au BufRead,BufNewFile *.pkg setfiletype sql
au BufRead,BufNewFile *.prc setfiletype sql
au BufRead,BufNewFile *.spc setfiletype sql
au BufRead,BufNewFile *.tab setfiletype sql
au BufRead,BufNewFile *.usr setfiletype sql
au BufRead,BufNewFile *.vw setfiletype sql
au BufRead,BufNewFile Dockerfile* setfiletype dockerfile

"" git commit message length
au FileType gitcommit set tw=72

"" CTags
" default leader is \
" CTRL + ] to go to the original definition
" :ts
" See also: grep -H -r 'what_you_search' * | less
let g:autotagTagsFile=".tags"
let g:autotagStartMethod='fork'
nmap <F8> :TagbarToggle<CR>
" To generate tags (if vim-autotags does not), call this from the ex line
" :!ctags
set tags=./.tags,.tags,.git/.tags

" window splitting mappings
" split vertically with <leader> v
" split horizontally with <leader> s
nmap <leader>v :vsplit<CR> <C-w><C-w>
nmap <leader>s :split<CR> <C-w><C-w>

" Tabluarize on first occurrance
" :TabFirst =
command! -nargs=1 -range TabFirst exec <line1> . ',' . <line2> . 'Tabularize /^[^' . escape(<q-args>, '\^$.[?*~') . ']*\zs' . escape(<q-args>, '\^$.[?*~')

"" Vim Airline
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='simple'
let g:airline#extensions#bufferline#enabled = 0

"" vim-go settings
let g:go_fmt_command = "goimports"

"" html tidy
:command Thtml :%!tidy -q -i -config ~/.html-tidy --show-errors 0
:command Txml  :%!tidy -q -i -config ~/.html-tidy --show-errors 0 -xml

"" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_by_filename = 1
let g:ctrlp_regexp = 1

"" SQLFmt
let g:sqlfmt_command = "sqlformat"
let g:sqlfmt_options = "-r -k upper"

"" vim-markdown
let g:vim_markdown_folding_disabled = 1

"" ale
let g:airline#extensions#ale#enabled = 1

" lint on save only
" let g:ale_lint_on_text_changed = 'never'
" disable this option if you don't want linters to run on opening a file
" let g:ale_lint_on_enter = 0

" let g:ale_ruby_reek_executable = 'bundle'
let g:ale_linters = {'go': ['gometalinter', 'gopls']}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'css': ['prettier'],
\   'javascript': ['eslint', 'prettier'],
\   'json': ['jq'],
\   'ruby': ['rubocop'],
\   'scss': ['prettier'],
\   'yaml': ['prettier'],
\}

" Terraform auto-format
let g:terraform_align=1
let g:terraform_fmt_on_save=1

" vim rooter - project root detection
let g:rooter_patterns = ['Rakefile', '.git/']

" nginx config syntax
au BufRead,BufNewFile /etc/nginx/*,/usr/local/etc/nginx/conf/* if &ft == '' | setfiletype nginx | endif

" Spell checking
" custom dictionary in ~/.vim/spell/en.utf-8.add
let g:spelunker_disable_account_name_checking = 1
let g:spelunker_disable_acronym_checking = 1
let g:spelunker_disable_backquoted_checking = 1
let g:spelunker_disable_email_checking = 1
let g:spelunker_disable_uri_checking = 1

" Strip trailing whitespace (\ss)
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>

" Put this in your .vimrc and whenever you `git commit` you'll see the diff of your commit next to your commit message.
" For the most accurate diffs, use `git config --global commit.verbose true`

" https://gist.github.com/bswinnerton/73765deb6150f835f04b91ee3c1811eb
" BufRead seems more appropriate here but for some reason the final `wincmd p` doesn't work if we do that.
autocmd VimEnter COMMIT_EDITMSG call OpenCommitMessageDiff()
function OpenCommitMessageDiff()
  " Save the contents of the z register
  let old_z = getreg("z")
  let old_z_type = getregtype("z")

  try
    call cursor(1, 0)
    let diff_start = search("^diff --git")
    if diff_start == 0
      " There's no diff in the commit message; generate our own.
      let @z = system("git diff --cached -M -C")
    else
      " Yank diff from the bottom of the commit message into the z register
      :.,$yank z
      call cursor(1, 0)
    endif

    " Depending on the width of the window, split vertically or horiziontal
    "
    " 144 is wide enough to display two 72 character commit messages
    if winwidth(0) >= 144
      vnew
    else
      new
    endif

    " Paste into a new buffer
    normal! V"zP
  finally
    " Restore the z register
    call setreg("z", old_z, old_z_type)
  endtry

  " Configure the buffer
  set filetype=diff noswapfile nomodified readonly
  silent file [Changes\ to\ be\ committed]

  " Get back to the commit message
  wincmd p
endfunction
