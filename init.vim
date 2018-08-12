let $nvimrc=fnamemodify('<sfile>', ':p:h')
exe "source" $nvimrc."/basic.vim"
exe "source" $nvimrc."/dein_plug.vim"
