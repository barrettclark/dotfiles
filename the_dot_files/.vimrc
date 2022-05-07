" Vim needs a POSIX-Compliant shell. Fish is not.
if $SHELL =~ 'bin/fish'
  set shell=/bin/sh
endif

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
Plug 'SirVer/ultisnips'         " snippets
Plug 'airblade/vim-rooter'      " change the working directory to the project root when you open a file or directory
Plug 'ctrlpvim/ctrlp.vim'
Plug 'danro/rename.vim'
Plug 'dbeniamine/todo.txt-vim'
Plug 'git@github.com:tpope/vim-dispatch.git'  " run commands in vim asynch
Plug 'honza/vim-snippets'       " snippets
Plug 'jiangmiao/auto-pairs'     " Insert or delete brackets, parens, quotes in pair
Plug 'kamykn/spelunker.vim'     " Improves spell checking
Plug 'mileszs/ack.vim'          " :Ack in vim
Plug 'tomtom/tcomment_vim'      " comment lines with <Leader>__ (and other cool tricks)
Plug 'tpope/vim-endwise'        " end structures automatically
Plug 'tpope/vim-surround'       " surround words/phrases -- ysiw' will surround word with single quote

" Git utilities
Plug 'airblade/vim-gitgutter'   " show git status in the gutter
Plug 'junegunn/gv.vim'          " :GV open git commit browser; :GV! will only list commits that affected the current file
Plug 'tpope/vim-fugitive'       " vim Git wrapper
Plug 'tpope/vim-rhubarb'        " :GBrowse to open current file in GitHub

" NERDTree
Plug 'preservim/nerdtree' |
      \ Plug 'Xuyuanp/nerdtree-git-plugin' |
      \ Plug 'ryanoasis/vim-devicons' |
      \ Plug 'tiagofumo/vim-nerdtree-syntax-highlight' |
      \ Plug 'unkiwii/vim-nerdtree-sync' |
      \ Plug 'tyok/nerdtree-ack'

" Language-related
Plug 'b4b4r07/vim-sqlfmt'
Plug 'dag/vim-fish'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'hail2u/vim-css3-syntax'
Plug 'hashivim/vim-hashicorp-tools'
Plug 'mzlogin/vim-markdown-toc' " :GenTocGFM"
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': 'yarn install --frozen-lockfile'}
Plug 'othree/html5.vim'
Plug 'plasticboy/vim-markdown'
Plug 'tmux-plugins/vim-tmux'

" JavaScript
Plug 'Quramy/vim-js-pretty-template'
Plug 'leafgarland/typescript-vim'
Plug 'moll/vim-node'            " gf inside require('...') to jump to source and module files
Plug 'pangloss/vim-javascript'

" Ruby
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
set encoding=UTF-8
set showcmd                     " display incomplete commands
filetype plugin indent on       " load file type plugins + indentation

"" Whitespace
set backspace=indent,eol,start  " backspace through everything in insert mode
set expandtab                   " use spaces, not tabs (optional)
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
set list lcs=tab:▸\ ,trail:·,nbsp:_ " Show “invisible” characters

" Carriage return will clear search highlighting, `n` will still find next
noremap <leader><CR> :noh<CR>

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

"" My settings
set autochdir                  " set the working directory to the current file
set autoindent                 " auto-indent new lines
set cursorline                 " highlight the current line
set formatoptions+=1           " break before single-character word
set formatoptions+=2           " use the indentation of the second line
set lazyredraw                 " Don't update while executing macros
set linebreak                  " break lines at word (requires wrap lines)
set nocompatible               " choose no compatibility with legacy vi
set number                     " Line numbers - always on all the time
set scrolloff=4                " keep at least 4 lines below the cursor
set showbreak=+++              " wrap broken line prefix
set showmatch                  " highlight matching brace
set showmode                   " always show what mode we're currently editing in
set textwidth=100              " linewrap

