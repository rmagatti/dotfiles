let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/Projects/auto-session
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +7 ~/Projects/dotfiles/nvim/lua/rmagatti/auto-session-telescope.lua
badd +36 ~/Projects/dotfiles/nvim/coc-settings.json
badd +1 ~/Projects/autoreggol/src/method-decorators.ts
badd +1 ~/Projects/autoreggol/src/propery-decorators.ts
badd +92 lua/auto-session.lua
badd +4 ~/Projects/dotfiles/nvim/init.vim
badd +53 ~/Projects/dotfiles/nvim/plugins.vim
badd +2 ~/Projects/dotfiles/nvim/plugin-mappings.vim
badd +2 ~/Projects/dotfiles/nvim/telescope.vim
badd +66 ~/Projects/dotfiles/nvim/lua/rmagatti/telescope.lua
badd +51 ~/Projects/dotfiles/nvim/base.vim
badd +4 term://~/Projects/auto-session//6990:/bin/zsh
argglobal
%argdel
set splitbelow splitright
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
argglobal
enew
balt lua/auto-session.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
lcd ~/Projects/auto-session
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0&& getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 winminheight=1 winminwidth=1 shortmess=filnxtToOFIc
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
