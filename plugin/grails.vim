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

" This function puts the current directory
" and all files underneath it into the path.
" This makes commands like 'gf' and friends able to open
" files with paths relative to the Grails projects' root directory
function! s:GrailsBufInit()
    let wildcardpath=getcwd() . "/**/"
    exec 'set path+=' . wildcardpath
endfunction

" Functions {{{1
" Opens a netrw window in the view directory
" pertain to the buffer where the cursor was when
" this function was called
function! s:GrailsDisplayViews()
    " Get the name of the current file we're on
    " TODO: Maybe we'll prompt someday
    let fileName = expand("%:t:r") 
    let fileName = substitute(fileName, "\\(ControllerTests\\|ServiceTests\\|Service\\|Controller\\|Tests\\)$", "", "g")
    let fileName =  tolower(fileName[0]) . strpart(fileName, 1)
    let viewsPath = "grails-app/views/" . fileName
    echo "Exploring viewsPath".viewsPath
    if finddir(viewsPath) != ""
        exe "Explore " . viewsPath
    else
        echo "Sorry, " . viewsPath . " is not found, you idiot."
    endif
endfunction

" Function: s:GrailsDisplayDomainClass
" Shows the domain class that pertains to the active buffer.
" Example:  FooController.groovy -> domain/Foo.groovy
function! s:GrailsDisplayDomainClass()
    " Get the name of the current file we're on
    " TODO: Maybe we'll prompt someday
    let fileName = expand("%:t:r") 
    let fileName = substitute(fileName, "\\(ControllerTests\\|ServiceTests\\|Service\\|Controller\\|Tests\\)$", "", "g")
    let fileName = fileName . ".groovy"
    
    let filePath = findfile(fileName)
    if filePath  != ""
        exe "e " . filePath
    else
        echo "Sorry, " . fileName . " is not found, you idiot."
    endif
endfunction

" Define Commands{{{1
noremap <unique> <script> <Plug>GrailsDisplayViews <SID>GrailsDisplayViews
noremap <SID>GrailsDisplayViews :call <SID>GrailsDisplayViews()<CR>

noremap <unique> <script> <Plug>GrailsDisplayDomainClass <SID>GrailsDisplayDomainClass
noremap <SID>GrailsDisplayDomainClass :call <SID>GrailsDisplayDomainClass()<CR>
" }}}1

" Mappings {{{1
if !hasmapto('<Plug>GrailsDisplayViews') 
    map <unique> <Leader>gv <Plug>GrailsDisplayViews
endif 
if !hasmapto('<Plug>GrailsDisplayDomainClass') 
    map <unique> <Leader>gd <Plug>GrailsDisplayDomainClass
endif 
" }}}1
" vim: set fdm=marker:
