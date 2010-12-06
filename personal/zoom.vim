" To use this function in your own vim:
" 1) Type the following (without the quote in the front, and press Enter
"    so %
" 2) Highlight some text
" 3) Type the following (without the quote, and remove the stupid `<,`>)
"    :call Zoom()
function! Zoom()
    let curft=&ft
    exe "'<,'> y"
    exe "enew"
    exe "normal p"
    exe "set ft=" . l:curft
endfunction

" TODO keyboard shortcut to call this function
