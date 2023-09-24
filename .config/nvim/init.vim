" Options.
" ========
set et
set sw=8
set ts=8

filetype indent on
filetype plugin off
set bg=dark
set ch=3
set is
set list
set lcs=tab:>-,trail:-
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
set si
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

" Lua
lua require('plugins')
lua require('init')
