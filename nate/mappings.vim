" -------------- Window and Tab Navigation --------------
" Textmate like mappings for tabs
" Cmd-Option-Left and Right
map <D-M-Left> :tabp<Enter>
imap <Ctrl-O><D-M-Left> :tabp<Enter>
map <D-M-Right> :tabn<Enter>
imap <Ctrl-O><D-M-Right> :tabn<Enter>

map <D-1> :tabn 1<CR>
map <D-2> :tabn 2<CR>
map <D-3> :tabn 3<CR>
map <D-4> :tabn 4<CR>
map <D-5> :tabn 5<CR>
map <D-6> :tabn 6<CR>
map <D-7> :tabn 7<CR>
map <D-8> :tabn 8<CR>
map <D-9> :tabn 9<CR>

map! <D-1> <C-O>:tabn 1<CR>
map! <D-2> <C-O>:tabn 2<CR>
map! <D-3> <C-O>:tabn 3<CR>
map! <D-4> <C-O>:tabn 4<CR>
map! <D-5> <C-O>:tabn 5<CR>
map! <D-6> <C-O>:tabn 6<CR>
map! <D-7> <C-O>:tabn 7<CR>
map! <D-8> <C-O>:tabn 8<CR>
map! <D-9> <C-O>:tabn 9<CR>

" Ctrl-Tab tab mappings
map <C-Tab> :tabn<CR>
map <C-S-Tab> :tabp<CR>

" Buffer Mappings
map <C-N> :bn<CR>
imap <C-O><C-N> :bn<CR>
map <C-P> :bp<CR>
imap <C-O><C-P> :bp<CR>



