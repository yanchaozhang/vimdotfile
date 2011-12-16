setlocal shiftwidth=4
if has("mac")
    nmap <buffer> <F5> :w<CR>:!open %<CR>
else
    nmap <buffer> <F5> :w<CR>:!firefox %<CR>
endif
