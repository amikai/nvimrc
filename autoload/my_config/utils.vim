function! my_config#utils#show_function_key() abort
    let msgs = ['<F2> goyo focus',  '<F3> code format', '<F4> defx',
                \ '<F5> whitespace', '<F6> undotree', '<F8> tagbar', '<F12> show msg']
    echo join(msgs, " | ")
endfunction
