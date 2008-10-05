" Zap current "Helpful" menu, if there is one
" nmenu   Helpful.Copy\ Filename 
" nmenu Helpful.Show\ Menu :menu Helpful<CR>
" Un-rem the unmenu thingys when you're working on the menu
" nunmenu <silent> Helpful
" vunmenu <silent> Helpful
nmenu &Bookmarks.mappings<Tab><leader>ma :e ~/.vim/mappings.vim<Enter>
nmenu &Bookmarks.menus<Tab><leader>me :e ~/.vim/menus.vim<Enter>
nmenu &Bookmarks.customizations<Tab><leader>p :e ~/.vim/plugin_customizations.vim<Enter>
nmenu &Bookmarks.vimrc<Tab><leader>v :e ~/.vim/vimrc.vim<Enter>
nmenu Helpful.Find.List\ Occurrences<Tab><leader>s <leader>s
nmenu Helpful.Find.Word\ Under\ Cursor<Tab><leader>j <leader>j
nmenu Helpful.Groovy.Help<Tab><leader>gsh <leader>gsh
nmenu Helpful.Groovy.Run<Tab><F5> <F5>
nmenu Helpful.Insert.Date<Tab><F7> <F7>
nmenu Helpful.Insert.Datetime<Tab><S-F7> <S-F7>
vmenu Helpful.Insert.Line\ Numbers :s/^/\=line(".")." "/ <CR>
nmenu Helpful.List.Changes<Tab>:changes :changes<CR>
nmenu Helpful.List.Jumps<Tab>jumps :jumps<CR>
nmenu Helpful.Copy\ File\ Path<Tab>cf <leader>cf
nmenu Helpful.Format\ File<Tab><leader>f <leader>f
nmenu Helpful.HTML\ Tidy<Tab><leader>t :call ReadEx("!tidy -xml --indent-spaces 4 -im %")<CR>
