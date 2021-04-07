let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/Projects/Neo/application-service
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +55 src/lib/encryption.ts
badd +164 src/models/subdocs/credit-application/applicant-properties.subdoc.ts
badd +30 src/lib/aws-kms.ts
badd +18 src/providers/reports/berbix-id-verification-report-encryption.provider.ts
badd +0 test/lib/encryption.test.ts
badd +22 migrations/20210308114543-move-hbc-prequal-limit-to-adjudication-steps.ts
badd +50 migrations/20201223084106-add-iovation-digital-fraud-report-ids-to-user-profile.ts
badd +19 README.md
badd +65 src/api/admin/resolvers/reports/berbix-id-verification.resolver.ts
badd +69 src/api/admin/schema/reports/berbix-id-verification-report.schema.ts
badd +665 lib/admin-federated-schema.graphql
badd +420 src/api/admin/types/schema.d.ts
badd +81 src/api/admin/resolvers/credit-card-application/credit-card-application.resolver.ts
badd +54 src/api/admin/schema/credit-card-application/credit-card-application.schema.ts
badd +0 src/api/admin/schema/common.schema.ts
badd +12 src/api/customer/schema/common.schema.ts
argglobal
%argdel
edit migrations/20210308114543-move-hbc-prequal-limit-to-adjudication-steps.ts
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 172 + 172) / 345)
exe 'vert 2resize ' . ((&columns * 172 + 172) / 345)
argglobal
balt src/api/admin/resolvers/credit-card-application/credit-card-application.resolver.ts
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 22 - ((21 * winheight(0) + 43) / 87)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 22
normal! 011|
wincmd w
argglobal
if bufexists("src/api/admin/resolvers/reports/berbix-id-verification.resolver.ts") | buffer src/api/admin/resolvers/reports/berbix-id-verification.resolver.ts | else | edit src/api/admin/resolvers/reports/berbix-id-verification.resolver.ts | endif
if &buftype ==# 'terminal'
  silent file src/api/admin/resolvers/reports/berbix-id-verification.resolver.ts
endif
balt src/providers/reports/berbix-id-verification-report-encryption.provider.ts
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 114 - ((83 * winheight(0) + 43) / 87)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 114
normal! 014|
wincmd w
exe 'vert 1resize ' . ((&columns * 172 + 172) / 345)
exe 'vert 2resize ' . ((&columns * 172 + 172) / 345)
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0&& getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 winminheight=1 winminwidth=1 shortmess=filnxtToOFcI
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
