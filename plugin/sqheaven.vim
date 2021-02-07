if exists('g:loaded_sqheaven') | finish | endif " prevent loading file twice

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults

" command to run our plugin
command! -range SQLExec lua require'sqheaven'.execLines()

let &cpo = s:save_cpo " and restore after
unlet s:save_cpo

let g:loaded_sqheaven = 1
