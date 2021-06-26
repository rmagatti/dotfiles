" Had to set this so Goneovim would still pick it up
" let g:coc_node_path = '/Users/ronnieandrewmagatti/.nvm/versions/node/v14.7.0/bin/node'

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Debugger options
" let g:vimspector_enable_mappings = 'HUMAN'
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

" The theme used in the bat preview
" let g:fzf_preview_command = 'bat --color=always --plain {-1}'
" let $FZF_PREVIEW_PREVIEW_BAT_THEME = 'gruvbox'
" let $BAT_THEME = 'gruvbox'

if has('nvim')
  " Firenvim
  let g:firenvim_config = { 
      \ 'globalSettings': {
          \ 'alt': 'all',
      \  },
      \ 'localSettings': {
          \ '.*': {
              \ 'cmdline': 'neovim',
              \ 'content': 'text',
              \ 'priority': 0,
              \ 'selector': 'textarea',
              \ 'takeover': 'never',
          \ },
      \ }
  \ }
  let fc = g:firenvim_config['localSettings']
  let fc['https?://docs.google.com/spreadsheets/'] = { 'takeover': 'never', 'priority': 1 }
  let fc['https?://meet.google.com/'] = { 'takeover': 'never', 'priority': 1 }
endif

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=8

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :set foldlevel=0 | :normal zM
command! -nargs=? Unfold :set foldlevel=8 | :normal zR

