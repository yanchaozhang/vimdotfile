" This file contains keyboard mappings for Vim
" Help file mappings are located in ~/.vim/ftplugin/help.vim
let mapleader = ","

" -------------- General Mappings ---------------
" Map the overwritten "," character to call itself, if I ever
" need it, I just press ,,
nnoremap <leader>, ,

",V (CAPITAL V) reloads vimrc
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" Insert line, then paste.  
" Accepts a register prefix like ["x]p and friends.
" Thanks to Andy Wokula on the Vim mailing list.
func! PasteNewLine()
    exec "pu " . v:register
endfunc

" Fix for the wayward cursor, with a simpler
" fix -- however, it's experimental.
" Remapping <Esc> messes with arrow keys in Vim
" inoremap <Esc> <Esc>`^
nn <Leader>p :call PasteNewLine()<CR>
nn <Leader>v "*P<CR>

" Map Y to act like C and D
map Y y$

" Toggle highlighting of found search terms on/off
" Mnemonic: (h)ighlight (s)earch
map <leader>hs :set hlsearch!<Enter>

map <Leader>nd :FufBookmarkDir<CR>

" Paste from outside vim
map <Leader>np "*,p<CR>

" Change current directory to this file's directory
map <Leader>nh :cd %:h<CR><Bar>:echo "Dir is now: " . getcwd()<CR>

" Buflisted hack
map <Leader>nl :set buflisted<CR>


" -------------- Tool Shortcuts (Opening Tools, etc) --------------
" Hexplore means to open it in the upper left new window
map <leader>e <ESC>:e %:p:h<CR>
map <leader>E <ESC>:e .<CR>

" Map ,f to be save.  Should help.
map <leader>f :w<CR>
" Shortcut to quit (like Mac)
map <leader>w :qa<CR>
" Try mapping ',f' to "save" even in insert mode.
imap <leader>f <ESC>:w<CR>

" Make script executable
map <leader>755 :! chmod 755 %<CR>

" Use F2 to show buffers
map <F2> :BufExplorer<CR>
imap <F2> <ESC>:BufExplorer<CR>

" NERD Tree
map <leader>nt :execute 'NERDTreeToggle ' . getcwd()<CR>

" Git mappings
" Git Gui (mnemonic - (n)ate (g)it gui
map <leader>ng :silent ! git gui &<CR>
map <leader>nk :silent ! gitk % &<CR>
map <F3> :silent ! git gui &<CR>
" Find rebase/merge conflicts
map <leader>nr /HEAD\\|>>>>\\|<<<</<CR>


" Favorite Bookmarks
map <F1> :FufBookmarkDir<CR>

" ============= Fuzzy Bindings ===========
" Map <leader>b to be the fuzzy version of BufExplorer
" Mnemonic: Fuzzy (B)uffer
map <leader>b :FufBuffer<CR>
map <leader>y :FufBuffer<CR>

" Renew cache in Fuzzy Finder -- use this when there's new files
" that fuzzy finder doesn't know about.
map <leader>q :FufRenewCache<CR>

" F7 = bookmark stuff
map <F7> :e ~/.bookmarks<CR>
map <S-F7> :!echo % >> ~/.bookmarks<CR><Bar>:echo "Saved " . expand("%") . " to bookmarks file, idiot."<CR>

" F8 Toggle menu bar
nnoremap <F8> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>

" Fuzzy's Most-recently used - just discovered
" MruFileInCwd -- this might narrow the list, and avoid opening
" same-named files from different directories.
map <leader>R :FufMruFile<CR>
map <leader>r :FufMruFileInCwd<CR>

nnoremap <Leader>s :call NjnSearch(getcwd(), 0, NjnGetParentAndGrandparentDir(getcwd()))<CR>
nnoremap <Leader>S :call NjnSearch(getcwd(), -1, NjnGetParentAndGrandparentDir(getcwd()))<CR>

" Recursive search in this file/buffer's current directory
" TODO: Create a function that checks for verboten directories such as "/" and
" "~" so that I don't have to kill the find processes.
nnoremap <Leader>. :call NjnSearch(expand('%:h:p'), 0, NjnGetParentAndGrandparentDir())<CR>
nnoremap <Leader>> :call NjnSearch(expand('%:h:p'), -1, NjnGetParentAndGrandparentDir())<CR>

