function! utils#echo_succes_msg(msg) abort
    hi! TEMP_SUCCESS_MSG  cterm=bold ctermfg=142 gui=bold guifg=#b8bb26
    echohl TEMP_SUCCESS_MSG
    echo a:msg
    echohl None
endfunction
