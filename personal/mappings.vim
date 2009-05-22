" This file contains keyboard mappings for Vim
" Help file mappings are located in ~/.vim/ftplugin/help.vim
let mapleader = ","

" -------------- General Mappings ---------------
" Map the overwritten "," character to call itself, if I ever
" need it, I just press ,,
nnoremap <leader>, ,
map <leader>q <ESC>:qa<CR>
" Close window
map <leader>w <C-W>c

",V (CAPITAL V) reloads vimrc
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
" ,v opens personal Vim stuff directory
map <silent> <leader>v :e $VIMHOME/personal<CR>

" Toggle highlighting of found search terms on/off
" Use Control-Space because a bunch of other things use Space
map <C-Space> :set hlsearch!<Enter>
" Mnemonic: (h)ighlight (s)earch
map <leader>hs :set hlsearch!<Enter>
" -------------- Folding ----------------
map <F3> :set foldenable! <BAR> echo "Folding is now: " . &foldenable<CR>
" -------------- Tool Shortcuts (Opening Tools, etc) --------------
" Hexplore means to open it in the upper left new window
map <leader>e :Explore!<CR>
" Map ,s to be save.  Should help.
map <leader>s :w<CR>
" Try mapping ',s' to "save" even in insert mode.
imap <leader>s <ESC>:w<CR>

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
" Map <leader>m to "maximize" current window to another tab
" See also MaximizeToggle in functions.vim
map <leader>m <C-W>o
" 'Maximize' Window -- nope, overwrites the <Enter> and <CR> func.
" map <C-M> :tabe %<CR>

" Tried this textmate version, but it sucks
" because it puts dispatch.fcgi ahead of foo_controller.rb when I type "fb"
" nnoremap <F3> :FuzzyFinderTextMate<CR>
" See functions.vim for mapping of C-F3, which changes
" the directory of the Fuzzy Finder's ";" shortcut

" Use F5 for running stuff.
map <F5> :! %:p<CR>

map <A-Left> :bp<CR>
map <A-Right> :bn<CR>

" Use F7 for bookmark files
map <F7> :FuzzyFinderBookmark<CR>
map <S-F7> :FuzzyFinderAddBookmark<CR>

" Fuzzy's Most-recently used
map <leader>r :FuzzyFinderMruFile<CR>
" Recursive find-in-files (Think "f"ind in "f"iles)
nnoremap <Leader>fr :Rgrep 

" <leader>o will search in the current directory.
" mnemonic - Like "Open", which usually defaults to current dir.
nnoremap <leader>o :FuzzyFinderFile <C-r>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]<CR><CR>

" Use F9 for running stuff
" See the related ftplugin files
"
" Use F10 for virtual edit
" See functions.vim

" See ftplugins
" Insert date by pressing <leader>nd Mnemonic: Think "N"ow
" 
" from http://www.vim.org/tips/tip.php?tip_id=97
map <silent> <leader>nd "=strftime("%Y/%m/%d")<Enter>p

" Insert date plus weekday by pressing <leader>nw
map <silent> <leader>nw "=strftime("%Y/%m/%d -- %A")<Enter>p

" Insert time by pressing <leader>nt
map <silent> <leader>nt "=strftime("%Y/%m/%d %H:%M:%S")<Enter>p

" -------------- Window and Tab Navigation --------------
" Textmate like mappings for tabs
" Cmd-Option-Left and Right
map <D-M-Left> :tabp<Enter>
imap <Ctrl-O><D-M-Left> :tabp<Enter>
map <D-M-Right> :tabn<Enter>
imap <Ctrl-O><D-M-Right> :tabn<Enter>

" Map Cmd-1, etc. to go to same-numbered tab
" Doesn't work if you have Expose mapped to Cmd+1, Cmd+2, etc.
map <D-1> :tabn 1<CR>
map <D-2> :tabn 2<CR>
map <D-3> :tabn 3<CR>
map <D-4> :tabn 4<CR>
map <D-5> :tabn 5<CR>
map <D-6> :tabn 6<CR>
map <D-7> :tabn 7<CR>
map <D-8> :tabn 8<CR>
map <D-9> :BufExplore<CR>
map! <D-1> <C-O>:tabn 1<CR>
map! <D-2> <C-O>:tabn 2<CR>
map! <D-3> <C-O>:tabn 3<CR>
map! <D-4> <C-O>:tabn 4<CR>
map! <D-5> <C-O>:tabn 5<CR>
map! <D-6> <C-O>:tabn 6<CR>
map! <D-7> <C-O>:tabn 7<CR>
map! <D-8> <C-O>:tabn 8<CR>
map! <D-9> <C-O>:tabn 9<CR>
map <D-9> <C-O>:BufExplore<CR>

" Ctrl-Tab mappings
" Changing to next tab, previous tab
" I don't use buffer previous, buffer next that much.
" If I use it, then I use C-N, C-P
map <C-Tab> :tabn<CR>
map <C-S-Tab> :tabp<CR>

map <C-Right> :tabn<CR>
map <C-Left> :tabp<CR>

" Buffer Mappings
map <C-N> :bn<CR>
map <C-P> :bp<CR>
map <A-N> :bn<CR>
map <A-P> :bp<CR>

" Close buffer
" <leader>d is now mapped to BlastBuffer in ~/.vim/personal/functions.vim
" Insert Comment
map <leader>/ I// <ESC>

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
map ]] ]M
map ][ ]m
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
" end of line
:cnoremap <C-E> <End>
" XML Tidy commands
" ,xc = check (no overwrite)
map <leader>xc :!tidy -errors -xml -indent --indent-spaces 2 --wrap 90 %<CR>
map <leader>xc! :w!<CR>ggdG<BAR>:r!tidy -quiet -xml -indent --indent-spaces 2 --wrap 90 %<CR>ggdd:w!
" ,xo = check + overwrite file w/more stuff

map <leader>g <Plug>CompView

" map <leader>x :!tidy -xml -im --indent-spaces 4 --wrap 90 %<CR>
" ----------------- BufKill Mappings ----------------
" Used mainly so the plugin doesn't override <leader>b mapping
if !hasmapto('<Plug>BufKillBun')
  nmap <silent> <unique> <Leader>Bun <Plug>BufKillBun
endif
if !hasmapto('<Plug>BufKillBunBang')
  nmap <silent> <unique> <Leader>!Bun <Plug>BufKillBunBang
endif
if !hasmapto('<Plug>BufKillBd')
  nmap <silent> <unique> <Leader>Bd  <Plug>BufKillBd
endif
if !hasmapto('<Plug>BufKillBdBang')
  nmap <silent> <unique> <Leader>!Bd  <Plug>BufKillBdBang
endif
if !hasmapto('<Plug>BufKillBw')
  nmap <silent> <unique> <Leader>Bw  <Plug>BufKillBw
endif
if !hasmapto('<Plug>BufKillBwBang')
  nmap <silent> <unique> <Leader>!Bw  <Plug>BufKillBwBang
endif
if !hasmapto('<Plug>BufKillBundo')
  nmap <silent> <unique> <Leader>Bundo  <Plug>BufKillBundo
endif

