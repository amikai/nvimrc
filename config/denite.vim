call denite#custom#option('_', {
    \ 'prompt': 'λ:',
    \ 'winheight': 10,
    \ 'updatetime': 1,
    \ 'auto_resize': 1,
    \ 'source_names': 'short',
    \ 'empty': 0,
    \ 'auto-accel': 1,
    \ 'vertical_preview': 1,
    \})
"   'vertical_preview': 1, " use it when needed



call denite#custom#option('search', {
    \ 'quit': 0,
    \})

" denite-key mapping
call denite#custom#map('insert', 'jk', '<denite:enter_mode:normal>')
call denite#custom#map('insert', "<C-j>", '<denite:move_to_next_line>')
call denite#custom#map('insert', "<C-k>", '<denite:move_to_previous_line>')

call denite#custom#map('insert', "<C-t>", '<denite:do_action:tabopen>')
call denite#custom#map('insert', "<C-v>", '<denite:do_action:vsplit>')
call denite#custom#map('normal', "vs", '<denite:do_action:vsplit>')
call denite#custom#map('normal', "sp", '<denite:do_action:split>')
call denite#custom#map('normal', "<C-h>", '<denite:wincmd:h>')
call denite#custom#map('normal', "<C-j>", '<denite:wincmd:j>')
call denite#custom#map('normal', "<C-k>", '<denite:wincmd:k>')
call denite#custom#map('normal', "<C-l>", '<denite:wincmd:l>')
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
