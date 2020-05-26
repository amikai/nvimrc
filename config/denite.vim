call denite#custom#option('_', {
            \ 'prompt': 'λ:',
            \ 'winheight': 10,
            \ 'updatetime': 1,
            \ 'auto_resize': 1,
            \ 'source_names': 'short',
            \ 'empty': 0,
            \ 'auto-accel': 1,
            \ 'floating-preview': 1,
            \ 'filter-split-direction': "floating",
            \ 'split': 'floating'
            \})
"   'vertical_preview': 1, " use it when needed



call denite#custom#option('search', {
            \ 'quit': 0,
            \})

" denite-key mapping
function! MyDeniteKeySetup() abort
    nnoremap <silent><buffer><expr> ?
    \ denite#do_map('choose_action')
    nnoremap <silent><buffer><expr> <CR>
    \ denite#do_map('do_action')
    nnoremap <silent><buffer><expr> d
    \ denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> p
    \ denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> q
    \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> i
    \ denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> <Space>
    \ denite#do_map('toggle_select').'j'
    nnoremap <silent><buffer><expr> r
    \ denite#do_map('do_action', 'quickfix')
    nnoremap <silent><buffer><expr> <C-r>
    \ denite#do_map('restore_sources')
    nnoremap <silent><buffer><expr> R
    \ denite#do_map('redraw')
endfunction

" customize ignore globs
call denite#custom#source('grep', 'matchers', ['matcher_ignore_globs'])
call denite#custom#source('line', 'matchers', ['matcher_ignore_globs', 'matcher_regexp'])
call denite#custom#source('file_rec', 'matchers', ['matcher_fuzzy','matcher_ignore_globs'])

call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
            \ [
            \ '.git/', 'build/', '__pycache__/',
            \ 'images/', '*.o', '*.make',
            \ '*.min.*',
            \ 'img/', 'fonts/',
            \ 'tags', 'cscope*'])



if executable('rg')
    call denite#custom#var('file/rec', 'command',
                \ ['rg', '--files', '--glob', '!.git'])
    call denite#custom#var('grep', 'command', ['rg', '--threads', '4'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'final_opts', [])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'default_opts',
                \ ['--vimgrep', '--no-heading'])
else
    call denite#custom#var('file/rec', 'command',
                \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
endif
call denite#custom#source(
            \ 'buffer,file_mru,file_old,file_rec,grep,mpc,line',
            \ 'matchers', ['matcher_cpsm'])

" vim: set foldmethod=marker tw=80 sw=4 ts=4 sts=4 sta nowrap et :
