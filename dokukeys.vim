" From http://wiki.splitbrain.org/wiki:tips:vimkeys
" Maps alt-1 through alt-6 for headings
" in both visual and insert mode.
" FIXME:  Why not in regular mode, on a certain line, also?
imap <a-1> =======  =======<esc>7hi
vmap <a-2> "zdi====== <c-r>z ======
imap <a-2> ======  ======<esc>6hi
vmap <a-3> "zdi===== <c-r>z =====
imap <a-3> =====  =====<esc>5hi
vmap <a-4> "zdi==== <c-r>z ====
imap <a-4> ====  ====<esc>4hi
vmap <a-5> "zdi=== <c-r>z ===
imap <a-5> ===  ===<esc>3hi
vmap <a-6> "zdi== <c-r>z ==
imap <a-6> ==  ==<esc>3hi
