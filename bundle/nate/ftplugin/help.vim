  " Place this file in $VIMHOME/ftplugin/help.vim directory so that
  " vim uses this file for help file mappings only
nmap <buffer> <BS> <C-T>
nmap <buffer> <CR> <C-]>
  " Go to next option link using o, previous option link using O
nmap <buffer> o /'[a-z]\{2,\}'<CR>
nmap <buffer> O ?'[a-z]\{2,\}'<CR>
  " Go to next subject using s, previous subject using S
nmap <buffer> s /\|\S\+\|<CR>
nmap <buffer> S ?\|\S\+\|<CR>
