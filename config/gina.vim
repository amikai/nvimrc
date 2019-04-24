
call gina#custom#command#alias('status', 'st')
call gina#custom#command#option('st', '--opener', &previewheight . 'split')
call gina#custom#mapping#nmap(
            \ 'status', 'cm',
            \ ':<C-u>Gina cm \| setlocal winfixheight<cr>',
            \ {'noremap': 1, 'silent': 1},
            \)

call gina#custom#command#alias('commit', 'cm')
call gina#custom#command#option('cm', '--opener', &previewheight . 'split')
call gina#custom#mapping#nmap(
            \ 'commit', 'st',
            \ ':<C-u>Gina st \| setlocal winfixheight<cr>',
            \ {'noremap': 1, 'silent': 1},
            \)

" 10 line git log viewer
call gina#custom#command#alias('log', 'lg')
call gina#custom#command#option('lg', '--group', 'trace-log')
call gina#custom#command#option('lg', '--opener', 'botright ' . '10split')
call gina#custom#mapping#nmap(
            \ 'log', 'p',
            \ ':call gina#action#call(''ls'') \| setlocal winfixwidth<cr>'
            \)

call gina#custom#command#option('ls', '--group', 'trace-ls')
call gina#custom#command#option('ls', '--opener', 'botright' . '40vsplit')

call gina#custom#command#option('show', '--group', 'trace-show')


