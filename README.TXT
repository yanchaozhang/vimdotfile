====== README ====== 
This is my vim dotfiles.  There are many like it, but this one is mine.

====== Shortcuts ====== 
These are some shortcuts/handy mappings that I have.

<Ctrl-Space> Turn off search highlighting
<C-N>   Go to next buffer (:bn)
<C-P>   Go to previous buffer (:bn)
\s      Interactive search that lists occurrences
\/

\8      list occurrences of word under cursor (Reason for the 8 is 
        it's like "*"


:Rgrep  Recursive grep that finds stuff in subfolders
<C-Down>Go to next occurrence of error or search result (:cn)
<C-Up>Go to previous occurrence of error or search result (:cp)

<F1>    Opens netrw (File browser) instead of help.
<S-F1>  Opens Fuzzy Finder in current directory

<F2>    Opens BufExplorer plugin
<S-F1>  Opens Fuzzy Finder in current directory
        
<F3>
<F4>    Close buffer, but don't blast the window if there was another
        file open in the window previously.  Uses "BufKill" Plugin

<Cmd-S> Writes the file, and then goes to normal mode if you're in insert mode.
        Overridden in macvimrc file, with help from MacVim author

