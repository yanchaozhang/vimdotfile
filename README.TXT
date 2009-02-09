====== README ====== 
This is my vim dotfiles.  There are many like it, but this one is mine.

====== Shortcuts ====== 
These are some shortcuts/handy mappings that I have.
<leader>a  Toggle NERD Tree
<leader>t  Use Fuzzy Finder in current directory
<leader>hs Turn on/off search highlighting

<C-N>   Go to next buffer (:bn)
<C-P>   Go to previous buffer (:bn)
<leader>s  Saves the current file (Same as :w)
           Also works in insert mode.

<leader>d   Closes file (buffer)
<leader>/   Interactive search.  Prompts for search, then lists occurrences,
            and lets you select which one you want to jump to.

<leader>*      list occurrences of word under cursor (Reason for the 8 is 
        it's like "*"

<F1>    Open Netrw (vim's file browser) in the current directory
        of the file that you're viewing.

        Handy netrw commands:

        mf - Mark the file that the cursor is on
        me - Open all marked files

        - (dash) Go up one directory
        u Go to previous directory

        i Display more/less information about files
        s Sort files differently
        r reverse sort


:Rgrep  Recursive grep that finds stuff in subfolders
<C-Down>Go to next occurrence of error or search result (:cn)
<C-Up>Go to previous occurrence of error or search result (:cp)

<S-F1>  Opens Fuzzy Finder in current directory

<F2>    Opens BufExplorer plugin
<S-F1>  Opens Fuzzy Finder in current directory
        
<F3>
<F4>    Close buffer, but don't blast the window if there was another
        file open in the window previously.  Uses "BufKill" Plugin

<Cmd-S> Writes the file, and then goes to normal mode if you're in insert mode.
        Overridden in macvimrc file, with help from MacVim author

