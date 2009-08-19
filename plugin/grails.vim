" grails.vim - Detect a grails application
" Author:       Nathan Neff <nathan.neff@gmail.com>

" Install this file as plugin/grails.vim.
" Run :helptags ~/.vim/doc
" ============================================================================
" Initialization {{{1
" Exit quickly when:
" - this plugin was already loaded (or disabled)
" - when 'compatible' is set
if &cp || (exists("g:loaded_grails") && g:loaded_grails) 
  finish
endif
let g:loaded_grails = 1
function! s:Detect()
    if finddir("grails-app", getcwd()) != ""
        call s:GrailsBufInit()
    endif
endfunction


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

" Exported Functions {{{1
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
    let currentItem = s:GrailsGetCurrentItem() . ".groovy"
    call s:GrailsOpenItem(currentItem)
endfunction

" Function: s:GrailsDisplayController
" Shows the controller that pertains to the active buffer.
" Example:  FooController.groovy -> domain/Foo.groovy
function! s:GrailsDisplayController()
    " Get the name of the current file we're on
    " TODO: Maybe we'll prompt someday
    let currentItem = s:GrailsGetCurrentItem() . "Controller.groovy"
    call s:GrailsOpenItem(currentItem)
endfunction

" Function: s:GrailsDisplayService
" Shows the service that pertains to the active buffer.
" Example:  Foo.groovy -> FooService.groovy
function! s:GrailsDisplayService()
    " Get the name of the current file we're on
    " TODO: Maybe we'll prompt someday
    let currentItem = s:GrailsGetCurrentItem() . "Service.groovy"
    call s:GrailsOpenItem(currentItem)
endfunction

" Function: s:GrailsDisplayTests
" Shows the tests that pertain to active buffer
" Example:  Foo.groovy -> FooTests.groovy
" TODO: What if there's unit, and integration tests?
function! s:GrailsDisplayTests()
    " Get the name of the current file we're on
    " TODO: Maybe we'll prompt someday
    let currentItem =  expand("%:t:r")
    let currentItem = substitute(currentItem, "Tests$", "", "")
    let currentItem = currentItem . "Tests.groovy"
    echo "Opening item: " . currentItem
    call s:GrailsOpenItem(currentItem)
endfunction

" Function: s:GrailsDisplayTestReports
" Shows the plain-text tests that pertain to a particular file
" Example:  Foo.groovy -> test/reports/plain/TEST-FooTests.txt
" TODO: What if there's unit, and integration tests?
function! s:GrailsDisplayTestReports()
    " Get the name of the current file we're on
    " TODO: Maybe we'll prompt someday
    let currentItem =  expand("%:t:r")
    let testGlob = substitute(currentItem, "Tests$", "", "") . "Tests.txt"
    let testGlob =  "TEST-*" . testGlob
    " Use glob path to try to find the file.
    let foundItem = globpath(getcwd() . "/test/reports/plain/**", testGlob)
    if foundItem == ""
        echo "Sorry, test report file: " . testGlob . " was not found :-("
    else
        call s:GrailsOpenItem(foundItem, "grails/test/reports/plain")
    endif

endfunction
" }}}1
" Utility functions{{{1
" Function: s:GrailsGetCurrentItem()
" Utility method to detect what grails 'item' we're in now.
" (Domain Class, Controller, Service, View).
" Returns the name of the thing we're in (e.g. 'Song', 'Whatever')
function! s:GrailsGetCurrentItem()
    let extension = expand("%:e") 
    let fileNameOnly = expand("%:t") 
    let fileNameBase = expand("%:t:r")
    
    if extension == "gsp"
        " We're in a view.  Get the current thing by looking @ the parent dir.
        let currentItem = expand("%:p:h:t")
        " Capitalize
        let currentItem = toupper(currentItem[0]) . strpart(currentItem, 1)
    else
        let currentItem = substitute(fileNameBase, "\\(ControllerTests\\|ServiceTests\\|Service\\|Controller\\|Tests\\)$", "", "")
        " If we're in a TEST-FooTests.txt file, then return Foo
        let currentItem = substitute(currentItem, "^.*TEST-", "", "")
        let currentItem = substitute(currentItem, ".*\\.", "", "")
    endif
    
    return currentItem
endfunction

function! s:GrailsOpenItem(thisItem, ...)
    if a:0 > 0
        let startPath = a:1
    else
        let startPath = getcwd()
    endif
    let filePath = findfile(a:thisItem, startPath . "/**")
    if filePath  != ""
        exe "e " . filePath
        return 1
    else
        echo "Sorry, " . a:thisItem . " is not found, you idiot."
        return 0
    endif
endfunction
"}}}1
" Define Commands{{{1
noremap <unique> <script> <Plug>GrailsDisplayViews <SID>GrailsDisplayViews
noremap <SID>GrailsDisplayViews :call <SID>GrailsDisplayViews()<CR>

noremap <unique> <script> <Plug>GrailsDisplayDomainClass <SID>GrailsDisplayDomainClass
noremap <SID>GrailsDisplayDomainClass :call <SID>GrailsDisplayDomainClass()<CR>

noremap <unique> <script> <Plug>GrailsDisplayController <SID>GrailsDisplayController
noremap <SID>GrailsDisplayController :call <SID>GrailsDisplayController()<CR>

noremap <unique> <script> <Plug>GrailsDisplayService <SID>GrailsDisplayService
noremap <SID>GrailsDisplayService :call <SID>GrailsDisplayService()<CR>

noremap <unique> <script> <Plug>GrailsDisplayTests <SID>GrailsDisplayTests
noremap <SID>GrailsDisplayTests :call <SID>GrailsDisplayTests()<CR>

noremap <unique> <script> <Plug>GrailsDisplayTestReports <SID>GrailsDisplayTestReports
noremap <SID>GrailsDisplayTestReports :call <SID>GrailsDisplayTestReports()<CR>
" }}}1
" Mappings {{{1
if !hasmapto('<Plug>GrailsDisplayViews') 
    map <unique> <Leader>gv <Plug>GrailsDisplayViews
endif 

if !hasmapto('<Plug>GrailsDisplayDomainClass') 
    map <unique> <Leader>gd <Plug>GrailsDisplayDomainClass
endif 

if !hasmapto('<Plug>GrailsDisplayController') 
    map <unique> <Leader>gc <Plug>GrailsDisplayController
endif 

if !hasmapto('<Plug>GrailsDisplayService') 
    map <unique> <Leader>gs <Plug>GrailsDisplayService
endif 

if !hasmapto('<Plug>GrailsDisplayTest') 
    map <unique> <Leader>gt <Plug>GrailsDisplayTests
endif 

if !hasmapto('<Plug>GrailsDisplayTestReports') 
    map <unique> <Leader>gr <Plug>GrailsDisplayTestReports
endif 
" }}}1
" vim: set fdm=marker:
