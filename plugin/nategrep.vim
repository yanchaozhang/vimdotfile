" File: nategrep.vim
" --------------------- Do not modify after this line ---------------------
if exists("loaded_nategrep")
    finish
endif
let loadednate_grep = 1

" Line continuation used here
let s:cpo_save = &cpo
set cpo&vim

function! s:RunNateGrep(...)

    " No argument supplied. Get the identifier and file list from user
    let pattern = ""
    let argcnt = 1
    let moreargs = ""
    while argcnt <= a:0
        if pattern == ""
            let pattern = a:{argcnt}
        else
            let moreargs = moreargs . " " . a:{argcnt}
        endif
        let argcnt= argcnt + 1
    endwhile

    if pattern == "" 
        let pattern = input("Search for pattern: ", expand("<cword>"))
        if pattern == ""
            return
        endif
    endif

    let cwd = getcwd()
    let startdir = input("Start searching from directory: ", cwd, "dir")
    if startdir == ""
        return
    endif
    grep pattern . " " . moreargs . " " . startdir
endfunction


" Define the set of grep commands
command! -nargs=* -complete=file Nategrep
            \ call s:RunNateGrep(<f-args>)
" restore 'cpo'
let &cpo = s:cpo_save
unlet s:cpo_save

