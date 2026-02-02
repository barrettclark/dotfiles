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
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" Core UI
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'                 " Linting and fixing

" Utilities
Plug 'ctrlpvim/ctrlp.vim'       " Fuzzy file finder
Plug 'dbeniamine/todo.txt-vim'  " Todo.txt support
Plug 'mileszs/ack.vim'          " Search (configured for ripgrep)
Plug 'tomtom/tcomment_vim'      " Commenting with gc
Plug 'tpope/vim-surround'       " Surround text objects

" Git
Plug 'airblade/vim-gitgutter'   " Show git diff in gutter
Plug 'tpope/vim-fugitive'       " Git commands
Plug 'tpope/vim-rhubarb'        " GitHub integration (:GBrowse)

" File browser (manual toggle only, no auto-open)
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'    " File icons for NERDTree

" Languages
Plug 'b4b4r07/vim-sqlfmt'       " SQL formatting
Plug 'ekalinin/Dockerfile.vim'   " Docker syntax highlighting
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'hashivim/vim-hashicorp-tools'  " Terraform, Vault, etc
Plug 'leafgarland/typescript-vim'
Plug 'moll/vim-node'            " Node.js helpers
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'vim-ruby/vim-ruby'

" Color scheme
Plug 'junegunn/seoul256.vim'

call plug#end()

""
"" Basic Vim Settings
""

syntax enable
set encoding=UTF-8
set showcmd                     " Display incomplete commands
filetype plugin indent on       " Load file type plugins + indentation

" Whitespace
set backspace=indent,eol,start  " Backspace through everything in insert mode
set expandtab                   " Use spaces, not tabs
set nowrap                      " Don't wrap lines
set tabstop=2 shiftwidth=2      " A tab is two spaces
set list lcs=tab:▸\ ,trail:·,nbsp:_  " Show "invisible" characters

" Searching
set hlsearch                    " Highlight matches
set incsearch                   " Incremental searching
set ignorecase                  " Searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

" UI Settings
set autoindent                  " Auto-indent new lines
set cursorline                  " Highlight the current line
set lazyredraw                  " Don't update while executing macros
set linebreak                   " Break lines at word boundaries
set nocompatible                " No compatibility with legacy vi
set number                      " Line numbers
set scrolloff=4                 " Keep at least 4 lines below cursor
set showmatch                   " Highlight matching brace
set showmode                    " Show current mode
set textwidth=100               " Linewrap at 100 chars

" Folding
set foldmethod=indent
set foldlevelstart=2
set foldcolumn=2
set nofoldenable

" Colors
set termguicolors
let g:seoul256_background = 234
colorscheme seoul256
highlight CursorLine ctermbg=black term=none cterm=none
highlight Error cterm=reverse ctermbg=white ctermfg=red
highlight ColorColumn ctermbg=235 guibg=#2c2d27
let &colorcolumn="72,".join(range(80,120),",")

" Git
set updatetime=300              " Make vim-gitgutter more responsive
set signcolumn=yes              " Prevents screen jumping when linting

""
"" Keybindings
""

" Clear search highlighting
noremap <leader><CR> :noh<CR>

" Source (reload) vimrc
nmap <leader>so :source $MYVIMRC<cr>

" Git blame
nnoremap <Leader>gb :Git blame<CR>

" Copy paths to clipboard
nnoremap <leader>cf :let @*=expand("%")<CR>       " Relative path
nnoremap <leader>cF :let @*=expand("%:p")<CR>     " Absolute path

" Window splitting
nmap <leader>v :vsplit<CR> <C-w><C-w>
nmap <leader>s :split<CR> <C-w><C-w>

" Close buffer
nnoremap <leader>c :bp\|bd #<CR>

" Strip trailing whitespace
noremap <leader>ss :call StripWhitespace()<CR>

""
"" Filetype Settings
""

" SQL extensions
au BufRead,BufNewFile *.bdy,*.fnc,*.grt,*.mvw,*.pkb,*.pkg,*.prc,*.spc,*.tab,*.usr,*.vw setfiletype sql
au BufRead,BufNewFile Dockerfile* setfiletype dockerfile
au BufRead,BufNewFile *.hcl setfiletype terraform
au BufRead,BufNewFile *.todotxt setfiletype todo
au FileType gitcommit set tw=72

""
"" Plugin Configuration
""

" Vim Airline
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='simple'
let g:airline#extensions#ale#enabled = 1

" ALE - Linting and Fixing
let g:ale_sign_column_always = 1
nmap <silent> <C-e> <Plug>(ale_next_wrap)

let g:ale_python_executable='python3'
let g:ale_python_pylint_use_global=1

let g:ale_linters = {
\   'go': ['gometalinter', 'gopls'],
\   'javascript': ['eslint'],
\   'python': ['flake8', 'pylint'],
\   'terraform': ['terraform'],
\   'typescript': ['eslint', 'tsserver'],
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint', 'prettier'],
\   'json': ['jq', 'prettier'],
\   'python': ['autopep8', 'yapf'],
\   'sql': ['sqlformat'],
\   'terraform': ['terraform'],
\   'typescript': ['eslint', 'prettier'],
\   'yaml': ['prettier'],
\}

" Terraform
let g:terraform_align=1
let g:terraform_fmt_on_save=1

" vim-go
let g:go_fmt_command = "goimports"
let g:go_version_warning = 0  " Disable version warning on older systems

" NERDTree (manual toggle only, NO auto-open)
nnoremap <C-n> :NERDTree<CR>
nmap <leader>d :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeFind<CR>

" Exit Vim if NERDTree is the only window remaining
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:NERDTreeShowHidden = 1

" CtrlP
let g:ctrlp_by_filename = 1
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site|node_modules)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_root_markers = ['.ctrlp']

nmap <leader>b :CtrlPBuffer<CR>
nmap <leader>t :CtrlP<CR>
nmap <leader>m :CtrlPBufTag<CR>
nmap <leader>M :CtrlPTag<CR>
nmap <leader>T :CtrlPClearCache<CR>:CtrlP<CR>

" Ack.vim (use ripgrep)
if executable('rg')
  let g:ackprg = 'rg --vimgrep --type-not sql --smart-case'
endif

" SQL formatting
let g:sqlfmt_command = "sqlformat"
let g:sqlfmt_options = "-r -k upper"

" vim-markdown
let g:vim_markdown_folding_disabled = 1

""
"" Functions
""

" Strip trailing whitespace
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction

" Show git diff in split when committing
" https://gist.github.com/bswinnerton/73765deb6150f835f04b91ee3c1811eb
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
