" This mappings file contains my functions & junk
" From http://vim.wikia.com/wiki/Capture_ex_command_output
" Pipes the output of an Ex command to a new tab
function! ReadEx(cmd)
    redir => message
    silent execute a:cmd
    redir END
    tabnew
    silent put=message
    set nomodified
endfunction
command! -nargs=+ -complete=command ReadEx call ReadEx(<q-args>)

" function s:GrepCurFile
" Prompts for search text, then lists occurrences
" in the :cope window for easy navigation
function! s:GrepCurFile()
    let v:errmsg = ""
    let text = input("Search for: ", expand("<cword>"))
    let curfile = resolve(expand("%:p"))
    if text != ""
        let cmd = 'Grep ' . text . ' ' . curfile
        exe cmd
    endif
endfunction

nnoremap <Leader>m :call <SID>GrepCurFile()<CR>

" Handles the stupid :bd versus :BD debate
" :BD uses the bufkill thingy, where it will keep the window
" open if there are other buffers in the dam window.
" Problem is that if I open a help file, and issue a :BD, then
" it tries to find the last used buffer, and I want to blast the help window.
function! s:BlastBuffer()
    if &filetype == 'help' || &filetype == 'netrw'
        " Just close it.
        :bw
    else
        " We're going to use :BD from BufKill plugin
        " Check for modifications
        if &modified
            let a:ret_val = confirm("Save changes?", "&Yes\n&No\n&Cancel")
            if a:ret_val == 1
                :w
            elseif a:ret_val == 3
                return
            endif
        endif
        :BW!
    endif
endfunction
map <silent> <leader>d :call <SID>BlastBuffer()<Enter>
imap <silent> <leader>d <C-O>:call <SID>BlastBuffer()<Enter>

function! s:CopyFileName()
    " Use <leader>cp to copy the file name (no directory -- for fullpath, see CopyFilePath below)
    " of the current buffer into the clipboard
    if has('win32')
        let @+=substitute(expand("%:p"), "/", "\\", "g")
        let @0=substitute(expand("%:p"), "/", "\\", "g")
    else
        " Copy file/pathname, and echo it on line
        let @+=expand("%:p:t")
        let @0=expand("%:p:t")
    endif
    echo expand("%:p:t") . " was copied to the system clipboard."

endfunction

nnoremap <unique> <leader>cf :call <SID>CopyFileName()<Enter>
nnoremap <unique> <leader>nf :call <SID>CopyFileName()<Enter>

function! s:CopyFilePath()
    " Use \cp to copy the filename of the current buffer into the clipboard
    " Use this feature by entering \ff in normal mode (I guess that's
    " what <Leader> means
    if has('win32')
        let @+=substitute(expand("%:p"), "/", "\\", "g")
        let @0=substitute(expand("%:p"), "/", "\\", "g")
    else
        " Copy file/pathname, and echo it on line
        let @+=expand("%:p")
        let @0=expand("%:p")
    endif
    echo expand("%:p") . " was copied to the system clipboard."

endfunction
nnoremap <unique> <leader>cp :call <SID>CopyFilePath()<Enter>

" Turn virtual edit on/off
function! s:ToggleVirtualEdit()
    if &virtualedit == 'all'
        " Un-let the setting
        set virtualedit=
        echo "Virtual edit turned off."
    else
        set virtualedit=all
        echo "Virtual edit setting is 'all'."
    endif
endfunction
map <F11> :call <SID>ToggleVirtualEdit()<CR>

" copied from /etc/vimrc that comes with Arch
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Define autocmd for using "template" files when creating a new file.
" Use the file's extension to see if there's a corresponding <extension>.tpl.
" If so, then read it into the new file.
function! s:LoadTemplate(extension)
    " Conjure template name
    let fileTemplate = $VIMHOME . '/templates/' . expand(a:extension) . '.tpl'
    " echo l:fileTemplate
    " If template exists, read it in.
    if filereadable(l:fileTemplate)
        silent! execute '0r ' . l:fileTemplate
        " Insert filename into <+filename+> placeholder
        silent! :%s/<+filename+>/\=expand("%:p:t")/g
    endif
endfunction

autocmd BufNewFile * call <SID>LoadTemplate('%:e')

" NextIndent()

" Jump to the next or previous line that has the same level or a lower

" level of indentation than the current line.
"
" exclusive (bool): true: Motion is exclusive
" false: Motion is inclusive
" fwd (bool): true: Go to next line
" false: Go to previous line
" lowerlevel (bool): true: Go to line with lower indentation level
" false: Go to line with the same indentation level
" skipblanks (bool): true: Skip blank lines
" false: Don't skip blank lines
function! NextIndent(exclusive, fwd, lowerlevel, skipblanks)
    let line = line('.')
    let column = col('.')
    let lastline = line('$')
    let indent = indent(line)
    let stepvalue = a:fwd ? 1 : -1
    while (line > 0 && line <= lastline)
        let line = line + stepvalue
        if ( ! a:lowerlevel && indent(line) == indent ||
                    \ a:lowerlevel && indent(line) < indent)
            if (! a:skipblanks || strlen(getline(line)) > 0)
                if (a:exclusive)
                    let line = line - stepvalue
                endif
                exe line
                exe "normal " column . "|"
                return
            endif
        endif
    endwhile
endfunc