"" Line numbers - display only when the ex line is active
" nnoremap : :set nu<CR>:
" cnoremap <silent> <CR> <CR>:set nonu<CR>

" fold in the cheese
set foldmethod=indent
set foldlevelstart=2
set foldcolumn=2
set nofoldenable

" Source (reload) your vimrc
nmap <leader>so :source $MYVIMRC<cr>

" Keep the COC plugin up to date
let g:coc_global_extensions = [
  \ 'coc-css',
  \ 'coc-go',
  \ 'coc-highlight',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-markdownlint',
  \ 'coc-pyright',
  \ 'coc-tsserver',
  \ 'coc-yaml',
\ ]

" Show commits for every source line
nnoremap <Leader>gb :Git blame<CR>

" copy relative path to system clipboard (src/foo.txt)
nnoremap <leader>cf :let @*=expand("%")<CR>

" copy absolute path to system clipboard (/something/src/foo.txt)
nnoremap <leader>cF :let @*=expand("%:p")<CR>

" Color scheme settings
let g:seoul256_background = 234
colorscheme seoul256
highlight CursorLine ctermbg=black term=none cterm=none
highlight Error cterm=reverse ctermbg=white ctermfg=red
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

"" Vim Airline
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='simple'
let g:airline#extensions#bufferline#enabled = 0

"" vim-go settings
let g:go_fmt_command = "goimports"

" rspec
let g:rspec_command = "Dispatch bin/rspec {spec}"

"" html tidy
:command Thtml :%!tidy -q -i -config ~/.html-tidy --show-errors 0
:command Txml  :%!tidy -q -i -config ~/.html-tidy --show-errors 0 -xml

" NERDTree config
nnoremap <C-n> :NERDTree<CR>
nmap <leader>d :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeFind<CR>

" close the last buffer (file)
nnoremap <leader>c :bp\|bd #<CR>

" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p

" Start NERDTree with the current file shown in the file tree
" autocmd BufEnter * silent! if bufname('%') !~# 'NERD_tree_' | cd %:p:h | NERDTreeCWD | wincmd p | endif

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:NERDSpaceDelims = 1
let g:NERDTreeGitStatusUseNerdFonts = 1
let g:NERDTreeHighlightCursorline = 1
let g:NERDTreeShowHidden = 1
let g:airline_powerline_fonts = 1
let g:nerdtree_sync_cursorline = 1

"" CtrlP
" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_by_filename = 1
" let g:ctrlp_regexp = 1
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}
 " Use the nearest .git directory as the cwd
let g:ctrlp_working_path_mode = 'ra'
" ...unless you specifically force it (Useful for things like Rails subprojects)
let g:ctrlp_root_markers = ['.ctrlp']

nmap <leader>b :CtrlPBuffer<CR>
nmap <leader>t :CtrlP<CR>
nmap <leader>m :CtrlPBufTag<CR>
nmap <leader>M :CtrlPTag<CR>
nmap <leader>T :CtrlPClearCache<CR>:CtrlP<CR>

"" SQLFmt
let g:sqlfmt_command = "sqlformat"
let g:sqlfmt_options = "-r -k upper"

"" vim-markdown
let g:vim_markdown_folding_disabled = 1

"" ale
let g:airline#extensions#ale#enabled = 1

" Only run linters named in ale_linters settings.
" let g:ale_linters_explicit = 1
let g:ale_sign_column_always = 1

" Ctrl-e to go to the next error
nmap <silent> <C-e> <Plug>(ale_next_wrap)

" lint on save only
" let g:ale_lint_on_text_changed = 'never'
" disable this option if you don't want linters to run on opening a file
" let g:ale_lint_on_enter = 0

let g:ale_ruby_reek_executable = 'bundle'
let g:ale_linters = {
\   'go': ['gometalinter', 'gopls'],
\   'ruby': ['brakeman', 'debride', 'reek', 'rubocop', 'sorbet'],
\}
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
