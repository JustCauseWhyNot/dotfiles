" Options.
" ========
set et
set sw=4
set ts=4

filetype plugin indent on
set bg=dark
set ch=3
set is
set list
set listchars=tab:>-,trail:-
set noeb
set nohls
set nois
set noswf
set nowrap
set number
set ru
set rnu
set rtp+=/usr/share/vim/vimfiles
set scs
set siso=20
set so=4
set sta
set tgc
set tw=130
set wrap
set ww=b,s,<,>,[,]

" Keybinds
" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" Plugins.
" ========
lua require('plugins')

augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end

" Lua.
" ====
lua require('init')
