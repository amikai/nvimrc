function! DefxContextMenu() abort
  let l:msg = "Defx context menu\n".
            \ "=========================================================\n".
            \ "  (a)dd a new file\n".
            \ "  add a new (f)older\n".
            \ "  (d)elete the current node\n".
            \ "  (m)ove the current node\n"

  echo l:msg
  let l:ans = nr2char(getchar()) 
  let l:actions = {'a':'new_file', 'f':'new_directory', 'd':'remove', 'm':'rename'}
  if !(has_key(l:actions, l:ans))
      silent exe 'redraw'
      return
  endif
  echo "=========================================================\n"
  call defx#call_action(get(l:actions, l:ans))
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

    nnoremap <silent><buffer><expr> sc defx#do_action('add_session')

    " back to current directory
    nnoremap <silent><buffer><expr> ~ defx#do_action('cd', [getcwd()])

    " change current work directory
    nnoremap <buffer> cd :call defx#call_action('change_vim_cwd')<CR>
    \ :echo "Defx: CWD is now: ".getcwd()<CR>


    nnoremap <silent><buffer><expr> I defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select') . 'j'

    nnoremap <silent><buffer><expr> j line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent><buffer><expr> k line('.') == 1 ? 'G' : 'k'
    nnoremap <silent><buffer><expr> p defx#do_action('paste')
    nnoremap <silent><buffer><expr> dd defx#do_action('move')
    nnoremap <silent><buffer><expr> yy defx#do_action('copy')
    nnoremap <silent><buffer><expr> q defx#do_action('quit')
    nnoremap <silent><buffer><expr> gh defx#do_action('cd', [getcwd()])
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
      \ 'split': 'vertical',
      \ 'winwidth': 35,
      \ 'direction': 'topleft',
      \ 'resume': v:false,
      \ 'toggle': v:true
      \ })
