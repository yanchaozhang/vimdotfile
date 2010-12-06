" Do this once (without the quote at the start of the line):
" :map ,zz :call Zoom()<CR>

" To use this function, highlight some text, then press ,zz
function! Zoom()
    let curft=&ft
    exe "'<,'> y"
    exe "enew"
    exe "normal p"
    exe "set ft=" . l:curft
endfunction
