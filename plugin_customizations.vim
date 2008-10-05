" This file contains junk that I use to customize the various 
" plugins that are around for Vim.
" ----------------------- Miscellaneous -----------------------
" Show Rails menu in main menu
" let g:rails_menu=1


" For grep.vim, if on OSX, then tell xargs not to use the default option
" of --null.  Instead, use -0 (OSX)

" Previously used has("mac"), except this doesn't work in 
" a terminal, and fubars the grep.vim plugin
" if has("mac") 
let s:os = system("uname")
if s:os =~ "Darwin"
    let g:Grep_Xargs_Options='-0'
endif

" For grep.vim, tell it to ignore .svn directories and log files
:let Grep_Skip_Dirs = '.svn log vendor' 

" For Perl, use :make to "compile" the program
autocmd FileType perl set makeprg=perl\ -c\ %\ $*
autocmd FileType perl set errorformat=%f:%l:%m

" For rails.vim, map the alternate and related files to something easier
" to type
" Note: This should be done in a rails-specific file in the ftplugin dir
" noremap <leader>a <ESC>:A<CR>
" noremap <leader>r <ESC>:R<CR>
map <leader>c :Rcontroller 
"------------------------------- Mini-Buf Settings --------------------
" Mini-buf no longer used 2008/09/17 
" Mini-buf explorer customizations
" let g:miniBufExplModSelTarget = 1
" Use C Tab and CS Tab to switch buffers
" let g:miniBufExplMaxSize = 2
" let g:miniBufExplMapCTabSwitchBufs = 1
" let g:miniBufExplorerMoreThanOne = 0
" let g:miniBufExplModSelTarget = 0
" let g:miniBufExplUseSingleClick = 1
" let g:miniBufExplMapWindowNavVim = 1
" let g:miniBufExplSplitBelow=0

"------------------------------- Fuzzy Finder File Settings --------------------
" It's recommended in fuzzyfinder.vim to initialize these settings,
" so you can customize fuzzy finder.
" stores user-defined g:FuzzyFinderOptions ------------------------------ 
" Initializes g:FuzzyFinderOptions.
let g:FuzzyFinderOptions = { 'Base':{}, 'Buffer':{}, 'File':{}, 'Dir':{}, 'MruFile':{}, 'MruCmd':{}, 'FavFile':{}, 'Tag':{}, 'TaggedFile':{}}
" I thought I would have to change the default mapping to <CR>, but I doubt
" it?
" let g:FuzzyFinderOptions.Base.key_open = '<S-F2>'
let user_options = (exists('g:FuzzyFinderOptions') ? g:FuzzyFinderOptions : {})

" ------- Finally, customize Fuzzy Finder  ------------------------------
" This tells fuzzy finder that if I type a ';' at the start of a search
" then it will search in the current directory and all subdirectories
" I previously defaulted it to this, but it would hang if I opened Vim
" in the root directory or my directory with tons of files.
let user_options.Base.abbrev_map  = {
            \   "^;" : [
            \    getcwd() . '/**/'
            \   ],
            \ } 
" 
" nnoremap <silent> <F4> :FuzzyFinderFile <C-r>=expand('%:p:.')[:-1-len(expand('%:~:.:t'))]<CR><CR>
" Set menu to only display 10 things, otherwise, it's annoying
let g:FuzzyFinderOptions.File.matching_limit = 10

"------------------------------- Buffer Explorer Settings --------------------
" Buffer explorer should not show hidden.
" I changed my mind 2008/09/17
" Instead, use 'u' in Buffer Explorer to show unlisted buffers
let g:bufExplorerShowUnlisted=0      " Show unlisted buffers.

" ----------------------- Obsolete / No longer Used -----------
" ----------------------- Project Plugin ----------------------
" Project plugin no longer used 2008/09/17
" Open file in new window when I select it
" from the project menu. And use <F12> to bring up
" let g:proj_flags="imstg"

" ----------------------- Lookupfile Plugin -----------------------
" For lookupfile plugin, use the current directory/filenametags
" for filenames.  This means you need to start vim from the same dir
" as the filenametags file :(
" let g:LookupFile_TagExpr = string('./filenametags')


