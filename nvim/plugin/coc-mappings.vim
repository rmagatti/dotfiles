" " ============================= COC VIM =============================
" " Use tab for trigger completion with characters ahead and navigate.
" " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" " other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" " Use <c-space> to trigger completion.
" if has('nvim')
"   inoremap <silent><expr> <C-Space> coc#refresh()
"   inoremap <silent><expr> <NUL> coc#refresh()
" else
"   inoremap <silent><expr> <c-@> coc#refresh()
" endif

" " Make <CR> auto-select the first completion item and notify coc.nvim to
" " format on enter, <cr> could be remapped by other vim plugin
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"       \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" " Use K to show documentation in preview window.
" nnoremap <silent>K :call <SID>show_documentation()<CR>

" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   elseif (coc#rpc#ready())
"     call CocActionAsync('doHover')
"   else
"     execute '!' . &keywordprg . " " . expand('<cword>')
"   endif
" endfunction

" " Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" " Symbol renaming.
" nmap <leader>rn <Plug>(coc-rename)

" " Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

" " Applying codeAction to the selected region.
" " Example: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" " Remap keys for applying codeAction to the current buffer.
" nmap <M-Enter> <Plug>(coc-codeaction)
" " Apply AutoFix to problem on the current line.
" " nmap <leader>qf  <Plug>(coc-fix-current)

" " Map function and class text objects
" " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
" xmap if <Plug>(coc-funcobj-i)
" omap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap af <Plug>(coc-funcobj-a)
" xmap ic <Plug>(coc-classobj-i)
" omap ic <Plug>(coc-classobj-i)
" xmap ac <Plug>(coc-classobj-a)
" omap ac <Plug>(coc-classobj-a)

" " Use CTRL-S for selections ranges.
" " Requires 'textDocument/selectionRange' support of language server.
" nmap <silent> <C-s> <Plug>(coc-range-select)
" xmap <silent> <C-s> <Plug>(coc-range-select)

" " Add `:Format` command to format current buffer.
" command! -nargs=0 Format :call CocAction('format')


" " Add `:OR` command for organize imports of the current buffer.
" command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" " Add (Neo)Vim's native statusline support.
" " NOTE: Please see `:h coc-status` for integrations with external plugins that
" " Mappings for CoCList
" " Show all diagnostics.
" nnoremap <silent><leader>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions.
" nnoremap <silent><leader>e  :<C-u>CocList extensions<cr>
" " Show commands.
" nnoremap <silent><leader>cm  :<C-u>CocList commands<cr>
" " Find symbol of current document.
" nnoremap <silent><leader>o  :<C-u>CocList outline<cr>
" " Search workspace symbols.
" nnoremap <silent><leader>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent><leader>k  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent><leader>l  :<C-u>CocPrev<CR>
" " Resume latest coc list.
" nnoremap <silent><leader>pr  :<C-u>CocListResume<CR>
" " ========= CoC VIM =========
" augroup mygroup
"   autocmd!
"   " Setup formatexpr specified filetype(s).
"   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"   " Update signature help on jump placeholder.
"   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end

" " Use `[g` and `]g` to navigate diagnostics
" " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
" nmap <silent>gp <Plug>(coc-diagnostic-prev)
" nmap <silent>gn <Plug>(coc-diagnostic-next)

" " GoTo code navigation.
" nmap <silent><nowait>gd <Plug>(coc-definition)
" nmap <silent><nowait>gvd :vsp<CR><Plug>(coc-definition)
" nmap <silent>gt :CocCommand fzf-preview.CocTypeDefinitions<CR>
" nmap <silent>gi <Plug>(coc-implementation)
" nmap <silent>gr :CocCommand fzf-preview.CocReferences<CR>
" nmap <leader>i :CocCommand tsserver.organizeImports<CR>:w<CR>
" nnoremap <leader>sh :call CocActionAsync('showSignatureHelp')<CR>

" " Open yank list
" nnoremap <silent> <leader>y :<C-u>CocList -A --normal yank<CR>
" " Git shortcuts
" nnoremap <silent> <leader>gs :<C-u>CocCommand fzf-preview.GitStatus<CR>

" " Project search
" " command! -nargs=0 ProjectSearchWord :<C-u>CocCommand fzf-preview.ProjectGrep echo expand('<cword>')

" " Commented out in favour of telescope's live_grep for now
" " nnoremap <leader>ps :<C-u>CocCommand fzf-preview.ProjectGrep 
" nnoremap <leader>sw yiw :<C-u>CocCommand fzf-preview.ProjectGrep <C-r>0

" Enter REPL mode relative to current working dir
" nnoremap <leader>rp :CocCommand terminal.REPL<CR>

" Go to normal mode in terminal window
" tnoremap <silent> <C-[><C-[> <C-\><C-n>
" Go to normal mode in terminal window and toggle terminal
" tnoremap <silent> <D-j> <C-\><C-n> :CocCommand terminal.Toggle<CR>
" Destroy terminal
" tnoremap <silent> <D-J> <C-\><C-n> :CocCommand terminal.Destroy<CR>

" function! OpenFuzzyFinder()
"   if isdirectory(getcwd()."/.git")
"     exec ":CocCommand fzf-preview.ProjectFiles"
"   else
"     exec ":CocCommand fzf-preview.DirectoryFiles"
"   endif
" endfunction
