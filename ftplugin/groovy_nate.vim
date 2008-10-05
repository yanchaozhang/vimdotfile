if exists("b:did_groovy_raffaele_ftplugin") 
    finish 
endif
let b:did_groovy_raffaele_ftplugin = 1 
set errorformat=%.%#startup\ failed\\,\ %mline\ %l\\,\ column\ %c%.%#,%ACaught:\ %m,%Z%.%#at\ %.%#(%f:%l) 
" set makeprg to groovy, and give it $* to accept a parameter ('c' to make it
" compile, instead of run)
set makeprg=groovy$*\ % 
map    <buffer>  <silent>  <S-F5>        :w<BAR>:make c<CR>
imap   <buffer>  <silent>  <S-F5>   <C-C>:w<BAR>:make c<CR>
"
map    <buffer>  <silent>  <F5>         :w<BAR>:make<CR>
imap   <buffer>  <silent>  <F5>    <C-C>:w<BAR>:make<CR>

"Add standard lines to a new file 
if filereadable(expand("%")) == 0 
    call append(0, "#!/usr/bin/env groovy") 
endif 
set autoread 

