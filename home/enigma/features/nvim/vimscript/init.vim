"#########################################################
"#        _    __   ____   __  ___   ____     ______     #
"#       | |  / /  /  _/  /  |/  /  / __ \   / ____/     #
"#       | | / /   / /   / /|_/ /  / /_/ /  / /          #
"#     _ | |/ /  _/ /   / /  / /  / _, _/  / /___        #
"#    (_)|___/  /___/  /_/  /_/  /_/ |_|   \____/        #
"#                                                       #
"#########################################################

" Load local vimrc.
set exrc secure
set modeline
set modelines=5

"               __  __  _
"    ________  / /_/ /_(_)___  ____ ______
"   / ___/ _ \/ __/ __/ / __ \/ __ `/ ___/
"  (__  )  __/ /_/ /_/ / / / / /_/ (__  )
" /____/\___/\__/\__/_/_/ /_/\__, /____/
"                           /____/

" General settings.
set splitbelow
set splitright
set copyindent
set autoindent
set smartindent

" Give more space for displaying messages.
set cmdheight=2

" Switch buffers without saving.
set hidden

" Set encoding.
set encoding=utf-8
scriptencoding utf-8

" Show linenumbers and current line relative.
set relativenumber number

" Highlight search results.
set hlsearch

" Start searching by substring.
set incsearch

" Expand tabs to spaces
set expandtab

" Use zsh as vim shell.
set shell=zsh

" Make Ctrl-a and Ctrl-x working with Base-10 numbers.
set nrformats-=octal

" Spellchecking.
set complete+=d,kspell

" Enable persistent undo. Or in other words: Being able to undo changes even if
" the file was closed.
set undodir=~/.vim/undodir
set undofile
set undolevels=1000
set undoreload=10000

" Set cursorline.
set cursorline

" Set cursorcolumn.
set cursorcolumn
