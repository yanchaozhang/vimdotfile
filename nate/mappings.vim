" This file contains keyboard mappings for Vim
" Help file mappings are located in ~/.vim/ftplugin/help.vim

" -------------- General Mappings ---------------
",v brings up my .vimrc
",V reloads it -- making all changes active (have to save first)
if has('win32')
    map <leader>v :e c:\njn\_vimrc<Enter>
    map <silent> <leader>V :source c:\njn\_vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
else
    map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
endif

" Toggle highlighting of found search terms on/off
" Use Control-Space because a bunch of other things use Space
map <C-Space> :set hlsearch!<Enter>
" -------------- Tool Shortcuts (Opening Tools, etc) --------------
" Use <F1> to open :Ex (File browser)
" Hexplore means to open it in the upper left new window
map <F1> :Hexplore!<CR>
imap <F1> <C-O>:Hexplore!<CR>

" Use F2 to show buffers
map <F2> <leader>be
imap <F2> <ESC><leader>be

map <S-F2> :FuzzyFinderBuffer<CR>
imap <S-F2> :FuzzyFinderBuffer<CR>

" Use F5 for running stuff
map <F5> :w<Bar>:!./%<CR>
" Use F7 for favorite files, recent files, etc.
map <F7> :FuzzyFinderFavFile<CR>
map <S-F7> :FuzzyFinderMruFile<CR>

" Insert date by pressing <leader>nd
" from http://www.vim.org/tips/tip.php?tip_id=97
map <silent> <leader>nd "=strftime("%Y/%m/%d")<Enter>gP
" Insert time by pressing <leader>nt
map <silent> <leader>nt "=strftime("%Y/%m/%d %H:%M:%S")<Enter>gP

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
map <C-Right> :tabn<CR>
map <C-Left> :tabp<CR>

" Buffer Mappings
map <C-N> :bn<CR>
map <C-P> :bp<CR>

map <F4> :bd<CR>
imap <F4> <C-O>:bd<CR>

" Window Mappings
" Window up/down are same as up/down in Vim
map <C-J> <C-W>j
map <C-K> <C-W>k

" Make / error list / search list
" mappings
map <C-Down> :cn<Enter>
map <C-Up> :cp<Enter>
