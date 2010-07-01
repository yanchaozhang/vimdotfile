" Run 'dot' program on this file, and output to filename.png (minus file
" suffix)
let runcmd = ":! dot -Tpng " . expand("%:p") . " > " . expand("%:p:r") . ".png<CR><CR>"

exe "nmap <buffer> <F5>  " . runcmd