" Moving back and forth between lines of same or lower indentation.
nnoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
nnoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
nnoremap <silent> [L :call NextIndent(0, 0, 1, 1)<CR>
nnoremap <silent> ]L :call NextIndent(0, 1, 1, 1)<CR>
vnoremap <silent> [l <Esc>:call NextIndent(0, 0, 0, 1)<CR>m'gv''
vnoremap <silent> ]l <Esc>:call NextIndent(0, 1, 0, 1)<CR>m'gv''
vnoremap <silent> [L <Esc>:call NextIndent(0, 0, 1, 1)<CR>m'gv''
vnoremap <silent> ]L <Esc>:call NextIndent(0, 1, 1, 1)<CR>m'gv''
onoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
onoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
onoremap <silent> [L :call NextIndent(1, 0, 1, 1)<CR>
onoremap <silent> ]L :call NextIndent(1, 1, 1, 1)<CR

function! s:ToggleCursorHighlight()
    " If we are showing the cursor now, then quit showing it.
    if (! exists('g:NJNShowingCursorLine')) 
        let g:NJNShowingCursorLine = 0
    endif
    if (g:NJNShowingCursorLine)
        augroup cursorHigh
            au!
            autocmd WinLeave * setlocal nocursorline
            autocmd WinEnter * setlocal nocursorline
            autocmd BufLeave * setlocal nocursorline
            autocmd BufEnter * setlocal nocursorline
        augroup END
        let g:NJNShowingCursorLine = 0
        setlocal nocursorline
    else
        augroup cursorHigh
            au!
            autocmd WinLeave * setlocal nocursorline
            autocmd WinEnter * setlocal cursorline
            autocmd BufLeave * setlocal nocursorline
            autocmd BufEnter * setlocal cursorline
        augroup END
        let g:NJNShowingCursorLine = 1
        setlocal cursorline
    endif
endfunction
map <leader>hc :call <SID>ToggleCursorHighlight()<CR>


function! s:MaximizeToggle()
    " Tell session not to store info about other tabs.
    " Just this one. Otherwise, Vim duplicates all tabs when you restore the
    " layout.
  set ssop-=tabpages
  if exists("s:maximize_session")
    exec "source " . s:maximize_session
    call delete(s:maximize_session)
    unlet s:maximize_session
    let &hidden=s:maximize_hidden_save
    unlet s:maximize_hidden_save
  else
    let s:maximize_hidden_save = &hidden
    let s:maximize_session = tempname()
    set hidden
    exec "mksession! " . s:maximize_session
    only
  endif
endfunction
noremap <C-W><C-O> :call <SID>MaximizeToggle()<CR>
" CAPITAL m
noremap <leader>M :call <SID>MaximizeToggle()<CR>

function! s:ToggleSaveOnFocusLost()
    if (! exists('g:NJNSaveOnFocusLost')) 
        let g:NJNSaveOnFocusLost = 0
    endif
    if (g:NJNSaveOnFocusLost)
        " Blast all FocusLost actions
        " Prolly not best way to do this
        au! FocusLost
        echo 'Disabled save on Focus Lost'
        let g:NJNSaveOnFocusLost = 0
    else
        au FocusLost * echo 'Autosaved file'|wall
        let g:NJNSaveOnFocusLost = 1
        echo 'Now Saving on Focus Lost'
    endif
endfunction
map <F6> :call <SID>ToggleSaveOnFocusLost()<CR>
imap <F6> <C-o>:call <SID>ToggleSaveOnFocusLost()<CR>

function! s:XMLTidy()
    let l:outFile = tempname() 
    let l:errFile = tempname() 

    let old_efm = &efm
    exe ":w"
    set errorformat=line\ %l\ column\ %v\ -\ %m
    
    let tidyCmd = "tidy -xml -indent -f " . l:errFile . " --indent-spaces 4 --wrap 90"
    cexpr system(tidyCmd . " -e " . expand("%"))
    if v:shell_error == 0
        " Run command again, and replace contents of file."
        exe "%!" .tidyCmd
    else 
        execute "silent! caddfile " . l:errFile
        botright copen
    endif


    let &efm = old_efm
endfunction
map <leader>xx :call <SID>XMLTidy()<CR>

" http://vim.wikia.com/wiki/Toggle_to_open_or_close_the_quickfix_window
function! s:QFixToggle()
  if exists("g:qfix_win")
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win = bufnr("$")
  endif
endfunction
nmap <silent> <F4> :call <SID>QFixToggle()<CR>

" Checks if current directory is $HOME or /, and cancels
" the fuzzy finder search -- which bring the computer to a halt
" due to directory size, etc.
function! s:SafeFuzzySearch()
    let curdir = getcwd()
    if curdir == $HOME || curdir == "/" || curdir =~ "/Documents$" || curdir == $BASE_HOME
        echo "You're in a big directory.  Aborting Fuzzy Search"
        return
    endif
    FufFile**/
endfunction

nmap <silent> <leader>t :call <SID>SafeFuzzySearch()<CR>


" Function GetFavoriteCommands()
" returns a list of all my favorite commands to run in Vim.
" For use w/FuzzyFinder's cool fuf#givencmd#launch which
" shows a menu of commands, then launches the command you pick
function s:GetFavoriteCommands()
    let favCommands = [ ]
    call insert(favCommands, ":bufdo :bw")       " Zap all buffers 
    call insert(favCommands, ":ReadEx :map")     " Show all mappings in a new buffer     
    call insert(favCommands, ":!git checkout -- %") " Revert current file               

    " redir => commands
    " silent command
    " redir END
    " return map((split(commands, "\n")[3:]),
                " \      '":" . matchstr(v:val, ''^....\zs\S*'')')
    return favCommands
endfunction

" execute one of the user-defined commands in GetFavoriteCommands
map <leader>nc :call fuf#givencmd#launch('', 0, 'Run Command>', <SID>GetFavoriteCommands())<CR>
map <leader>a :call fuf#givencmd#launch('', 0, 'Run Command>', <SID>GetFavoriteCommands())<CR>
