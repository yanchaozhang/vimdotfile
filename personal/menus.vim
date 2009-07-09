" Zap current "CrazyNate" menu, if there is one
silent! nmenu CrazyNate
silent! vmenu CrazyNate
" Create a var for the home directory of Vim
let s:vimPersonal = $VIMHOME ? $VIMHOME : "~/.vim" . "/personal"
nmenu CrazyNate.Copy\ File\ Path<Tab>cf <leader>cf
exe "nmenu CrazyNate.Favorites.functions\\.vim :e " . s:vimPersonal . "/functions.vim<Enter>"
exe "nmenu CrazyNate.Favorites.mappings\\.vim :e " . s:vimPersonal . "/mappings.vim<Enter>"
exe "nmenu CrazyNate.Favorites.menus\\.vim :e " . s:vimPersonal . "/menus.vim<Enter>"
exe "nmenu CrazyNate.Favorites.vimrc :e " . s:vimPersonal . "/vimrc<Enter>"
exe "nmenu CrazyNate.Favorites.vim\\ directory :e " . s:vimPersonal . "<Enter>"
nmenu CrazyNate.Find.List\ Occurrences<Tab><leader>s <leader>s
nmenu CrazyNate.Find.Word\ Under\ Cursor<Tab><leader>j <leader>j
nmenu CrazyNate.Format\ File<Tab><leader>f <leader>f
nmenu CrazyNate.Format.Remove\ Trailing\ Spaces :%s/\s\+//gc<CR>
nmenu CrazyNate.Fuzzy.Change\ Dir<Tab><leader>ncd <leader>ncd<CR>
nmenu CrazyNate.Fuzzy.Edit\ Favorites :FuzzyFinderEditInfo<CR>
nmenu CrazyNate.Fuzzy.Recent\ Files<Tab><leader>r :FuzzyFinderMruFile<CR>
nmenu CrazyNate.Fuzzy.Reload :FuzzyFinderRenewCache<CR>
nmenu CrazyNate.Groovy.Help<Tab><leader>gsh <leader>gsh
nmenu CrazyNate.Groovy.Run<Tab><F5> <F5>
nmenu CrazyNate.HTML\ Tidy<Tab><leader>t :call ReadEx("!tidy -xml --indent-spaces 4 -im %")<CR>
nmenu CrazyNate.Insert.Date<Tab><F7> <F7>
nmenu CrazyNate.Insert.Datetime<Tab><S-F7> <S-F7>
nmenu CrazyNate.List.Changes<Tab>:changes :changes<CR>
nmenu CrazyNate.List.Jumps<Tab>jumps :jumps<CR>
nmenu CrazyNate.Recent\ Files<Tab><F7> :FuzzyFinderMruFile<CR>
nmenu CrazyNate.functions<Tab><leader>nf :e ~/.vim/nate/functions.vim<Enter>
vmenu CrazyNate.Insert.Line\ Numbers :s/^/\=line(".")." "/ <CR>


