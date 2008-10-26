" Vimball Archiver by Charles E. Campbell, Jr., Ph.D.
UseVimball
finish
doc/tselectfiles.txt	[[[1
126
*tselectfiles.txt*  A simplicistic files selector/browser (sort of)
                    Author: Thomas Link, micathom at gmail com


This plugin provides a simple file browser. It is not a full blown 
explorer but can be nevertheless be useful for quickly selecting a few 
files or renaming them.

As the plugin does some caching in the background, the filelist is only 
generated once for each path or when called with [!]. In conjuncture 
with the use of the [wbg]:tselectfile_filter_rx variable, this provides 
for use as a simple ad-hoc project manager.

EXAMPLE:
When opening a file under "~/vimfiles", I set b:tselectfiles_dir 
to all the relevant directories under "~/vimfiles" and then set 
b:tselectfile_filter_rx = expand('%:t:r'). Thus, when I open 
"~/vimfiles/plugin/foo.vim", b:tselectfile_filter_rx is "foo", and 
:TSelectFiles shows all the files under "~/vimfiles" matching "foo".

Features:
    - list files, dynamically select files matching a pattern
    - open files
    - preview files
    - rename/move files
    - batch rename/move files (using a regular expression)
    - copy files
    - delete files
    - show file info


-----------------------------------------------------------------------
Install~

Edit the vba file and type: >

    :so %

See :help vimball for details. If you have difficulties, please make 
sure, you have the current version of vimball (vimscript #1502) 
installed.

This script requires tlib (vimscript #1863) to be installed.

Suggested maps (to be set in ~/.vimrc): >
    noremap <m-f>       :TSelectFiles<cr>


========================================================================
Contents~

    plugin/tselectfiles.vim
        g:tselectfiles_use_cache ............ |g:tselectfiles_use_cache|
        g:tselectfiles_no_cache_rx .......... |g:tselectfiles_no_cache_rx|
        g:tselectfiles_filter_rx ............ |g:tselectfiles_filter_rx|
        g:tselectfiles_limit ................ |g:tselectfiles_limit|
        g:tselectfiles_filedescription_rx ... |g:tselectfiles_filedescription_rx|
        g:tselectfiles_world ................ |g:tselectfiles_world|
        g:tselectfiles_suffixes ............. |g:tselectfiles_suffixes|
        g:tselectfiles_hidden_rx ............ |g:tselectfiles_hidden_rx|
        g:tselectfiles_show_quickfix_list ... |g:tselectfiles_show_quickfix_list|
        :TSelectFiles ....................... |:TSelectFiles|
        :TSelectFilesInSubdirs .............. |:TSelectFilesInSubdirs|


========================================================================
plugin/tselectfiles.vim~

                                                    *g:tselectfiles_use_cache*
g:tselectfiles_use_cache       (default: 1)
    Whether to cache directory listings (in memory). (per buffer, global)
    If 0, disable the use of cached file listings all together.

                                                    *g:tselectfiles_no_cache_rx*
g:tselectfiles_no_cache_rx     (default: '')
    Don't use the cache for directories matching this rx. (per buffer, 
    global)

                                                    *g:tselectfiles_filter_rx*
g:tselectfiles_filter_rx       (default: '')
    Retain only files matching this rx. (per window, per buffer, global)

                                                    *g:tselectfiles_limit*
g:tselectfiles_limit           (default: 0)
    The max depth when globbing directories recursively. 0 = no limit.

                                                    *g:tselectfiles_filedescription_rx*
g:tselectfiles_filedescription_rx (default: {})
    A dictionary of REGEXP => FUNCREF(filename) -> String describing the 
    file (DEFAULT: the filename).

                                                    *g:tselectfiles_world*
g:tselectfiles_world           (default: {)

                                                    *g:tselectfiles_suffixes*
g:tselectfiles_suffixes        (default: printf('\(%s\)\$', join(map(split(&suffixes, ','), 'v:val'), '\|')))

                                                    *g:tselectfiles_hidden_rx*
g:tselectfiles_hidden_rx       (default: '\V\(/.\|/CVS\|/.attic\|.svn\|'. g:tselectfiles_suffixes .'\)\(\[\\/]\|\$\)')

                                                    *g:tselectfiles_show_quickfix_list*
g:tselectfiles_show_quickfix_list (default: 'TRagcw')
    " TBD: cwindow doesn't currently work as expected
    TLet g:tselectfiles_show_quickfix_list = exists(':TRagcw') ? 'TRagcw' : 'cwindow'
    The command that is run to show the quickfix list after running grep.

                                                    *:TSelectFiles*
:TSelectFiles[!] [DIR]
    Open/delete/rename files in the current directory.
    A [!] forces the commands to rescan the directory. Otherwise a cached 
    value will be used if available.
    You can also type <c-r> to force rescanning a directory, which could 
    be necessary if the file system were changed (e.g. by creating a new 
    file or by some external command)

                                                    *:TSelectFilesInSubdirs*
:TSelectFilesInSubdirs
    Recursively show all files in the current directory and subdirectories 
    (don't show favourites and ".."); don't use this command when you're 
    at /.
    A [!] forces the commands to rescan the directory. Otherwise a cached 
    value will be used if available.



vim:tw=78:fo=tcq2:isk=!-~,^*,^|,^":ts=8:ft=help:norl:
plugin/tselectfiles.vim	[[[1
181
" tselectfile.vim -- A simplicistic files selector/browser (sort of)
" @Author:      Thomas Link (micathom AT gmail com?subject=[vim])
" @Website:     http://www.vim.org/account/profile.php?user_id=4037
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Created:     2007-04-16.
" @Last Change: 2008-10-01.
" @Revision:    522
" GetLatestVimScripts: 1865 1 tselectfiles.vim

if &cp || exists("loaded_tselectfile")
    finish
endif
if !exists('loaded_tlib') || loaded_tlib < 18
    echoerr "tlib >= 0.18 is required"
    finish
endif
let loaded_tselectfile = 6

" Whether to cache directory listings (in memory). (per buffer, global)
" If 0, disable the use of cached file listings all together.
TLet g:tselectfiles_use_cache = 1

" Don't use the cache for directories matching this rx. (per buffer, 
" global)
TLet g:tselectfiles_no_cache_rx = ''

" Retain only files matching this rx. (per window, per buffer, global)
TLet g:tselectfiles_filter_rx = ''

" The max depth when globbing directories recursively. 0 = no limit.
TLet g:tselectfiles_limit = 0

" A dictionary of REGEXP => FUNCREF(filename) -> String describing the 
" file (DEFAULT: the filename).
TLet g:tselectfiles_filedescription_rx = {}

" Use these dirs (a comma separated list, see |globpath()|). (per window, per buffer, global)
" TLet g:tselectfiles_dir = ''

TLet g:tselectfiles_world = {
            \ 'type': 'm',
            \ 'query': 'Select files',
            \ 'scratch': '__ttoc__',
            \ 'return_agent': 'tselectfiles#ViewFile',
            \ 'display_format': 'tselectfiles#FormatEntry(world, %s)',
            \ 'pick_last_item': 0,
            \ 'key_handlers': [
                \ {'key':  4,  'agent': 'tselectfiles#AgentDeleteFile',      'key_name': '<c-d>', 'help': 'Delete file(s)'},
                \ {'key': 18,  'agent': 'tselectfiles#AgentReset'},
                \ {'key': 19,  'agent': 'tlib#agent#EditFileInSplit',        'key_name': '<c-s>', 'help': 'Edit files (split)'},
                \ {'key': 22,  'agent': 'tlib#agent#EditFileInVSplit',       'key_name': '<c-v>', 'help': 'Edit files (vertical split)'},
                \ {'key': 20,  'agent': 'tlib#agent#EditFileInTab',          'key_name': '<c-t>', 'help': 'Edit files (new tab)'},
                \ {'key': 23,  'agent': 'tselectfiles#ViewFile',             'key_name': '<c-w>', 'help': 'View file in window'},
                \ {'key': 21,  'agent': 'tselectfiles#AgentRenameFile',      'key_name': '<c-u>', 'help': 'Rename file(s)'},
                \ {'key': 3,   'agent': 'tlib#agent#CopyItems',              'key_name': '<c-c>', 'help': 'Copy file name(s)'},
                \ {'key': 11,  'agent': 'tselectfiles#AgentCopyFile',        'key_name': '<c-k>', 'help': 'Copy file(s)'},
                \ {'key': 16,  'agent': 'tselectfiles#AgentPreviewFile',     'key_name': '<c-p>', 'help': 'Preview file'},
                \ {'key':  2,  'agent': 'tselectfiles#AgentBatchRenameFile', 'key_name': '<c-b>', 'help': 'Batch rename file(s)'},
                \ {'key': 126, 'agent': 'tselectfiles#AgentSelectBackups',   'key_name': '~',     'help': 'Select backup(s)'},
                \ {'key': 9,   'agent': 'tlib#agent#ShowInfo',               'key_name': '<c-i>', 'help': 'Show info'},
                \ {'key': 24,  'agent': 'tselectfiles#AgentHide',            'key_name': '<c-x>', 'help': 'Hide some files'},
                \ {'key':  7,  'agent': 'tselectfiles#Grep',                 'key_name': '<c-g>', 'help': 'Run vimgrep on selected files'},
                \ {'key': 28,  'agent': 'tlib#agent#ToggleStickyList',       'key_name': '<c-\>', 'help': 'Toggle sticky'},
            \ ],
            \ }
            " \ 'scratch_vertical': (&lines > &co),
                \ ]

TLet g:tselectfiles_suffixes = printf('\(%s\)\$', join(map(split(&suffixes, ','), 'v:val'), '\|'))

TLet g:tselectfiles_hidden_rx = '\V\(/.\|/CVS\|/.attic\|.svn\|'. g:tselectfiles_suffixes .'\)\(\[\\/]\|\$\)'

" " TBD: cwindow doesn't currently work as expected
" TLet g:tselectfiles_show_quickfix_list = exists(':TRagcw') ? 'TRagcw' : 'cwindow'
if exists(':TRagcw')
    " The command that is run to show the quickfix list after running grep.
    TLet g:tselectfiles_show_quickfix_list = 'TRagcw'
endif

" TLet g:tselectfiles_dir_edit = 'TSelectFiles'
" 
" if !empty(g:tselectfiles_dir_edit)
"     if exists('g:loaded_netrwPlugin')
"         au! FileExplorer BufEnter
"     endif
"     augroup TSelectFiles
"         autocmd!
"         autocmd BufEnter * silent! if isdirectory(expand("<amatch>")) | exec g:tselectfiles_dir_edit .' '. expand("<amatch>") | endif
"     augroup END
" endif


if !exists('g:tselectfiles_favourites')
    if has('win16') || has('win32') || has('win64')
        let g:tselectfiles_favourites = ['c:/', 'd:/']
    else
        let g:tselectfiles_favourites = []
    endif
    if !empty($HOME)
        call add(g:tselectfiles_favourites, $HOME)
    endif
    if !empty($USERPROFILE)
        call add(g:tselectfiles_favourites, $USERPROFILE)
        " call add(g:tselectfiles_favourites, $USERPROFILE .'/desktop/')
    endif
endif


" :display: :TSelectFiles[!] [DIR]
" Open/delete/rename files in the current directory.
" A [!] forces the commands to rescan the directory. Otherwise a cached 
" value will be used if available.
" You can also type <c-r> to force rescanning a directory, which could 
" be necessary if the file system were changed (e.g. by creating a new 
" file or by some external command)
command! -bang -nargs=? -complete=dir TSelectFiles call tselectfiles#SelectFiles("normal<bang>".v:count, <q-args>)

" Recursively show all files in the current directory and subdirectories 
" (don't show favourites and ".."); don't use this command when you're 
" at /.
" A [!] forces the commands to rescan the directory. Otherwise a cached 
" value will be used if available.
command! -bang -nargs=? -complete=dir TSelectFilesInSubdirs call tselectfiles#SelectFiles("recursive<bang>".v:count, <q-args>)


finish

CHANGES:
0.1
Initial release

0.2
- Copy files
- Renamed TSelectFiles! to TSelectFilesInSubdirs
- Cache file listings (reset by adding a ! to the command or by typing 
<c-r> in the list view)
- g:tselectfiles_use_cache, g:tselectfiles_no_cache: Control the use of 
cached file listings
- If no start argument is provided, the starting directory can also be 
defined via b:tselectfiles_dir and g:tselectfiles_dir (use "." to use 
the current directory); this could be used to quickly select 
project-related files
- Key shortcuts to open files in (vertically) split windows or tabs
- <c-c> now is "Copy file names", <c-k> is "Copy files"

0.3
- Require tlib 0.9
- "Delete file" will ask whether to delete a corresponding buffer too.

0.4
- <c-w> ... View file in original window
- Disabled <c-o> Open dir
- Require tlib >= 0.12
- When renaming a file that's loaded, rename also the buffer.
- You can filter the list of selected files via setting the 
[wbg]:tselectfiles_filter_rx variable.
- Renamed g:tselectfiles_no_cache to g:tselectfiles_no_cache_rx
- [bg]:tselectfiles_use_cache and [bg]:tselectfiles_no_cache_rx can now 
also be set per buffer.
- Renamed some variables from tselectfile_* to tselectfiles_*.
- Can be "suspended" (i.e. you can switch back to the orignal window)

0.5
- [wbg]:tselectfiles_filter_rx is used only when no directory is given 
on the command line.
- Require tlib >= 0.18
- If the filename matches an entry in g:tselectfiles_filedescription_rx, 
use the expression there to construct a file description (eg the file's 
first line)
- Option to run vimgrep on selected files.
- tselectfiles#BaseFilter(): Set b:tselectfiles_filter_rx to something 
useful.
- tselectfiles#BaseFilter(): takes 2 optional arguments to substitute a 
rx in the current buffer's filename.

0.6
- tselectfiles_filter_rx: Set as array
- [gbw]tselectfiles_prefix: Remove prefix from filenames in list
- [gbw]tselectfiles_limit variable
- Problem when browsing single directories

autoload/tselectfiles.vim	[[[1
457
" tselectfiles.vim
" @Author:      Thomas Link (mailto:micathom AT gmail com?subject=[vim])
" @Website:     http://www.vim.org/account/profile.php?user_id=4037
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Created:     2007-10-15.
" @Last Change: 2008-10-03.
" @Revision:    0.0.179

if &cp || exists("loaded_tselectfiles_autoload")
    finish
endif
let loaded_tselectfiles_autoload = 1


let s:select_files_files = {}


function! s:CacheID() "{{{3
    return s:select_files_dir . string(s:select_files_pattern)
endf


function! s:PrepareSelectFiles(hide)
    " TLogVAR a:hide
    " let filter = s:select_files_dir . s:select_files_pattern.pattern
    " TLogVAR filter
    let rv = []
    for pattern in s:select_files_pattern.pattern
        let rv += split(globpath(s:select_files_dir, pattern), '\n')
    endfor
    " TLogVAR rv
    if a:hide
        call filter(rv, 'v:val !~ g:tselectfiles_hidden_rx')
    endif
    " call TLogDBG(string(s:select_files_pattern))
    if s:select_files_pattern.mode == 'r'
        if s:select_files_pattern.limit == 0
            call sort(filter(rv, '!isdirectory(v:val)'))
        else
            call sort(map(rv, 'isdirectory(v:val) ? tlib#dir#CanonicName(v:val) : v:val'))
            if !empty(get(s:select_files_pattern, 'predecessor', ''))
                " call TLogDBG(get(s:select_files_pattern, 'predecessor'))
                call insert(rv, tlib#dir#CanonicName(s:select_files_pattern.predecessor))
            endif
        endif
    else
        call sort(map(rv, 'isdirectory(v:val) ? v:val."/" : v:val'))
        let rv += g:tselectfiles_favourites
        " TLogVAR rv
        " call TLogDBG(string(split(s:select_files_dir, '[^\\]\zs,')))
        for phf in split(s:select_files_dir, '[^\\]\zs,')
            let ph = tlib#dir#CanonicName(fnamemodify(tlib#dir#PlainName(phf), ':h'))
            " TLogVAR ph, phf
            " call TLogDBG(s:select_files_dir)
            if ph != tlib#dir#CanonicName(phf)
                " TLogVAR ph, phf
                " call insert(rv, ph .'../')
                call insert(rv, ph)
            endif
        endfor
    endif
    return rv
endf


function! s:UseCache() "{{{3
    let use_cache = tlib#var#Get('tselectfiles_use_cache', 'bg')
    let no_cache  = tlib#var#Get('tselectfiles_no_cache_rx', 'bg')
    let rv = use_cache && (empty(no_cache) || s:select_files_dir !~ no_cache)
    " TLogVAR rv
    return rv
endf


function! tselectfiles#GetFileList(world, mode, hide)
    if s:UseCache()
        let id = s:CacheID()
        if a:mode =~ '\(!\|\d\)$' || a:mode == 'scan' || !has_key(s:select_files_files, id)
            if a:mode =~ '!$'
                let s:select_files_files = {}
            endif
            " TLogVAR id
            let s:select_files_files[id] = s:PrepareSelectFiles(a:hide)
        endif
        let rv = s:select_files_files[id]
    else
        let rv = s:PrepareSelectFiles(a:hide)
    endif
    let a:world.base = rv
    " TLogVAR a:world.base
    " let a:world.files = rv
    " let a:world.base  = map(copy(rv), 'tselectfiles#FormatEntry(a:world, v:val)')
endf


function! tselectfiles#AgentPostprocess(world, result)
    if a:result[0 : 2] == '...'
        let item = s:select_files_prefix . a:result[3 : -1]
    else
        let item = a:result
    endif
    let item = resolve(item)
    " TLogVAR item
    " TLogDBG len(a:world.list)
    if isdirectory(item)
        if s:select_files_pattern.limit > 0
            let s:select_files_pattern.predecessor = s:select_files_dir
        endif
        let s:select_files_dir = fnamemodify(item, ':p')
        return [s:ResetInputList(a:world, ''), '']
    endif
    return [a:world, item]
endf


function! tselectfiles#AgentOpenDir(world, selected)
    let dir = input('DIR: ', '', 'dir')
    echo
    if dir != ''
        let s:select_files_dir = fnamemodify(dir, ':p')
        return s:ResetInputList(a:world, '')
    endif
    return a:world
endf


" function! tselectfiles#AgentSelect(world, selected) "{{{3
"     let fname = a:world.GetBaseItem(a:world.prefidx)
"     if !filereadable(fname) && s:UseCache()
"         echom 'TSelectFile: Out-dated cache? File not readable: '. fname
"         return s:ResetInputList(a:world)
"     else
"         call a:world.SelectItem('toggle', a:world.prefidx)
"         " let a:world.state = 'display keepcursor'
"         let a:world.state = 'redisplay'
"         return a:world
"     endif
" endf


function! tselectfiles#AgentReset(world, selected) "{{{3
    return s:ResetInputList(a:world)
endf


function! s:DeleteFile(file)
    let doit = input('Really delete file '. string(a:file) .'? (y/N) ', s:delete_this_file_default)
    echo
    if doit ==? 'y'
        if doit ==# 'Y'
            let s:delete_this_file_default = 'y'
        endif
        call delete(a:file)
        echom 'Delete file: '. a:file
        let bn = bufnr(a:file)
        if bn != -1 && bufloaded(bn)
            let doit = input('Delete corresponding buffer '. bn .' too? (y/N) ')
            if doit ==? 'y'
                exec 'bdelete '. bn
            endif
        endif
    endif
endf


function! tselectfiles#AgentDeleteFile(world, selected)
    call a:world.CloseScratch()
    let s:delete_this_file_default = ''
    for file in a:selected
        call s:DeleteFile(file)
    endfor
    return s:ResetInputList(a:world)
endf


function! tselectfiles#Grep(world, selected)
    let grep_pattern = input('Grep pattern: ')
    if !empty(grep_pattern)
        call a:world.CloseScratch()
        cexpr []
        for filename in a:selected
            if filereadable(filename)
                " TLogVAR filename
                exec 'silent! vimgrepadd /'. escape(grep_pattern, '/') .'/j '. tlib#arg#Ex(filename)
            endif
        endfor
        if !empty(getqflist()) && !empty(g:tselectfiles_show_quickfix_list)
            exec g:tselectfiles_show_quickfix_list
        endif
    endif
    call a:world.ResetSelected()
    return a:world
endf


function! s:Preview(file) "{{{3
    exec 'pedit '. escape(a:file, '%# ')
    let s:tselectfiles_previewedfile = a:file
endf


function! s:ClosePreview() "{{{3
    if exists('s:tselectfiles_previewedfile')
        pclose
        unlet! s:tselectfiles_previewedfile
    endif
endf


function! tselectfiles#ViewFile(world, selected) "{{{3
    " TLogVAR a:selected
    if empty(a:selected)
        call a:world.RestoreOrigin()
        return a:world
    else
        call a:world.SetOrigin()
        return tlib#agent#ViewFile(a:world, a:selected)
    endif
endf


function! tselectfiles#AgentPreviewFile(world, selected)
    let file = a:selected[0]
    if !exists('s:tselectfiles_previewedfile') || file != s:tselectfiles_previewedfile
        call s:Preview(file)
        let a:world.state = 'redisplay'
    else
        call s:ClosePreview()
        let a:world.state = 'display'
    endif
    return a:world
endf


function! s:ConfirmCopyMove(query, src, dest)
    echo
    echo 'From: '. a:src
    echo 'To:   '. a:dest
    let ok = input(a:query .'(y/n) ', 'y')
    echo
    return ok[0] ==? 'y'
endf


function! s:CopyFile(src, dest, confirm)
    if a:src != '' && a:dest != '' && (!a:confirm || s:ConfirmCopyMove('Copy now?', a:src, a:dest))
        let fc = readfile(a:src, 'b')
        if writefile(fc, a:dest, 'b') == 0
            echom 'Copy file "'. a:src .'" -> "'. a:dest
        else
            echom 'Failed: Copy file "'. a:src .'" -> "'. a:dest
        endif
    endif
endf


function! tselectfiles#AgentCopyFile(world, selected)
    for file in a:selected
        let name = input('Copy "'. file .'" to: ', file)
        echo
        call s:CopyFile(file, name, 0)
    endfor
    return s:ResetInputList(a:world)
endf


function! s:RenameFile(file, name, confirm)
    if a:name != '' && (!a:confirm || s:ConfirmCopyMove('Rename now?', a:file, a:name))
        call rename(a:file, a:name)
        echom 'Rename file "'. a:file .'" -> "'. a:name
        if bufloaded(a:file)
            exec 'buffer! '. bufnr('^'. a:file .'$')
            exec 'file! '. tlib#arg#Ex(a:name)
            echom 'Rename buffer: '. a:file .' -> '. a:name
        endif
    endif
endf


function! tselectfiles#AgentRenameFile(world, selected)
    let s:rename_this_file_pattern = ''
    let s:rename_this_file_subst   = ''
    call a:world.CloseScratch()
    for file in a:selected
        let name = input('Rename "'. file .'" to: ', file)
        echo
        call s:RenameFile(file, name, 0)
    endfor
    return s:ResetInputList(a:world)
endf

function! tselectfiles#AgentBatchRenameFile(world, selected)
    let pattern = input('Rename pattern (whole path): ')
    if pattern != ''
        echo 'Pattern: '. pattern
        let subst = input('Rename substitution: ')
        if subst != ''
            call a:world.CloseScratch()
            for file in a:selected
                let name = substitute(file, pattern, subst, 'g')
                call s:RenameFile(file, name, 1)
            endfor
        endif
    endif
    echo
    return s:ResetInputList(a:world)
endf


function! tselectfiles#AgentSelectBackups(world, selected)
    let a:world.filter = g:tselectfiles_suffixes
    let a:world.state  = 'display'
    return a:world
endf


function! s:ResetInputList(world, ...) "{{{3
    let mode = a:0 >= 1 ? a:1 : 'scan'
    let a:world.state  = 'reset'
    call tselectfiles#GetFileList(a:world, mode, get(a:world, 'hide', 1))
    let a:world.picked = 0
    return a:world
endf


function! tselectfiles#AgentHide(world, selected)
    let hidden = get(a:world, 'hide', 1)
    let a:world.hide = hidden ? 0 : 1
    let a:world.state = 'reset'
    return s:ResetInputList(a:world)
endf


function! tselectfiles#FormatFirstLine(filename) "{{{3
    if filereadable(a:filename)
        let lines = readfile(a:filename)
        for l in lines
            if !empty(l)
                return printf('%-20s %s', fnamemodify(a:filename, ':t'), l)
            endif
        endfor
    endif
    return a:filename
endf


function! tselectfiles#FormatVikiMetaDataOrFirstLine(filename) "{{{3
    if filereadable(a:filename)
        let lines = readfile(a:filename)
        let acc   = []
        let cont  = 0
        for l in lines
            if cont || l =~ '^\(\*\|\s*#\(TI\|AU\|DATE\|VAR\)\)' || empty(acc)
                let cont = 0
                if l =~ '\\$'
                    let l = substitute(l, '\\\s*$', '', '')
                    let cont = 1
                endif
                if l =~ '\S'
                    call add(acc, l)
                endif
            else
                break
            endif
        endfor
        return printf('%-20s %s', fnamemodify(a:filename, ':t'), join(acc, ' | '))
    endif
    return a:filename
endf


function! tselectfiles#FormatEntry(world, filename) "{{{3
    " \ {'tlib_UseInputListScratch': 'call world.Highlight_filename()'},
    let display_format = 'a:world.FormatFilename(%s)'
    let filename = fnamemodify(a:filename, ':p')
    let prefix_end = len(s:select_files_prefix) - 1
    if filename[0 : prefix_end] ==# s:select_files_prefix
        let filename = '...' . filename[prefix_end + 1 : -1]
    endif
    " TLogVAR filename
    for [rx, fn] in items(g:tselectfiles_filedescription_rx)
        " TLogVAR rx, fn
        if filename =~ rx
            let a:world.display_as_filenames = 0
            let display_format = fn
            break
        endif
    endfor
    " TLogVAR display_format
    return eval(call(function("printf"), a:world.FormatArgs(display_format, filename)))
endf


function! tselectfiles#SelectFiles(mode, dir)
    " TLogVAR a:mode, a:dir
    let s:select_files_buffer = bufnr('%')
    let s:select_files_mode   = a:mode
    if empty(a:dir) || a:dir == '*'
        let s:select_files_dir = tlib#var#Get('tselectfiles_dir', 'bg', escape(expand('%:p:h'), ','))
        let s:select_files_prefix = tlib#var#Get('tselectfiles_prefix', 'wbg')
        let filter = [[''], [tlib#var#Get('tselectfiles_filter_rx', 'wbg')]]
        " TLogVAR filter
    else
        let s:select_files_dir = escape(fnamemodify(a:dir, ':p:h'), ',')
        let s:select_files_prefix = ''
        let filter = ''
    endif
    " call TLogVAR('s:select_files_dir=', s:select_files_dir)
    let world = copy(g:tselectfiles_world)
    let world.state_handlers = [
                \ {'state': '\<reset\>', 'exec': 'call tselectfiles#GetFileList(world, '. string(a:mode) .', 1)'},
                \ ]
    if a:mode =~ '^n'
        let s:select_files_pattern = {'mode': 'n', 'pattern': ['*']}
        call s:InstallDirHandler(world)
    elseif a:mode =~ '^r'
        let s:select_files_pattern = {'mode': 'r', 'pattern': []}
        let s:select_files_pattern.limit = tlib#var#Get('tselectfiles_limit', 'wbg', 0)
        if s:select_files_pattern.limit == 0
            call add(s:select_files_pattern.pattern, '**')
        else
            call s:InstallDirHandler(world)
            for i in range(1, s:select_files_pattern.limit)
                call add(s:select_files_pattern.pattern, join(repeat(['*'], i), '/'))
            endfor
        endif
    else
        echoerr 'TSelectFile: Unknown mode: '. a:mode
    endif
    call tselectfiles#GetFileList(world, a:mode, 1)
    let world = tlib#World#New(world)
    if !empty(filter)
        call world.SetInitialFilter(filter)
    endif
    let world.display_as_filenames = 1
    let world.tlib_UseInputListScratch = 'if world.display_as_filenames | call world.Highlight_filename() | endif'
    let fs = tlib#input#ListW(world)
    call s:ClosePreview()
endf


function! s:InstallDirHandler(world) "{{{3
    let a:world.post_handlers = [{'postprocess': '', 'agent': 'tselectfiles#AgentPostprocess'}]
endf


" :display: tselectfiles#BaseFilter(?rx='', ?replace='')
function! tselectfiles#BaseFilter(...) "{{{3
    let file = expand('%:t:r')
    if a:0 >= 1
        let rplc = a:0 >= 2 ? a:2 : ''
        let file = substitute(file, a:1, rplc, 'g')
    endif
    let b:tselectfiles_filter_rx = join(split(file, '\A'), '\|')
    return b:tselectfiles_filter_rx
endf

