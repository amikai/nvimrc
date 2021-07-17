function! my_config#defx#context_menu() abort
    echo("Defx context menu\n")
    let l:msg =  "=========================================================\n".
                \ "  (a)dd a childnode\n".
                \ "  (A)dd multiple childnodes\n".
                \ "  (d)elete the current node\n".
                \ "  (m)ove the current node\n".
                \ "  (r)eveal in Finder the current node\n"

    echo l:msg
    let l:ans = nr2char(getchar())
    let l:actions = {
                \ 'a':{'op':'call', 'args':['my_config#defx#new_node']},
                \ 'A': {'op':'call',   'args':['my_config#defx#new_multi_node']},
                \ 'd':{'op':'remove',  'args':[]},
                \ 'm':{'op':'rename',  'args':[]},
                \ 'r':{'op': 'call',   'args':['my_config#defx#open_finder']}
                \ }
    if !(has_key(l:actions, l:ans))
        silent exe 'redraw'
        return
    endif
    echo "=========================================================\n"
    let l:action = get(l:actions, l:ans)
    call defx#call_action(action.op, action.args)
endfunction

function! my_config#defx#new_node(context) abort
    echo "Enter the dir/file name to be created. Dirs end with a '/'\n"
    call defx#call_action('new_file')
endfunction

function! my_config#defx#new_multi_node(context) abort
    echo "Enter the dir/file name seperated by space. Dirs end with a '/'\n"
    call defx#call_action('new_multiple_files')
endfunction

function! my_config#defx#open_finder(context) abort
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

function! my_config#defx#keymapping() abort
    nnoremap <silent><buffer><expr> <CR>
                \ defx#is_directory() ?
                \ defx#do_action('open_or_close_tree') :
                \ defx#do_action('open', 'choose')

    nnoremap <silent><buffer><expr> o
                \ defx#do_action('open_tree', 'toggle')

    nnoremap <silent><buffer><expr> O
                \ defx#is_opened_tree() ?
                \ defx#do_action('close_tree') :
                \ defx#async_action('open_tree', 'recursive')

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
                \ :call echo("Defx: CWD is now: ".getcwd())<cr>


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
    nnoremap <silent><buffer>m :call my_config#defx#context_menu()<CR>
endfunction


function! my_config#defx#basic_setting() abort
    call defx#custom#column('icon', {
                \ 'directory_icon': '▸',
                \ 'opened_icon': '▾',
                \ 'root_icon': '📁 ',
                \ })

    call defx#custom#column('mark', {
                \ 'readonly_icon': '✗',
                \ 'selected_icon': '✓',
                \ })

    call defx#custom#column('filename', {
                \ 'min_width': 128,
                \ 'max_width': 128,
                \ })

    call defx#custom#option('_', {
                \ 'columns': 'git:mark:indent:icon:filename:type',
                \ 'split': 'vertical',
                \ 'winwidth': 35,
                \ 'direction': 'topleft',
                \ 'resume': v:false,
                \ 'toggle': v:true,
                \ 'session_file': stdpath('data') . '/defx_session',
                \ 'buffer_name': 'defx'
                \ })
endfunction