" Search Notesmine directory
nnoremap <Leader>nm :call NjnSearch($NOTESMINE_DIR, 0)<CR>

" CD to this file's directry
nnoremap <Leader>cd :cd %:h<CR>

" Grails recursive find-in-files, defaulting to groovy, gsp files
nnoremap <Leader>gf :Rgrep PROMPT *.gsp\ *.groovy\ *.js\ *.css .<CR>

" Use F9 for running stuff
" See the related ftplugin files
"
" Use F10 for virtual edit
" See functions.vim

" See ftplugins

" Date / Time Mappings {{{2
" Insert date by pressing  (mnemonic: (I)nsert (D)ate)
" from http://www.vim.org/tips/tip.php?tip_id=97
map <silent> <leader>id "=strftime("%Y/%m/%d")<Enter>p

" Insert time (mnemonic: (I)nsert (T)ime)
map <silent> <leader>it "=strftime("%Y/%m/%d %H:%M:%S")<Enter>p
" }}}2

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

" Buffer Mappings
map <C-N> :bn<CR>
map <C-P> :bp<CR>
map <A-N> :bn<CR>
map <A-P> :bp<CR>

" Close buffer
" <leader>d is now mapped to BlastBuffer in ~/.vim/personal/functions.vim
" Insert Comment
map <leader>/ I// <ESC>
map <leader>cc <plug>NERDCommenterAlignLeft
map <leader>cl <plug>NERDCommenterAlignLeft
map <leader>cu <plug>NERDCommenterUncomment
map <leader>ci <plug>NERDCommenterToggle
map <leader>D :tabc<CR>

" Window Mappings {{{2
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

" Also use emacs-style '1' to make this window the only 1
map <leader>1 <C-W>o
map <leader>2 <C-W>s
map <leader>3 <C-W>v
" Close window shortcuts
map <leader>0 <C-W>c


" 'Maximize' Window -- nope, overwrites the <Enter> and <CR> func.
" map <C-M> :tabe %<CR>

" }}}
" Make / error list / search list mappings
" Quickfix  Mappings {{{2
" Go next/prev error/search result
map <C-Down> :cn<Enter>
map <C-Up> :cp<Enter>

" Go to next/previous SET of errors/search results
map <C-Right> :cnew<CR>
map <C-Left> :cold<CR>

" Go to error in next/prev file
map <C-S-Down> :cnf<Enter>
map <C-S-Up> :cpf<Enter>
" }}}

" Map the [[ and ]],etc to be able to actually
" jump to previous/next methods
map ]] ]m
map [[ [m
map ][ ]M
map [] [M

" Fold Shortcuts {{{1
map z0 :set foldlevel=0<CR>
map z1 :set foldlevel=1<CR>
map z2 :set foldlevel=2<CR>
" }}}

" Grr mappings
" Mappings that are hacks for bugs/annoying behavior
map <leader>nn :set buflisted<CR>

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
" ,xc = check XML (no overwrite)
" ,xf and ,xx = format XML (overwrite)
map <leader>xf :w!<CR>ggdG<BAR>:r!tidy -quiet -xml -indent --indent-spaces 4 --wrap 90 % <CR>ggdd:w!<CR>
" ,xx 
map <leader>xx :w!<CR>ggdG<BAR>:r!tidy -quiet -xml -indent --indent-spaces 4 --wrap 90 % <CR>ggdd:w!<CR>

" Cool "find in file" plugin
map <leader>cv <Plug>CompView

" map <leader>x :!tidy -xml -im --indent-spaces 4 --wrap 90 %<CR>
" Use Control+Return in Quickfix window to preview
map <C-Return> <CR><C-W>p

" Use CTRL-S for saving, also in Insert mode
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

" Execute current line in ex
map <Leader>ny 0y$:<C-R>"<CR>

map <leader>4 :tabe %<CR>
imap <leader>4 <C-O>:tabe %<CR>

" Presentation mode, use :hi clear to go back to
" normal fold highlighting
map <leader>np :hi Folded term=standout ctermfg=4 ctermbg=7 guifg=LightGrey guibg=bg<CR>

function! NjnBreakHtmlLine()
   exe "s/></></g"
endfunction
map <leader>nb call njnBreakHtmlLine()

" vim: fdm=marker
