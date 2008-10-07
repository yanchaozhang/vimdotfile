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
function! s:JumpOccurrence()
    let v:errmsg = ""
    exe "normal [I"
    if strlen(v:errmsg) == 0
	let nr = input("Which one: ")
	if nr =~ '\d\+'
	    exe "normal! " . nr . "[\t"
	endif
    endif
endfunction
nnoremap <Leader>j :call <SID>JumpOccurrence()<CR>

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
nnoremap <Leader>s :call <SID>JumpFind()<CR>

function! s:DisplayHelpfulShortcuts()
    echo "Hello World"
endfunction
nnoremap <Leader>dhs :call <SID>DisplayHelpfulShortcuts()<CR>
  
" Handles the stupid :bd versus :BD debate
" :BD uses the bufkill thingy, where it will keep the window
" open if there are other buffers in the dam window.
" Problem is that if I open a help file, and issue a :BD, then
" it tries to find the last used buffer, and I want to blast the help window.
function! s:BlastBuffer()
    if &filetype == 'help'
	:bd
    else
	:BD
    endif
endfunction
map <silent> <F4> :call <SID>BlastBuffer()<Enter>
