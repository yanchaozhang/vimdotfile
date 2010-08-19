# Overview

These are my vim dotfiles.  There are many like it, but these are mine.

# Installation

  - backup / move your ~/.vim directory to somewhere else
  - backup / move your ~/.vimrc to somewhere else
  - git clone this into your ~/.vim directory
  - ln -s ~/.vim/personal/vimrc ~/.vimrc
  - ln -s ~/.vim/personal/gvimrc ~/.gvimrc
  - cd ~/.vim
  - git submodule init
  - git submodule update


# Installing Plugins

I use a "bundle" system for vim plugins.  This makes it much
easier to install/uninstall plugins.

See http://github.com/sunaku/.vim for more help on installing/updating plugins.

I use the following steps to install plugins:

  - download the plugin into a new directory in ~/.vim/bundle
    - for example, ~/.vim/bundle/fooPlugin
  - unzip the plugin into the new ~/.vim/bundle/fooPlugin directory
  - run ~/.vim/bundle/doc.sh

To unistall a plugin, delete the ~/.vim/bundle/fooPlugin directory

Simple, no?

# See Also

See vim-dotfiles.pdf and vim-dotfiles.tex for pretty-formatted
printouts of my deranged shortcut keys and overall Vim setup.


# File Management

 <leader>f     Save current file
 <leader>d     Close current buffer

# Shortcuts

These are some shortcuts/handy mappings that I have.
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

<leader>id  Inserts the current date in MM/DD/YYYY format
<leader>nw  Same as above, except with the weekday after it. ex: 12/01/2009 - Saturday
<leader>it  Inserts the current date in MM/DD/YYYY format, followed by the time

# XML Tidy

<leader>xc  Check XML syntax using tidy.  Requires tidy to be installed
<leader>xx  Check XML syntax, and if good, replace existing file
            with output from tidy

# Window Navigation / Management

 Ctrl K     Move cursor up one window
 Ctrl J     Move cursor down one window
 Ctrl L     Move cursor right one window
 Ctrl H     Move cursor left one window

 <leader>1  Close all windows except current one
 <leader>2  Split window
 <leader>3  Split window vertically

 <leader>0  Close current window
 <leader>w  Close current window

 <leader>m         "Maximize" the current window (Really it only opens it in a new Tab)
 <Ctrl-W Ctrl+O>   Maximize the current window in the current tab.  Press <Ctrl+W Ctrl+O> again
                  to restore the windows to their previous state

# NERD Commenter

 <leader>ci      Comment / Uncomment line(s)
 <leader>cu      UN-comment line(s)
 <leader>cl      Comment lines

# Source Control

(From VCSCommand.vim)

 <leader>nvc     Commit current file
 <leader>nvd     Diff current file w/repository version
 <leader>nvv     VimDiff current file w/repository version

# Find Files

 <leader>sf
 or
 :Rgrep          Recursive grep that finds stuff in subfolders
 <C-Down>        Go to next search result (:cn)
 <C-Up>          Go to previous search result (:cp)


# Color Schemes

Favorite color schemes:

:colo moria
:colo vividchalk
:colo skittles_dark
:colo vibrantink

New Color Schemes:
:colo molokai
:colo darkburn
:colo darkZ

# Less Used

<C-N>   Go to next buffer (:bn)
<C-P>   Go to previous buffer (:bn)
