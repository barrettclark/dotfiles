" Vim needs a POSIX-Compliant shell. Fish is not.
if $SHELL =~ 'bin/fish'
  set shell=/bin/sh
endif

"" Default launchpoint http://mislav.uniqpath.com/2011/12/vim-revisited/
set nocompatible                " choose no compatibility with legacy vi

" Vundle config
filetype off
" set the runtime path to include Vundle and initialize
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'bling/vim-bufferline'
Plugin 'gmarik/Vundle.vim'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'majutsushi/tagbar'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Plugin 'vim-syntastic/syntastic'
Plugin 'w0rp/ale'

" Utilities
Plugin 'airblade/vim-gitgutter'
Plugin 'airblade/vim-rooter'      " change the working directory to the project root when you open a file or directory
Plugin 'craigemery/vim-autotag'   " update ctags on the fly
Plugin 'danro/rename.vim'
Plugin 'dbeniamine/todo.txt-vim'
Plugin 'godlygeek/tabular'        " Let vim line things up automatically
Plugin 'jiangmiao/auto-pairs'     " Insert or delete brackets, parens, quotes in pair
Plugin 'junegunn/gv.vim'          " :GV git commit browser
Plugin 'mileszs/ack.vim'          " :Ack in vim
Plugin 'prettier/vim-prettier'
Plugin 'tomtom/tcomment_vim'      " comment lines with <Leader>__ (and other cool tricks)
Plugin 'tpope/vim-endwise'        " end structures automatically
Plugin 'tpope/vim-fugitive'       " vim Git wrapper
Plugin 'tpope/vim-surround'

" Language-related
Plugin 'dag/vim-fish'
Plugin 'fatih/vim-go'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'kballard/vim-swift'
Plugin 'kchmck/vim-coffee-script'
Plugin 'moll/vim-node'            " gf inside require("...") to jump to source and module files
Plugin 'mzlogin/vim-markdown-toc' " :GenTocGFM"
Plugin 'othree/html5.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'plasticboy/vim-markdown'
Plugin 'tmux-plugins/vim-tmux'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'

" Color scheme for vim
Plugin 'junegunn/seoul256.vim'

" Not currently in use but helpful in the past
" Plugin 'chriskempson/base16-vim'
" Plugin 'ctrlpvim/ctrlp.vim'
" Plugin 'derekwyatt/vim-scala'
" Plugin 'elixir-lang/vim-elixir'
" Plugin 'morhetz/gruvbox'
" Plugin 'nginx.vim'
" Plugin 'rust-lang/rust.vim'
" Plugin 'trevordmiller/nova-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required

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
set textwidth=120              " linewrap
set showmatch                  " highlight matching brace
set autoindent                 " auto-indent new lines
set cursorline
set showmode
set autochdir
nnoremap : :set nu<CR>:
cnoremap <silent> <CR> <CR>:set nonu<CR>

"" Color scheme settings
let g:seoul256_background = 234
colorscheme seoul256
highlight ColorColumn ctermbg=235 guibg=#2c2d27
let &colorcolumn="72,".join(range(80,120),",")

"" Filetypes for syntax highlighting
autocmd BufNewFile,BufRead *.json set ft=javascript
au BufRead,BufNewFile *.vw setfiletype sql
au BufRead,BufNewFile *.mvw setfiletype sql
au BufRead,BufNewFile *.prc setfiletype sql
au BufRead,BufNewFile *.fnc setfiletype sql
au BufRead,BufNewFile *.bdy setfiletype sql
au BufRead,BufNewFile *.tab setfiletype sql
au BufRead,BufNewFile *.spc setfiletype sql
au BufRead,BufNewFile Dockerfile* setfiletype dockerfile

"" git commit message length
au FileType gitcommit set tw=72

"" CTags
" default leader is \
" CTRL + ] to go to the original definition
" :ts
" See also: grep -H -r 'what_you_search' * | less
let g:autotagTagsFile=".tags"
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

"" Prettier formatting
let g:prettier#autoformat = 0
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#trailing_comma = 'es5'
let g:prettier#config#single_quote = 'true'
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync

"" html tidy
:command Thtml :%!tidy -q -i -config ~/.html-tidy --show-errors 0
:command Txml  :%!tidy -q -i --show-errors 0 -xml

"" vim-markdown
let g:vim_markdown_folding_disabled = 1

"" ale
let g:airline#extensions#ale#enabled = 1

" lint on save only
" let g:ale_lint_on_text_changed = 'never'
" disable this option if you don't want linters to run on opening a file
" let g:ale_lint_on_enter = 0

let g:ale_ruby_reek_executable = 'bundle'
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'css': ['prettier'],
\   'javascript': ['eslint', 'prettier'],
\   'json': ['jq'],
\   'markdown': ['prettier'],
\   'ruby': ['rubocop'],
\   'scss': ['prettier'],
\   'yaml': ['prettier'],
\}

"" vim rooter - project root detection
let g:rooter_patterns = ['Rakefile', '.git/']

" nginx config syntax
au BufRead,BufNewFile /etc/nginx/*,/usr/local/etc/nginx/conf/* if &ft == '' | setfiletype nginx | endif

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
