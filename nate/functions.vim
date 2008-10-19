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
	let nr = input("Which one: ")
	if nr =~ '\d\+'
	    exe "normal! " . nr . "[\t"
	endif
    endif
endfunction
nnoremap <Leader>j :call <SID>JumpOccurrence()<CR>
nnoremap <Leader>8 :call <SID>JumpOccurrence()<CR>
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
nnoremap <Leader>s :call <SID>JumpFind()<CR>
" use / mapping, kinda like regular / command
nnoremap <Leader>/ :call <SID>JumpFind()<CR>

function! s:DisplayHelpfulShortcuts()
    e ~/.vim/README.TXT
    /shortcuts<CR>
endfunction
nnoremap <Leader>dhs :call <SID>DisplayHelpfulShortcuts()<CR>
  
" Handles the stupid :bd versus :BD debate
" :BD uses the bufkill thingy, where it will keep the window
" open if there are other buffers in the dam window.
" Problem is that if I open a help file, and issue a :BD, then
" it tries to find the last used buffer, and I want to blast the help window.
function! s:BlastBuffer()
    if &filetype == 'help' || &filetype == 'netrw'
	" Just close it.
	:bd
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
	:BD!
    endif
endfunction
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
