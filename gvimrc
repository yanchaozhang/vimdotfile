" Disable visual bell which has annoying warning blinking
" do it again in gvimrc because gvim reads .gvimrc
" and resets t_vb to blink if this isn't set
set vb t_vb=

" Make the File.Close menu actually close the friggin' buffer,
" not the window (which is nigh-useless)
:amenu &File.&Close<Tab>:bd :confirm bd<CR>

" Use anti-aliased fonts
set anti

