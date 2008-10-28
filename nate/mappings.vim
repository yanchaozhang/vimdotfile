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

" Map Shift-F1 to be the fuzzy version of Explorer
" As an example, if you want to launch file-mode Fuzzyfinder with the full
" path of current buffer's directory, map like below:
" The fancy modifiers tell the filename to reduce to homedir or current dir,
" if possible
map <S-F1> <C-r>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]<CR><CR>:FuzzyFinderFile<CR>
nnoremap <S-F1> <ESC> :FuzzyFinderFile <C-r>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]<CR><CR>

" Use F2 to show buffers
map <F2> <leader>be
imap <F2> <ESC><leader>be

" Map Shift-F2 to be the fuzzy version of BufExplorer
map <S-F2> :FuzzyFinderBuffer<CR>
imap <S-F2> <ESC>:FuzzyFinderBuffer<CR>

" Map F3 to be like "project explorer" in Textmate
" The ; is a shortcut to go to the directory that was defined
" when Vim was started.  See vimrc
map <F3> :FuzzyFinderFile;<CR>

" Tried this textmate version, but it sucks
" because it puts dispatch.fcgi ahead of foo_controller.rb when I type "fb"
" nnoremap <F3> :FuzzyFinderTextMate<CR>
" See functions.vim for mapping of C-F3, which changes
" the directory of the Fuzzy Finder's ";" shortcut

" Use F5 for running stuff
map <F5> :w<Bar>:!./%<CR>

" Use F6 for switching bufers
map <F6> :bn<CR>
map <S-F6> :bp<CR>

" Use F7 for favorite files, recent files, etc.
map <F7> :FuzzyFinderFavFile<CR>
map <S-F7> :FuzzyFinderMruFile<CR>

" Use F9 for running stuff
" See the related ftplugin files
"
" Use F10 for virtual edit
" virtual edit is useful when selecting columns
map <F10> :set virtualedit!<CR>

" See ftplugins
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

" Map the [[ and ]],etc to be able to actually
" jump to previous/next methods
map ]] ]m
map ][ ]M
map [[ [m
map [] [M
