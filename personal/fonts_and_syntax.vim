" For additional font stuff, see ~/.vim/personal/gvimrc.local
" and ~/.vim/personal/vimrc.local
" Whenever a colorscheme is loaded, then run this function,
" to preserve sanity.
if !exists("sane_colors_autocommands_loaded")
    let sane_colors_autocommands_loaded = 1
    autocmd ColorScheme * call <SID>SaneColors()
endif

function! s:SaneColors()
    " echo "I'm adding my Sane Colors to this Colorscheme!"
    " Added by me to avoid headache when viewing folded code.
    " And Fuzzy Menus
    " hi link Folded  Normal
    " " Tame down cursorline
    " " Defaults in Gvim are obnoxious pink
    if exists("g:colors_name")
        if g:colors_name == "koehler"
            hi clear Pmenu
            hi link  Pmenu Normal
        elseif g:colors_name == "moria"
            hi clear Pmenu
            hi link  Pmenu Normal
            hi clear PmenuSel
            hi link  PmenuSel Visual
        elseif g:colors_name == "railscasts"
            hi clear Pmenu
            hi link  Pmenu Normal
        endif
    endif
    " hi CursorLine   guibg=#222222
    " hi Visual       gui=none guibg=#222222
    " hi PmenuSel     guibg=#3465a4 guifg=#ffffff
    " hi PmenuSbar    guibg=#444444 guifg=#444444
    " hi PmenuThumb   guibg=#888888 guifg=#888888 
endfunction
" Call SaneColors right now.
call <SID>SaneColors()

" Set font.  Use Monaco on OSX, and Courier on Linux/Windoze 
" These are my favorite settings for common stuff
" hi CursorLine guibg=#121212
" hi Visual guibg=#15171D
if has('mac')
    " set guifont=DejaVu\ Sans\ Mono:h15
    set guifont=Monaco:h14
    " set guifont=Bitstream\ Vera\ Sans\ Mono:h14
elseif has('gui_win32')
    set guifont=courier_new:h10 
elseif has('gui_gtk')
    " set guifont=Courier\ New\ 12
    set guifont=Bitstream\ Vera\ Sans\ Mono\ 11
    " set guifont=DejaVu\ Sans\ Mono\ 9
    " set guifont=ProFont\ 14
endif
