function! my_config#utils#show_function_key() abort
    let msgs = ['<F2> goyo focus',  '<F3> code format', '<F4> fern', '<F5> whitespace',
                \ '<F6> undotree', '<F8> tagbar', '<F8> diagnostics','<F12> show msg']
    echo join(msgs, " | ")
endfunction

function! my_config#utils#go_to_original_pos() abort
    if line("'\"") > 0 && line ("'\"") <= line("$")
        execute "normal! g'\""
    endif
endfunction