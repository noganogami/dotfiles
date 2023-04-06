function! preserve#Preserve(command)
    " save the last search and the window position
    let l:search = getreg('/')
    let l:view = winsaveview()
    " execute the command
    execute 'keepjumps ' a:command
    " restore the seach and the position
    call winrestview(l:view)
    call setreg('/', l:search)
endfunction
