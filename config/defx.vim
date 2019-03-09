function! DefxContextMenu() abort
  let l:actions = ['new_file', 'new_directory', 'rename', 'copy', 'move', 'paste', 'remove']
  let l:selection = confirm('Action?', "&New file\nNew &Folder\n&Rename\n&Copy\n&Move\n&Paste\n&Delete")
  silent exe 'redraw'

  return feedkeys(defx#do_action(l:actions[l:selection - 1]))
endfunction

call defx#custom#column('mark', {
      \ 'directory_icon': '▸',
      \ 'opened_icon': '▾',
      \ 'readonly_icon': '✗',
      \ 'root_icon': '📁 ',
      \ 'selected_icon': '✓',
      \ })
