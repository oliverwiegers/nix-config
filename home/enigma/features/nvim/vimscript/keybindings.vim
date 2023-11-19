"     __                                          _
"    / /_____  __  ______ ___  ____ _____  ____  (_)___  ____ ______
"   / //_/ _ \/ / / / __ `__ \/ __ `/ __ \/ __ \/ / __ \/ __ `/ ___/
"  / ,< /  __/ /_/ / / / / / / /_/ / /_/ / /_/ / / / / / /_/ (__  )
" /_/|_|\___/\__, /_/ /_/ /_/\__,_/ .___/ .___/_/_/ /_/\__, /____/
"           /____/               /_/   /_/            /____/

" Map leader key to space bar.
let mapleader = "\<Space>"

" A.L.E keybindings.
nnoremap <silent> <leader>an :ALENext<cr>
nnoremap <silent> <leader>ap :ALEPrevious<cr>

" GoTo file under cursor.
nnoremap <silent> gf <C-W>gf

" Save file as root.
cmap w!! w !sudo tee % >/dev/null

" Split navigation.
nnoremap <silent> <Leader>- :split<CR>
nnoremap <silent> <Leader>v :vsplit<CR>

" Tab navigation.
nnoremap <silent> <Leader>k :tabnext<CR>
nnoremap <silent> <Leader>j :tabprevious<CR>

" Spell checking for non code writing.
nnoremap <silent> <Leader>sp :setlocal spell! spelllang=en_us<CR>

" Mapping redo command to U.
nnoremap <silent> <S-u> :redo<CR>

" Reset search pattern.
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

" FZF commands.
nnoremap <tab><tab> :Rg<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader><space> :Files<CR>
nnoremap <leader>gc :Commits<CR>

" Open terminal in vsplit.
nnoremap <silent> <leader>t :term ++rows=20<CR>

" Open ranger in vsplit.
nnoremap <silent> <Leader>r :term ++rows=20 ++close ranger<CR>

"Open file under cursor even if not exists.
:noremap <leader>gf :tabnew <cfile><cr>
