====== README ====== 
These are my vim dotfiles.  There are many like it, but these are mine.

====== Shortcuts ====== 
These are some shortcuts/handy mappings that I have.
<leader>a  Toggle NERD Tree
<leader>t  Open Fuzzy Finder in current directory, and search
           subdirectories (WARNING: Don't run on large dirs)

<F6>       Toggle "Auto-Save when Vim loses focus" mode
<F10>      Toggle VirtualEdit mode

<Space>    Show recent buffers at bottom of screen.
           Use 'f' and 'b' to move back & forth between them.
           Thanks to bufmru plugin author!

<leader>r  Open Fuzzy Finder for "R"ecent files.

<leader>hs Turn on/off search highlighting
<leader>hc Turn on/off highlighting of cursor line

<leader>cp Copy current file's path to clipboard.  Example: '/home/barney/foo.txt'
<leader>cf Copy current file's name only to clipboard.  Example: 'foo.txt'

<leader>d  
<F4>       Closes buffer, but preserves window
        
<leader>e  Open Netrw in current directory (Think "E"dit current dir)
<leader>o  Open Fuzzy Finder in current directory

<leader>s  
<Cmd-S>    Saves the current file (Same as :w)
           Also works in insert mode.

<Option Up/Down>
<Alt Up/Down>
            Moves cursor to the next/previous text that is on the same column
            that the cursor is on.  Useful for jumping between if / then and
            function definitions

<Tab>       Complete search, OR uses Vimsnippets plugin :-)

<leader>f   Interactive search.  Prompts for search, then lists occurrences,
            and lets you select which one you want to jump to.

<leader>*   list occurrences of word under cursor 
            (Think "*")

<F2>        Open BufExplorer to see list of open buffers
            Uses modified version of BufExplorer.
            Press 'w' to open buffer in a new split window

<F9>        Open 'qbuf' menu, yet another buffer manager

<F1>        Open Netrw (vim's file browser) in the current directory
            of the file that you're viewing.

            Handy netrw commands:

            mf - Mark the file that the cursor is on
            me - Open all marked files

            - (dash) Go up one directory
            u Go to previous directory

            i Display more/less information about files
            s Sort files differently
            r reverse sort

<leader>nd  Inserts the current date in MM/DD/YYYY format
<leader>nw  Same as above, except with the weekday after it. ex: 12/01/2009 - Saturday
<leader>nt  Inserts the current date in MM/DD/YYYY format, followed by the time


====== XML Tidy ======
<leader>xc  Check XML syntax using tidy.  Requires tidy to be installed
<leader>xc! Check XML syntax, and if good, replace existing file 
            with output from tidy


====== Window Navigation / Management ======
 Ctrl K     Move cursor up one window
 Ctrl J     Move cursor down one window
 Ctrl L     Move cursor right one window
 Ctrl H     Move cursor left one window

<leader>m         "Maximize" the current window (Really it only opens it in a new Tab)
<Ctrl-W Ctrl+O>   Maximize the current window in the current tab.  Press <Ctrl+W Ctrl+O> again
                  to restore the windows to their previous state

====== Find Files ======
:Rgrep  Recursive grep that finds stuff in subfolders
        <C-Down>Go to next search result (:cn)
        <C-Up>Go to previous search result (:cp)


====== Color Schemes ======
Favorite color schemes:

:colo moria
:colo vividchalk
:colo skittles_dark
:colo vibrantink

New Color Schemes:
:colo darkburn 
:colo darkZ

====== Less Used ======
<C-N>   Go to next buffer (:bn)
<C-P>   Go to previous buffer (:bn)
