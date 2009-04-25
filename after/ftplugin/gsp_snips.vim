if !exists('loaded_snips') || exists('b:did_gsp_snips')
	fini
en
let b:did_gsp_snips = 1
" Templates
"  <g:render template="/domain/template" model="[key : value]"></g:render>
exe "Snipp tem <g:render template=\"${1:name}\" model=\"{$2:model}\" />"

"  <g:def var="now" value="${new Date()}" />
exe "Snipp gdef <g:def var=\"${1:varname}\" value=\"\$\{${2:expression}\}\" />"
