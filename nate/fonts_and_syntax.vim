colorscheme koehler

" Added by me to avoid headache when viewing folded code.
" And Fuzzy Menus
highlight Folded                    guifg=#E6E1DC   guibg=#000000
" Tame down cursorline
hi CursorLine   guibg=#121212
hi Visual       gui=none guibg=#222222
hi Pmenu        guibg=#000000 guifg=#c0c0c0
hi PmenuSel     guibg=#3465a4 guifg=#ffffff
hi PmenuSbar    guibg=#444444 guifg=#444444
hi PmenuThumb   guibg=#888888 guifg=#888888 
" Set font.  Use Monaco on OSX, and Courier on Linux/Windoze 
" These are my favorite settings for common stuff
" hi CursorLine guibg=#121212
" hi Visual guibg=#15171D
if has('mac')
	" set guifont=DejaVu\ Sans\ Mono:h14
	set guifont=Monaco:h14
	" set guifont=Bitstream\ Vera\ Sans\ Mono:h14
elseif has('gui_win32')
	set guifont=courier_new:h10 
elseif has('gui_gtk')
	" set guifont=Courier\ New\ 12
	set guifont=Bitstream\ Vera\ Sans\ Mono\ 12
endif
