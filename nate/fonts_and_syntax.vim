" Set font.  Use Monaco on OSX, and Courier on Linux/Windoze 
" These are my favorite settings for common stuff
" hi CursorLine guibg=#121212
" hi Visual guibg=#15171D
if has('mac')
	" set guifont=DejaVu\ Sans\ Mono:h14
	set guifont=Monaco:h14
	" set guifont=Bitstream\ Vera\ Sans\ Mono\ 18
elseif has('gui_win32')
	set guifont=courier_new:h10 
elseif has('gui_gtk')
	" set guifont=Courier\ New\ 12
	set guifont=Bitstream\ Vera\ Sans\ Mono\ 12
endif
