local fn = vim.fn

vim.env.NVIMRC = fn.expand('$XDG_CONFIG_HOME/nvim')
vim.env.CACHE = fn.expand('$HOME/.cache')

require('my_config.basic')
fn.execute('source ' .. vim.env.NVIMRC .. '/plug.vim')

