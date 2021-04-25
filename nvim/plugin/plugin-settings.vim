" =================== COC VIM =====================

" Had to set this so Goneovim would still pick it up
let g:coc_node_path = '/Users/ronnieandrewmagatti/.nvm/versions/node/v14.7.0/bin/node'

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

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

" The theme used in the bat preview
" let g:fzf_preview_command = 'bat --color=always --plain {-1}'
let $FZF_PREVIEW_PREVIEW_BAT_THEME = 'gruvbox'
let $BAT_THEME = 'gruvbox'

" Theme settings
" let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox

" Sneak
let g:sneak#s_next = 1
let g:sneak#label = 1
let g:sneak#user_ic_scs = 1

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

" " " Already defaults to this dir
" let g:auto_session_root_dir = "~/.config/nvim/session/"
" let g:auto_session_pre_save_cmds = ["silent! bd! terminal"]

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=8

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :set foldlevel=0
command! -nargs=? Unfold :set foldlevel=8


" FZF Preview
" let g:fzf_preview_floating_window_rate = 0.7

" Alternate Toggler custom alternates
let g:at_custom_alternates = {
      \'===': '!=='
      \}

" " vim-dirvish-dovish
" unmap all default mappings
let g:dirvish_dovish_map_keys = 0

augroup dirvish_config
  autocmd!
  " unmap dirvish default
  autocmd FileType dirvish silent! unmap <buffer><C-p>
  autocmd FileType dirvish silent! unmap <buffer>p

  " My mappings
  autocmd FileType dirvish silent! map <buffer>i <Plug>(dovish_create_file)
  autocmd FileType dirvish silent! map <buffer>I <Plug>(dovish_create_directory)
  autocmd FileType dirvish silent! map <buffer>dd <Plug>(dovish_delete)
  autocmd FileType dirvish silent! map <buffer>r <Plug>(dovish_rename)
  autocmd FileType dirvish silent! map <buffer>yy <Plug>(dovish_yank)
  autocmd FileType dirvish silent! map <buffer>yy <Plug>(dovish_yank)
  autocmd FileType dirvish silent! map <buffer>p <Plug>(dovish_copy)
  autocmd FileType dirvish silent! map <buffer>P <Plug>(dovish_move)
augroup END

" Neovide configs
let g:neovide_cursor_trail_size=0.7
let g:neovide_window_floating_opacity=0.7
let g:neovide_cursor_trail_length=0.1
let g:neovide_refresh_rate=60
let g:neovide_window_floating_blur=v:true
let g:neovide_cursor_animate_in_insert_mode=v:false
let g:neovide_cursor_antialiasing=v:true
let g:neovide_cursor_animation_length=0.1
let g:neovide_cursor_vfx_particle_density=7.0
let g:neovide_transparency=0.95

