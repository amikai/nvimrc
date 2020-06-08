if exists('g:config_defx')
    finish
endif
let g:config_defx = 1

function! DefxContextMenu() abort
    call utils#echo_succes_msg("Defx context menu\n")
    let l:msg =  "=========================================================\n".
                \ "  (a)dd a childnode\n".
                \ "  (A)dd multiple childnodes\n".
                \ "  (d)elete the current node\n".
                \ "  (m)ove the current node\n".
                \ "  (r)eveal in Finder the current node\n".
                \ "  (s)earch the word in files\n".
                \ "  (g)ina add\n"

    echo l:msg
    let l:ans = nr2char(getchar())
    let l:actions = {'a':{'op':'call', 'args':['DefxNewNode']},
                \ 'A': {'op':'call',   'args':['DefxNewMultiNode']},
                \ 'd':{'op':'remove',  'args':[]},
                \ 'm':{'op':'rename',  'args':[]},
                \ 'r':{'op': 'call',   'args':['DefxOpenFinder']},
                \ 's': {'op': 'call',  'args': ['DefxSearchByDenite']},
                \ 'g': {'op': 'call', 'args': ['DefxGinaAdd']}}
    if !(has_key(l:actions, l:ans))
        silent exe 'redraw'
        return
    endif
    echo "=========================================================\n"
    let l:action = get(l:actions, l:ans)
    call defx#call_action(action.op, action.args)
endfunction

function! DefxNewNode(context) abort
    echo "Enter the dir/file name to be created. Dirs end with a '/'\n"
    call defx#call_action('new_file')
endfunction

function! DefxNewMultiNode(context) abort
    echo "Enter the dir/file name seperated by space. Dirs end with a '/'\n"
    call defx#call_action('new_multiple_files')
endfunction

function! DefxOpenFinder(context) abort
    if has('mac')
        let l:open = 'open'
    elseif has('unix')
        let l:open = 'xdg-open'
    endif

    for path in a:context.targets
        if defx#is_directory()
            let l:full_path = fnamemodify(path, ':p')
        else
            let l:full_path = fnamemodify(path, ':p:h')
        endif
        let l:open_folder = printf("%s '%s'", l:open, l:full_path)
        echo l:open_folder
        call system(l:open_folder)
    endfor
endfunction

function! DefxSearchByDenite(context) abort
    " clean arg list
    if !dein#tap('denite.nvim')
        return
    endif
    call dein#source('denite.nvim')

    let l:args = []
    for path in a:context.targets
        if filereadable(path)
            call add(l:args, path)
        elseif isdirectory(path)
            call extend(l:args, glob(path.'/**', v:false, v:true))
        endif
    endfor
    call uniq(sort(l:args))
    let l:paths_str = join(l:args, ':')

    execute 'wincmd p'
    exe 'Denite grep:' . l:paths_str
endfunction

function! DefxGinaAdd(context) abort
    if !dein#tap('gina.vim')
        return
    endif
    call dein#source('denite.nvim')

    let l:args = []
    for path in a:context.targets
        if filereadable(path)
            call add(l:args, path)
        elseif isdirectory(path)
            call extend(l:args, glob(path.'/**', v:false, v:true))
        endif
    endfor
    call uniq(sort(l:args))
    let l:paths_str = join(l:args, ' ')
    exe 'Gina add ' . l:paths_str
endfunction

function! MyDefxKeySetup() abort
    nnoremap <silent><buffer><expr> <CR>
                \ defx#is_directory() ?
                \ defx#do_action('open_or_close_tree') :
                \ defx#do_action('drop')

    nnoremap <silent><buffer><expr> o
                \ defx#is_opened_tree() ?
                \ defx#do_action('close_tree') :
                \ defx#do_action('open_tree')

    nnoremap <silent><buffer><expr> O
                \ defx#is_opened_tree() ?
                \ defx#do_action('close_tree') :
                \ defx#async_action('open_tree_recursive')

    nnoremap <silent><buffer><expr> R defx#do_action('redraw')

    nnoremap <silent><buffer><expr> >
                \ defx#is_directory() ?
                \ defx#do_action('open') :
                \ "\<nop>"
    nnoremap <silent><buffer><expr> < defx#do_action('cd', ['..'])


    " back to current directory
    nnoremap <silent><buffer><expr> ~ defx#do_action('cd', [getcwd()])

    " change current work directory
    nnoremap <buffer> cd
                \ :call defx#call_action('open') <bar>
                \ :call defx#call_action('change_vim_cwd')<bar>
                \ :call utils#echo_succes_msg("Defx: CWD is now: ".getcwd())<cr>


    nnoremap <silent><buffer><expr> I defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> <esc> defx#do_action('clear_select_all')

    nnoremap <silent><buffer><expr> j line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent><buffer><expr> k line('.') == 1 ? 'G' : 'k'
    nnoremap <silent><buffer><expr> p defx#do_action('paste')
    nnoremap <silent><buffer><expr> dd defx#do_action('move')
    nnoremap <silent><buffer><expr> yy defx#do_action('copy')
    nnoremap <silent><buffer><expr> q defx#do_action('quit')
    nnoremap <silent><buffer><expr> ! defx#do_action('execute_command')
    nnoremap <silent><buffer>m :call DefxContextMenu()<CR>
endfunction

call defx#custom#column('icon', {
            \ 'directory_icon': '▸',
            \ 'opened_icon': '▾',
            \ 'root_icon': '📁 ',
            \ })

call defx#custom#column('mark', {
            \ 'readonly_icon': '✗',
            \ 'selected_icon': '✓',
            \ })


call defx#custom#option('_', {
            \ 'columns': 'git:mark:indent:icon:filename:type',
            \ 'split': 'vertical',
            \ 'winwidth': 35,
            \ 'direction': 'topleft',
            \ 'resume': v:false,
            \ 'toggle': v:true
            \ })
