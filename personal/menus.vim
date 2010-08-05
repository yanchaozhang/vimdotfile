" Zap current "Nate" menu, if there is one
silent! nmenu Nate
silent! vmenu Nate
" Create a var for the home directory of Vim
let s:vimPersonal = split(&rtp, ',')[0] . '/personal'
exe "nmenu Nate.Favorites.functions\\.vim :e " . s:vimPersonal . "/functions.vim<Enter>"
exe "nmenu Nate.Favorites.mappings\\.vim :e " . s:vimPersonal . "/mappings.vim<Enter>"
exe "nmenu Nate.Favorites.menus\\.vim :e " . s:vimPersonal . "/menus.vim<Enter>"
exe "nmenu Nate.Favorites.vimrc :e " . s:vimPersonal . "/vimrc<Enter>"
exe "nmenu Nate.Favorites.vim\\ directory :e " . s:vimPersonal . "<Enter>"
nmenu Nate.Find.List\ Occurrences<Tab><leader>s <leader>s
nmenu Nate.Find.Word\ Under\ Cursor<Tab><leader>j <leader>j
nmenu Nate.Format\ File<Tab><leader>f <leader>f
nmenu Nate.Format.Remove\ Trailing\ Spaces :%s/\s\+//gc<CR>
nmenu Nate.Fuzzy.Change\ Dir<Tab><leader>ncd <leader>ncd<CR>
nmenu Nate.Fuzzy.Edit\ Favorites :FuzzyFindeEditInfo<CR>
nmenu Nate.Fuzzy.Recent\ Files<Tab><leader>r :FuzzyFinderMruFile<CR>
nmenu Nate.Fuzzy.Reload :FuzzyFinderRenewCache<CR>
nmenu Nate.Groovy.Help<Tab><leader>gsh <leader>gsh
nmenu Nate.Groovy.Run<Tab><F5> <F5>
nmenu Nate.HTML\ Tidy<Tab><leader>t :call ReadEx("!tidy -xml --indent-spaces 4 -im %")<CR>
nmenu Nate.Insert.Date<Tab><F7> <F7>
nmenu Nate.Insert.Datetime<Tab><S-F7> <S-F7>
nmenu Nate.List.Changes<Tab>:changes :changes<CR>
nmenu Nate.List.Jumps<Tab>jumps :jumps<CR>
nmenu Nate.Recent\ Files<Tab><F7> :FuzzyFinderMruFile<CR>
nmenu Nate.functions<Tab><leader>nf :e ~/.vim/nate/functions.vim<Enter>
vmenu Nate.Insert.Line\ Numbers :s/^/\=line(".")." "/ <CR>


