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
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'mileszs/ack.vim'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-bundler'
Plugin 'derekwyatt/vim-scala'
Plugin 'kballard/vim-swift'
Plugin 'elixir-lang/vim-elixir'
Plugin 'fatih/vim-go'
Plugin 'rust-lang/rust.vim'
Plugin 'plasticboy/vim-markdown'
Plugin 'junegunn/gv.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'danro/rename.vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'bling/vim-bufferline'
Plugin 'jiangmiao/auto-pairs'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-surround'

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
set number
color blackboard
" colorscheme 1989
highlight ColorColumn ctermbg=235 guibg=#2c2d27
let &colorcolumn="80,".join(range(120,999),",")
set cursorline
set showmode
" set title
set showcmd
autocmd BufNewFile,BufRead *.json set ft=javascript
set autochdir

"" CTags
" default leader is \
" CTRL + ]
" :ts
" See also: grep -H -r 'what_you_search' * | less
map<Leader>rt :!ctags --tag-relative --extra=+f -Rf.git/tags --exclude=.git,pkg --languages=-javascript,sql<CR><CR>
set tags+=.git/tags

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
