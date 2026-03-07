" Options.
" ========
set et
set sw=8
set ts=8

filetype indent on
filetype on
filetype plugin off
let &sbr = '+++ '
set bg=dark
set bri
set ch=3
set clipboard+=unnamedplus 
set cot=menuone,noselect
set ic
set is
set lbr
set lcs=tab:>-,trail:-,precedes:<,extends:>
set list
set noeb
set noet
set nohls
set nois
set noscs
set noswf
set number
set rnu
set rtp+=/usr/share/vim/vimfiles
set ru
set scl=yes
set si
set siso=20
set so=4
set spell
set ss=5
set sta
set termguicolors
set tgc
set tw=0
set wrap
set wrap
set ww=b,s,<,>,[,]

" Keybinds
" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" Lua
lua require("config.lazy")
