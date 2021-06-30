local fn = vim.fn

this_file = fn.expand('<sfile>')

vim.env.NVIMRC = fn.fnamemodify(this_file, ':h')
vim.env.CACHE = fn.expand('$HOME/.cache')

require('my_config.basic')
fn.execute('source ' .. vim.env.NVIMRC .. '/plug.vim')

