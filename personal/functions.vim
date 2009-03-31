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

" List occurrences of keyword under cursor, and
" jump to selected occurrence.
" Like the * and gd commands, except it lists the occurrences
function! s:JumpOccurrence()
    let v:errmsg = ""
    exe "normal [I"
    if strlen(v:errmsg) == 0
        let nr = input("Jump to Occurrence (Enter to Cancel): ")
        if nr =~ '\d\+'
            exe "normal! " . nr . "[\t"
        endif
    endif
endfunction
nnoremap <Leader>* :call <SID>JumpOccurrence()<CR>

" I added this one!  Whee!
" Prompts for search text, then lists occurrences, and prompts for line number
function! s:JumpFind()
    let v:errmsg = ""
    let text = input("Search for:")
    exe "g/" . text . "/#"
    if strlen(v:errmsg) == 0
        let nr = input("Enter line number, or ESC:")
        if nr =~ '\d\+'
            exe "normal! " . nr . "G"
            exe "normal! z."
        endif
    endif
endfunction
nnoremap <Leader>f :call <SID>JumpFind()<CR>

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
map <silent> <F4> :call <SID>BlastBuffer()<Enter>
imap <silent> <F4> <C-O>:call <SID>BlastBuffer()<Enter>

function! s:CopyFilePath()
    " Use \cf to copy the filename of the current buffer into the clipboard
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
nnoremap <leader>cf :call <SID>CopyFilePath()<Enter>


function! s:ChangeFuzzyDir()
    let g:fuzzy_root = getcwd()
    FuzzyFinderRemoveCache
endfun
nnoremap <leader>ncd :call <SID>ChangeFuzzyDir()<CR>
nnoremap <C-F3>ncd :call <SID>ChangeFuzzyDir()<CR>

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
map <F10> :call <SID>ToggleVirtualEdit()<CR>

" copied from /etc/vimrc that comes with Arch
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" What's Changed ("wc")
nnoremap <leader>wc <ESC>:DiffOrig<Enter>

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

nnoremap <C-W>O :call <SID>MaximizeToggle ()<CR>
nnoremap <C-W>o :call <SID>MaximizeToggle ()<CR>
nnoremap <C-W><C-O> :call <SID>MaximizeToggle ()<CR>

function! s:MaximizeToggle()
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

