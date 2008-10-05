" Choose colorscheme
" colo hhdyellow " Way too many annoying colors / highlighting for HTML, etc
" colo vibrantin " Textmate knockoff
colo railscasts_with_blackbg
" Change highlighting to something more palatable, rather
" than annoying blocky cursor where you can't decipher where the 
" cursor is when you're on () and {}, etc
hi CursorLine guibg=#0d0d0d
" Make cursor not so obnoxious
hi Cursor guibg=#857b6f
" Make visually selected stuff not so obnoxious,
" modeled after Textmate, 2008/09/17 
hi Visual guibg=#131313
" Again, make incremental search not so obnoxious
" hi IncSearch gui=NONE guibg=#131313
" Change the highlight of stuff I find when searching
hi Search cterm=NONE ctermfg=Black ctermbg=LightGrey gui=NONE guifg=Black guibg=#CCCC99
" This is from the wombat theme, and I like the Pmenu and PmenuSel
" colo wombat
" colors that don't blast you in the face with the hot pink
"
if version >= 700
  " hi CursorColumn guibg=#2d2d2d
  "
  hi MatchParen ctermfg=red ctermbg=black  guifg=red guibg=black

  " hi MatchParen guifg=#f6f3e8 guibg=#857b6f gui=bold
  hi Pmenu guifg=#f6f3e8 guibg=#444444
  hi PmenuSel guifg=#000000 guibg=#cae682
  " TODO change the color of the search text AS I search (there's a
  " lot of goofy colors)
  " Fix stupid crap where people flip out and make non-text look absolutely
  " stupid
  hi NonText term=bold ctermfg=8 gui=bold guifg=#404040
  " TODO change the highlight of TODO stuff  
  hi Todo guifg=#000000 guibg=#cae682

endif
hi StatusLineNC term=bold,reverse cterm=bold,reverse guifg=black guibg=#787878 gui=none
hi StatusLine term=reverse cterm=reverse guifg=black guibg=#969696 gui=none
" hi StatusLine 	guifg=#f6f3e8 guibg=#444444 gui=italic
" hi StatusLineNC guifg=#857b6f guibg=#444444 gui=none
" " General colors
" hi Cursor 		guifg=NONE    guibg=#656565 gui=none
" hi Normal 		guifg=#f6f3e8 guibg=#242424 gui=none
" hi NonText 		guifg=#808080 guibg=#303030 gui=none
" hi LineNr 		guifg=#857b6f guibg=#000000 gui=none
" hi VertSplit 	guifg=#444444 guibg=#444444 gui=none
" hi Folded 		guibg=#384048 guifg=#a0a8b0 gui=none
" hi Title		guifg=#f6f3e8 guibg=NONE	gui=bold
" hi Visual		guifg=#f6f3e8 guibg=#444444 gui=none
" hi SpecialKey	guifg=#808080 guibg=#343434 gui=none
" 
" " Syntax highlighting
" hi Comment 		guifg=#99968b gui=italic
" hi Todo 		guifg=#8f8f8f gui=italic
" hi Constant 	guifg=#e5786d gui=none
" hi String 		guifg=#95e454 gui=italic
" hi Identifier 	guifg=#cae682 gui=none
" hi Function 	guifg=#cae682 gui=none
" hi Type 		guifg=#cae682 gui=none
" hi Statement 	guifg=#8ac6f2 gui=none
" hi Keyword		guifg=#8ac6f2 gui=none
" hi PreProc 		guifg=#e5786d gui=none
" hi Number		guifg=#e5786d gui=none
" hi Special		guifg=#e7f6da gui=none
" 
" 
