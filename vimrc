" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
" From http://wiki.rubyonrails.org/rails/pages/HowtoUseVimWithRails
set nocompatible
" Set the tab labels to just the filename, and not the abbreviated directories
" that are the default setting
set guitablabel=%N\ %t
" Show entire filename on the mouseover
set guitabtooltip=%N\ %F

" Enable syntax highlighting
syntax enable

" Enable filetype-specific indenting and plugins
filetype plugin indent on 

" Don't do the stupid wrapping line junk
set nowrap

" Don't show the toolbar
:set guioptions-=T

" Set font.  Use Monaco on OSX, and Courier on Linux/Windoze 
if has('mac')
    set guifont=Monaco:h14
    " set guifont=Bitstream\ Vera\ Sans\ Mono\ 18
elseif has('gui_win32')
    set guifont=courier_new:h10 
elseif has('gui_gtk')
    " set guifont=Courier\ New\ 12
    set guifont=Bitstream\ Vera\ Sans\ Mono\ 12
endif

" Tabs: see :help tabstop
set softtabstop=4
set shiftwidth=4
" set switchbuf=usetab
" allow backspacing over everything in insert mode
" from example_vimrc
set backspace=indent,eol,start

" Back up files to $HOME/vimbackups
" If that doesn't exist, try one of the $TEMP directories.
" Might need to create a directory, if Vim whines about not being able to
" make backups.
set backup
set backupdir=$HOME/vimbackups,$TEMP/vimbackups,/temp/vimbackups,/tmp/vimbackups

" Set directory for swap files.
" see :h swap
if has('win32')
    set dir=c:\nate\vimswapfiles
else
    set dir=~/tmp
endif
set whichwrap+=<,>,h,l  " backspace and cursor keys wrap, also

" Status Line
" The %= means right-align.  The %Y means filetype
set statusline=%F%m%r%h%w\ (%l\,\ %v)%=%Y\ 
set laststatus=2
" incremental search
" From http://www.perlmonks.org/?node_id=540167
set incsearch

" Tell vim to highlight stuff that I find using search
set hlsearch

" set highlight color to gray, and not annoying blue or yellow
hi Search guibg=LightGray

" When no beep or flash is wanted
" Note: This is also needed in gvimrc, or Gvim will "beep"
set vb t_vb=

" TODO Make <Enter> add a blank line even in Normal mode.

" smartcase means ignore case unless i type a capITal letter in my search, mmk?
" From http://www.linuxjournal.com/article/3805
set smartcase
set ignorecase

" Tell Vim to quit whining about unsaved buffers just because I want to open
" a new buffer
set hidden

" The % keystroke is useful for bouncing around pairs of various sorts of
" brackets. It can be made to work for angled brackets as well:
set matchpairs+=<:>

" Make the completion options more sane, and not immediately
" jump to the longest match
" http://www.vim.org/tips/tip.php?tip_id=1386
set completeopt=longest,menuone

" set the directory of the explorer = to the directory
" of the current buffer
set bsdir=buffer

" Highlight the line that the cursor is on.
set cursorline
" See also color_customizations below

" Automatically lcd whenever me enter a buffer
autocmd BufEnter * :lcd %:p:h

" Source other goodies
so ~/.vim/mappings.vim
so ~/.vim/my_functions.vim
so ~/.vim/plugin_customizations.vim
so ~/.vim/color_customizations.vim
so ~/.vim/menus.vim
so ~/.vim/abbreviations.vim
