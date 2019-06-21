function! DefxContextMenu() abort
  let l:msg = "Defx context menu\n".
            \ "=========================================================\n".
            \ "  (a)dd a new file\n".
            \ "  add a new (f)older\n".
            \ "  (d)elete the current node\n".
            \ "  (m)name the current node\n"

  echo l:msg
  let l:actions = {'a':'new_file', 'f':'new_directory', 'd':'remove', 'm':'rename'}
  if !(has_key(l:actions, l:ans))
      silent exe 'redraw'
      return
  endif
  echo "=========================================================\n"
  call defx#call_action(get(l:actions, l:ans))
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
      \ 'winwidth': 40,
      \ 'split': 'vertical',
      \ 'direction': 'topleft',
      \ 'resume': v:false,
      \ 'toggle': v:true
      \ })
