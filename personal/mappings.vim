" This file contains keyboard mappings for Vim
" Help file mappings are located in ~/.vim/ftplugin/help.vim
let mapleader = ","

" -------------- General Mappings ---------------
" Map the overwritten "," character to call itself, if I ever
" need it, I just press ,,
nnoremap <leader>, ,
map <leader>q <ESC>:qa<CR>
",v reloads vimrc
if has('win32')
    map <silent> <leader>v :source c:\njn\_vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
else
    map <silent> <leader>v :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
endif

" Toggle highlighting of found search terms on/off
" Use Control-Space because a bunch of other things use Space
map <C-Space> :set hlsearch!<Enter>
" Mnemonic: (h)ighlight (s)earch
map <leader>hs :set hlsearch!<Enter>

" Mnemonic: (h)ighlight (c)ursorline
map <S-Space> :set cursorline!<Enter>
map <leader>hc :set cursorline!<Enter>

" -------------- Tool Shortcuts (Opening Tools, etc) --------------
" Use <F1> to open :Ex (File browser)
" Hexplore means to open it in the upper left new window
map <F1> :Explore!<CR>
map <leader>e :Explore!<CR>
" Map ,s to be save.  Should help.
map <leader>s :w<CR>
" Try mapping ',s' to "save" even in insert mode.
imap <leader>s <ESC>:w<CR>
imap <F1> <C-O>:Explore!<CR>

" Make script executable
map <leader>755 :! chmod 755 %<CR>

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
map <silent> <C-F2> :if &guioptions =~# 'm' <Bar>
                        \set guioptions-=m <Bar>
                    \else <Bar>
                        \set guioptions+=m <Bar>
                    \endif<CR>

" NERD Tree
map <leader>a :execute 'NERDTreeToggle ' . getcwd()<CR>

" Map <leader>bu to be the fuzzy version of BufExplorer
" Mnemonic: Fu(zz)y
map <leader>z :FuzzyFinderBuffer<CR>

" Map <leader>t to be like "project explorer" in Textmate
map <leader>t :FuzzyFinderFile\*\*/<CR>

" Tried this textmate version, but it sucks
" because it puts dispatch.fcgi ahead of foo_controller.rb when I type "fb"
" nnoremap <F3> :FuzzyFinderTextMate<CR>
" See functions.vim for mapping of C-F3, which changes
" the directory of the Fuzzy Finder's ";" shortcut

" Use F5 for running stuff.
map <F5> :! %<CR>

" Use F6 for switching buffers
map <F6> :bn<CR>
map <S-F6> :bp<CR>
map <A-Left> :bp<CR>
map <A-Right> :bn<CR>

" Use ,bm ,ba for bookmark files
map <F7> :FuzzyFinderBookmark<CR>
map <S-F7> :FuzzyFinderAddBookmark<CR>

" Fuzzy's "refresh" method.
map <leader>bc :FuzzyFinderRemoveCache<CR>
map <leader>r :FuzzyFinderMruFile<CR>

" <leader>o will search in the current buffer.
" mnemonic - Like "Open", which usually defaults to current dir.
nnoremap <leader>o :FuzzyFinderFile <C-r>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]<CR><CR>

" Use F9 for running stuff
" See the related ftplugin files
"
" Use F10 for virtual edit
" See functions.vim

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

" Ctrl-Tab mappings
" Don't use tabs much in Vim
map <C-Tab> :bn<CR>
map <C-S-Tab> :bp<CR>

map <C-Right> :bn<CR>
map <C-Left> :bp<CR>

" Buffer Mappings
map <C-N> :bn<CR>
map <C-P> :bp<CR>
map <A-N> :bn<CR>
map <A-P> :bp<CR>

" Close buffer
map <F4> :bd<CR>
imap <F4> <C-O>:bd<CR>
" map <leader>d :bd<CR>
" <leader>d is now mapped to BlastBuffer in ~/.vim/nate/functions.vim

" Window Mappings
" Window up/down are same as up/down in Vim
map <C-J> <C-W>j
map <C-K> <C-W>k

" Window left/right are same as left/right in Vim
map <C-H> <C-W>h
map <C-L> <C-W>l

" Try using semicolon for window movements
" map ;j <C-W>j
" map ;k <C-W>k

" Window left/right are same as left/right in Vim
" map ;h <C-W>h
" map ;l <C-W>l

" Make / error list / search list mappings
" Go next/prev error
map <C-Down> :cn<Enter>
map <C-Up> :cp<Enter>
" Go to error in next/prev file
map <C-S-Down> :cnf<Enter>
map <C-S-Up> :cpf<Enter>

" Map the [[ and ]],etc to be able to actually
" jump to previous/next methods
map ]] ]m
map ][ ]M
map [[ [m
map [] [M

" -------------- Experimental --------------
" Get rid of useless '' and 'a, 'e, wich take you to the start of the line
" that you were at, instead of the exact place where you were just at
" http://www.vim.org/htmldoc/tips.html
:map ' `

" For Emacs-style editing on the command-line
" start of line
:cnoremap <C-A> <Home>
" back one character
:cnoremap <C-B> <Left>
" delete character under cursor
:cnoremap <C-D> <Del>
" end of line
:cnoremap <C-E> <End>
" forward one character

