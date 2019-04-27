function! DefxContextMenu() abort
  let l:msg = "Defx context menu\n".
            \ "=========================================================\n".
            \ "  (a)dd a new file\n".
            \ "  add a new (f)older\n".
            \ "  (d)elete the current node\n".
            \ "  (m)ove the current node\n".
            \ "  (c)opy the current node\n"

  echo l:msg
  let l:ans = nr2char(getchar()) 
  let l:actions = {'a':'new_file', 'f':'new_directory', 'd':'remove', 'm':'rename', 'c':'copy'}
  if !(has_key(l:actions, l:ans))
      silent exe 'redraw'
      return
  endif
  echo "=========================================================\n"
  call feedkeys(defx#do_action(get(l:actions, l:ans)))
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

