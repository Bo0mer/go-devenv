#!/bin/bash

cat > /home/vagrant/.vim_go_runtime/custom_config.vim <<\EOF
nmap <leader>pj :%!python -m json.tool<CR>
set autochdir


autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

filetype plugin indent on
autocmd FileType yaml setl indentkeys-=<:>
autocmd FileType yaml setl tabstop=4 softtabstop=0 expandtab shiftwidth=2 smarttab


nmap <leader>gg :!ginkgo<CR>
nmap <leader>gr :!ginkgo -r<CR>

set relativenumber

function! s:tab_complete()
    if pumvisible()
        return "\<C-n>"
    else
        " Check whether it's an empty line
        let col = col('.') - 1
        if !col || getline('.')[col - 1] =~ '\s'
            return "\<TAB>"
        endif

        if neosnippet#expandable_or_jumpable()
            return "\<Plug>(neosnippet_expand_or_jump)"
        endif

        return "\<TAB>"
    endif
endfunction

imap <silent><expr> <TAB> <SID>tab_complete()

:ab :W :write
:ab ife if err != nil {<CR>
:ab ifer if err != nil {<CR>return err}
:ab td // TODO(ivan):

:syntax off

EOF
