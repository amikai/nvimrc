function! my_config#fern#setting() abort
    let g:fern#renderer#default#expanded_symbol = '▾ '
    let g:fern#renderer#default#collapsed_symbol = '▸ '
    let g:fern#renderer#default#root_symbol = '📁 '
    let g:fern#renderer#default#leaf_symbol = '  '
    let g:fern#renderer#default#leading = ' '
    let g:fern#disable_default_mappings = 0
    let g:fern#drawer_width = 30
    let g:fern#disable_drawer_auto_resize = 0
    let g:fern#disable_default_mappings = 1
    let g:fern#mark_symbol = '✓'
    autocmd Filetype fern highlight link FernBranchSymbol Orange

    " Disable listing ignored files/directories
    let g:fern_git_status#disable_ignored = 1

    " Disable listing untracked files
    let g:fern_git_status#disable_untracked = 1

    " Disable listing status of submodules
    let g:fern_git_status#disable_submodules = 1
endfunction

function! my_config#fern#keymapping() abort
    nmap <buffer><expr><cr>
	      \ fern#smart#leaf(
	      \   "\<Plug>(fern-action-open:select)",
	      \   "\<Plug>(fern-action-expand)",
	      \   "\<Plug>(fern-action-collapse)",
	      \ )

    nmap <buffer><expr>o
	      \ fern#smart#leaf(
	      \   "\<Plug>(fern-action-open:select)",
	      \   "\<Plug>(fern-action-expand)",
	      \   "\<Plug>(fern-action-collapse)",
	      \ )

    nmap <buffer>R <Plug>(fern-action-redraw)

    nmap <buffer>> <Plug>(fern-action-enter)

    nmap <buffer>< <Plug>(fern-action-leave)

    nmap <buffer>~ :<C-u>Fern <C-r>=getcwd()<CR> -drawer<CR>

    nmap <buffer>cd <cmd>call my_config#fern#cd_wrapper()<cr>

    nmap <buffer>I <Plug>(fern-action-hidden:toggle)

    nmap <buffer><space> <Plug>(fern-action-mark:set)j
    nmap <buffer><esc> <Plug>(fern-action-mark:clear)<Plug>(fern-action-clipboard-clear)

    nnoremap <silent><buffer><expr> j line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent><buffer><expr> k line('.') == 1 ? 'G' : 'k'

    nmap <buffer>dd <Plug>(fern-action-clipboard-move)
    nmap <buffer>p <Plug>(fern-action-clipboard-paste)
    nmap <buffer>yy <Plug>(fern-action-clipboard-copy)

    nnoremap <buffer>+ <cmd>call fern#action#call('zoom')<cr>

    nnoremap <silent><buffer>m <cmd>call my_config#fern#context_menu()<cr>
endfunction

function! my_config#fern#cd_wrapper() abort
    execute "normal \<Plug>(fern-action-cd)\<Plug>(fern-action-enter)"
    echo("Fern: CWD is now: ".getcwd())
endfunction

function! my_config#fern#context_menu() abort
    echo("Fern context menu\n")
    let l:msg =  "=========================================================\n".
                \ "  (a)dd a childnode\n".
                \ "  (d)elete the current node\n".
                \ "  (m)ove the current node\n".
                \ "  (r)eveal in Finder the current node\n"

    echo l:msg
    let l:ans = nr2char(getchar())
    let l:actions = {
                \ 'a': 'new-path',
                \ 'd': 'remove',
                \ 'm': 'move',
                \ 'r': 'open:system'
                \ }
    if !(has_key(l:actions, l:ans))
        silent exe 'redraw'
        return
    endif
    echo "=========================================================\n"
    call fern#action#call(l:actions[l:ans])
endfunction
