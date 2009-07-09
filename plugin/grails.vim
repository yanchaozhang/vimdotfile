" grails.vim - Detect a grails application
" Author:       Nathan Neff <nathan.neff@gmail.com>

" Install this file as plugin/grails.vim.
" Run :helptags ~/.vim/doc
" ============================================================================
" Exit quickly when:
" - this plugin was already loaded (or disabled)
" - when 'compatible' is set
if &cp || (exists("g:loaded_grails") && g:loaded_grails) 
  finish
endif
let g:loaded_grails = 1
" }}}1
" Detection {{{1
function! s:Detect()
    if finddir("grails-app", getcwd()) != ""
        call s:GrailsBufInit()
    endif
endfunction

" }}}1
" Initialization {{{1

" Detect whether this file is a Grails file.
" We only look @ the current directory, and try to find a grails-app
" directory.  Therefore, you must run vim from the root directory of a Grails
" app
augroup grailsPluginDetect
  autocmd!
  autocmd BufNewFile,BufRead * call s:Detect()
  autocmd VimEnter * call s:Detect() 
  " autocmd Syntax railslog if s:autoload()|call rails#log_syntax()|endif
augroup END

function! s:GrailsBufInit()
    let wildcardpath=getcwd() . "/**/"
    exec 'set path+=' . wildcardpath
endfunction
