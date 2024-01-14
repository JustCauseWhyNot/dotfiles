" Options.
" ========
set et
set sw=8
set ts=8

filetype on
filetype indent on
filetype plugin off
set bg=dark
set bri
set ch=3
set clipboard+=unnamedplus 
set cot=menuone,noselect
set ic
set is
set lbr
set list
set lcs=tab:>-,trail:-,precedes:<,extends:>
set noeb
set nohls
set nois
set noswf
set wrap
set noet
set number
set ru
set rnu
set rtp+=/usr/share/vim/vimfiles
set scl=yes
set scs
let &sbr = '+++ '
set si
set siso=20
set so=4
set spell
set ss=5
set sta
set tgc
set tw=0
set wrap
set ww=b,s,<,>,[,]

" Keybinds
" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>


" Lua
lua require('plugins')
lua require('init')
