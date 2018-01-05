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
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'gmarik/Vundle.vim'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/syntastic'
Plugin 'skywind3000/quickmenu.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Utilities
Plugin 'airblade/vim-rooter'
Plugin 'craigemery/vim-autotag'
Plugin 'danro/rename.vim'
Plugin 'godlygeek/tabular'
Plugin 'jiangmiao/auto-pairs'
Plugin 'junegunn/gv.vim'          " :GV git commit browser
Plugin 'justinmk/vim-gtfo'        " :gof open dir in Finder, :got open dir in terminal
Plugin 'mileszs/ack.vim'          " :Ack in vim
Plugin 'rizzatti/dash.vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'       " vim Git wrapper
Plugin 'tpope/vim-surround'
Plugin 'dbeniamine/todo.txt-vim'

" Language-related
Plugin 'dag/vim-fish'
Plugin 'fatih/vim-go'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'kballard/vim-swift'
Plugin 'kchmck/vim-coffee-script'
Plugin 'mzlogin/vim-markdown-toc'
Plugin 'othree/html5.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'plasticboy/vim-markdown'
Plugin 'tmux-plugins/vim-tmux'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'

" Color scheme for vim
Plugin 'junegunn/seoul256.vim'
Plugin 'morhetz/gruvbox'
Plugin 'trevordmiller/nova-vim'

" Not currently in use but helpful in the past
" Bundle 'edkolev/tmuxline.vim'
" Plugin 'derekwyatt/vim-scala'
" Plugin 'elixir-lang/vim-elixir'
" Plugin 'nginx.vim'
" Plugin 'rust-lang/rust.vim'

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

" Strip trailing whitespace (\ss)
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>

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
" set ruler                      " show row and column ruler info
set guifont=Droid\ Sans\ Mono\ Slashed:h16
" set number
nnoremap : :set nu<CR>:
cnoremap <silent> <CR> <CR>:set nonu<CR>
" color blackboard
" colorscheme gruvbox
" colorscheme nova
" set background=dark
let g:seoul256_background = 234
colorscheme seoul256
highlight ColorColumn ctermbg=235 guibg=#2c2d27
let &colorcolumn="72,".join(range(80,120),",")
" let &colorcolumn="80,".join(range(120,999),",")
set cursorline
set showmode
" set title
set showcmd
set autochdir

"" Filetypes for syntax highlighting
autocmd BufNewFile,BufRead *.json set ft=javascript
au BufRead,BufNewFile *.vw setfiletype sql
au BufRead,BufNewFile *.mvw setfiletype sql
au BufRead,BufNewFile *.prc setfiletype sql
au BufRead,BufNewFile *.fnc setfiletype sql
au BufRead,BufNewFile *.bdy setfiletype sql
au BufRead,BufNewFile *.tab setfiletype sql
au BufRead,BufNewFile *.spc setfiletype sql

"" git commit message length
au FileType gitcommit set tw=72

"" CTags
" default leader is \
" CTRL + ]
" :ts
" See also: grep -H -r 'what_you_search' * | less
let g:autotagTagsFile=".tags"
nmap <F8> :TagbarToggle<CR>
" To generate tags (if vim-autotags does not), call this from the ex line
" :!ctags
set tags=./.tags,.tags,.git/.tags

"folding settings (za to fold)
" set foldmethod=indent   "fold based on indent
set foldmethod=syntax
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

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
let g:airline#extensions#tabline#enabled = 0
let g:airline_powerline_fonts = 0
" let g:airline_theme='distinguished'

"" vim-go settings
let g:go_fmt_command = "goimports"

"" html tidy
:command Thtml :%!tidy -q -i -config ~/.html-tidy --show-errors 0
:command Txml  :%!tidy -q -i --show-errors 0 -xml

"" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

"" vim rooter - project root detection
let g:rooter_patterns = ['Rakefile', '.git/']

" Put this in your .vimrc and whenever you `git commit` you'll see the diff of your commit next to your commit message.
" For the most accurate diffs, use `git config --global commit.verbose true`

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

    " Paste into a new buffer
    vnew
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

" nginx config syntax
au BufRead,BufNewFile /etc/nginx/*,/usr/local/etc/nginx/conf/* if &ft == '' | setfiletype nginx | endif

" Quick Menu
" clear all the items
call quickmenu#reset()

" enable cursorline (L) and cmdline help (H)
let g:quickmenu_options = "LH"

" use your favorite key to show / hide quickmenu
noremap <silent><F12> :call quickmenu#toggle(0)


" new section: empty action with text starts with "#" represent a new section
call quickmenu#append("# Debug", '')

" script between %{ and } will be evaluated before menu open
call quickmenu#append("Run %{expand('%:t')}", '!./%', "Run current file")

" new section
call quickmenu#append("# Git", '')

" use fugitive to show diff
call quickmenu#append("git diff", 'Gvdiff', "use fugitive's Gvdiff on current document")
call quickmenu#append("git status", 'Gstatus', "use fugitive's Gstatus on current document")
call quickmenu#append("git blame", 'Gblame', "use fugitive's Gblame on current document")

" new section
call quickmenu#append("# Misc", '')
call quickmenu#append("Turn paste %{&paste? 'off':'on'}", "set paste!", "enable/disable paste mode (:set paste!)")
call quickmenu#append("Turn spell %{&spell? 'off':'on'}", "set spell!", "enable/disable spell check (:set spell!)")
" call quickmenu#append("Function List", "TagbarToggle", "Switch Tagbar on/off")
