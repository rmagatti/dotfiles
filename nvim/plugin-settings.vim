" =================== COC VIM =====================

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" TextEdit might fail if hidden is not set.
set hidden
" Had to set this so Goneovim would still pick it up
let g:coc_node_path = '/Users/ronnieandrewmagatti/.nvm/versions/node/v14.7.0/bin/node'

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" ================== Lightline statusline config ===========
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'relativepath', 'modified' ] ],
      \ }
      \ }

" Debugger options
let g:vimspector_enable_mappings = 'HUMAN'
" Mappings
" F5         vimspector#Continue()
" F3         vimspector#Stop()
" F4         vimspector#Restart()
" F6         vimspector#Pause()
" F9         vimspector#ToggleBreakpoint()
" <leader>F9 vimspector#ToggleBreakpoint( { trigger expr, hit count expr } ) // Toggle conditional line breakpoint on the current line.  
" F8         vimspector#AddFunctionBreakpoint( '<cexpr>' )
" <leader>F8 vimspector#RunToCursor()
" F10        vimspector#StepOver()
" F11        vimspector#StepInto()
" F12        vimspector#StepOut()

colorscheme gruvbox
