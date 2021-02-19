if exists('g:loaded_sqheaven') | finish | endif " prevent loading file twice

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults

function! sqheaven#GetHosts(arglead, cmdline, cursorPos)
    return join(keys(g:sqheaven_connections), "\n")
endfunction

function! sqheaven#GetTables(arglead, cmdline, cursorPos)
    return luaeval('require("sqheaven").getTables()')
endfunction

" command to run our plugin
command! -range SQLStart lua require'sqheaven'.start()
command! -range SQLExec lua require'sqheaven'.execLines()
command! -nargs=1  -complete=custom,sqheaven#GetTables SQLDescTable lua require'sqheaven'.descTable(<f-args>)
command! -nargs=0 SQLShowTables lua require'sqheaven'.showTables()
command! -nargs=1 -complete=custom,sqheaven#GetHosts SQLSwitchConnect lua require'sqheaven'.switchConnect(<f-args>)
command! -nargs=0 SQLShowConnect lua require'sqheaven'.showConnect()

let &cpo = s:save_cpo " and restore after
unlet s:save_cpo

let g:loaded_sqheaven = 1
