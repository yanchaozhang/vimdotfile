" This file contains keyboard mappings for Vim
" Help file mappings are located in ~/.vim/ftplugin/help.vim
",v brings up my .vimrc
",V reloads it -- making all changes active (have to save first)
if has('win32')
    map <leader>v :e c:\njn\_vimrc<Enter>
    map <silent> <leader>V :source c:\njn\_vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
else
    map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
endif

" Use F5 to show a menu of buffers, and prompt for which one to
" switch to.
" From http://stripey.com/vim/keys.html 
" http://vim.sourceforge.net/tips/tip.php?tip_id=412
" map <F5> :buffers!<CR>:e #
" Use Enter key to insert a blank line at the cursor
" position
" nmap <Enter> O<Esc>

" Use Ctrl-H in both modes to Save file and go to Normal mode
nmap <C-H> :w<CR>
imap <C-H> <ESC>:w<CR>

" Use Ctrl-S in both modes to Save file and go to Normal mode
" This doesn't work due to Ctrl-S terminal crap
nmap <C-S> :w<CR>
imap <C-S> <ESC>:w<CR>

" Use D-W to kill the buffer, not the window of Vim
" Cmd key is D.  Cmd-W doesn't work in MacVim
" nmap <D-w> :bd
" imap <D-w> <ESC>:bd

" From http://stripey.com/vim/keys.html 
" In Lynx it is possible to scroll the window by a couple of lines, leaving the
" cursor at the same text, with <Ins>  and <Del>. (This choice of keys isn't as
" barmy as it first sounds after noticing how the <Ins>/<Del> pair are situated
" next to the <Home>/<End> and <PgUp>/<PgDn> pairs.) Normally these only
" duplicate i and x do, so can safely be remapped:
noremap <Ins> 2<C-Y>
noremap <Del> 2<C-E>

" Next buffer/previous buffer
nnoremap <C-N> :bn<CR>
nnoremap <C-P> :bp<CR>

" Tabs are already mapped to Ctrl-PgUp and Ctrl-PgDown
" Also, gt and gT switch to tabs
" This doesn't work in iTerm or gnome-terminal, but works
" in default terminal in OSX
imap <C-S-tab> :tabprevious<cr>
nmap <C-S-tab> :tabprevious<cr>
imap <C-tab> :tabnext<cr>
nmap <C-tab> :tabnext<cr>


" Use \f to format the file
" and return to the previous position before format
nnoremap <Leader>f gg=G``

" Use \cf to copy the filename of the current buffer into the clipboard
" Use this feature by entering \ff in normal mode (I guess that's
" what <Leader> means
if has('win32')
    nnoremap <Leader>cf :let @+=substitute(expand("%:p"), "/", "\\", "g")
else
    " Copy file/pathname, and echo it on line
    nnoremap <Leader>cf :let @+=expand("%:p") <Bar> :echo expand("%:p") . " was copied to clipboard."<CR>
endif
" insert43

" Insert date by pressing ",d"
" from http://www.vim.org/tips/tip.php?tip_id=97
map <silent> <F7> "=strftime("%Y/%m/%d")<Enter>P
map <silent> <S-F7> "=strftime("%Y/%m/%d %H:%M:%S")<Enter>P

" Use <Shift F1> to open :Ex (File browser)
" Doesn't work in terminal.
map <F1> :Ex<CR>
imap <F1> <ESC>:Ex<CR>

" Use F2 to show buffers
map <F2> <leader>be
imap <F2> <ESC><leader>be

" Map F3
nnoremap <silent> <F3> :FuzzyFinderFile<CR>
nnoremap <silent> <S-F3> :FuzzyFinderBuffer<CR>
nnoremap <silent> <C-F3> :FuzzyFinderMruFile<CR>

" Press Space to toggle search highlighting
" From http://vim.wikia.com/wiki/Highlight_all_search_pattern_matches
:noremap <silent> <Space> :silent nohlsearch<CR>

" Error/findings mappings
" Doesn't work in terminal
map <C-Down> :cn<cr>
map <C-Up> :cp<cr>

" Unmapped "dead-keys"
" Ctrl-J  Just goes down, like J
" <F7>, <F6>
" Insert date by pressing "," from http://www.vim.org/tips/tip.php?tip_id=97
" map :da "=strftime("%c")<Enter>P
" map F3 to Rmodel F4 to Rcontroller and F5 to Rview
" map <F3> <ESC>:Rmodel 
" map <F5> <ESC>:Rview 
" 1;5S
" Close buffer (doesn't work in terminal?)
" Is quirky on OSX
map <C-F4> :bd<CR>
imap <C-F4> <ESC>:bd<CR>

" F8 will open the explorer in a new tab
" Removed due to spaces in OSX
" map <F8> :Texplore %:h<CR>
" imap <F8> <ESC>:Texplore %:h<CR>

" map Enter to insert4 a blank line above the current line
" map <CR> O<ESC>

map <C-Right> gt
map <C-Left> gT
" Redirect \' to " current word with '
map <leader>' ciw''h<C-O>P<Esc>
" Redirect \" to surround current word with "
map <leader>" ciw""h<C-O>P<Esc>
" TODO: See 'surround.vim', which might work better
" Map F4 to buffer delete, synonymous with
" Windows' Alt-F4 and Ctrl-F4
map <F4> :bd<CR>
" Turn off search highlighting
map <leader><leader> :noh<CR>
