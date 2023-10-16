function! s:named_register()
  let min=char2nr('a')
  let max=char2nr('z')
  let props= {'cur': min}

  function! props.shift_register_contents() closure
    for i in range(max - min)
      let src_reg = getreginfo(nr2char(max - i - 1))
      let dst_name = nr2char(max - i)
      call setreg(dst_name, src_reg)
    endfor
  endfunction

  return props
endfunction


let s:reg = s:named_register()

function! yankukku#Yank()
  call s:reg.shift_register_contents()
  call setreg('a', @")
endfunction
