colo Dim_Nate
map    <buffer>  <silent>  <S-F5>             :call Perl_SyntaxCheck()<CR>:redraw!<CR>:call Perl_SyntaxCheckMsg()<CR>
imap   <buffer>  <silent> <S-F5>        <C-C>:call Perl_SyntaxCheck()<CR>:redraw!<CR>:call Perl_SyntaxCheckMsg()<CR>
"
map    <buffer>  <silent>  <F5>               :call Perl_Run()<CR>
imap   <buffer>  <silent> <S-F5>        <C-C>:call Perl_Run()<CR>
"
map    <buffer>  <silent>  <A-F9>             :call Perl_Arguments()<CR>
imap   <buffer>  <silent> <A-F9>        <C-C>:call Perl_Arguments()<CR>
"
map    <buffer>  <silent>  <S-F1>             :call Perl_perldoc()<CR><CR>
imap    <buffer>  <silent>  <S-F1>        <C-C>:call Perl_perldoc()<CR><CR>
