" Vim-test
let g:test#javascript#mocha#file_pattern = '\v(tests?/.*|(test))\.(js|jsx|coffee|ts)$'
let test#javascript#mocha#executable = 'yarn test'
let test#javascript#jest#executable = 'yarn test'

" function! MochaDebugStrategy(cmd)
"   call luaeval("require('rmagatti.dap').debug_mocha")(a:cmd)
" endfunction

function! DebugStrategy(cmd)
  let runner = test#determine_runner(expand('%'))
  call luaeval("require('rmagatti.dap').debug")(runner, a:cmd)
endfunction

function! SplitStrategy(cmd)
  vertical new | call termopen(a:cmd) | startinsert
endfunction
let g:test#custom_strategies = {'terminal_split': function('SplitStrategy'), 'debug': function('DebugStrategy')}
let g:test#strategy = 'terminal_split'

" Regular mappings
nmap <leader>tt :TestNearest<CR>
nmap <leader>tf :TestFile<CR>
nmap <leader>ts :TestSuite<CR>
nmap <leader>tl :TestLast<CR>
nmap <leader>tv :TestVisit<CR>

" Debug mappings
nmap <leader>tdt :TestNearest -strategy=debug<CR>
nmap <leader>tdf :TestFile -strategy=debug<CR>
nmap <leader>tds :TestSuite -strategy=debug<CR>
nmap <leader>tdl :TestLast -strategy=debug<CR>
nmap <leader>tdv :TestVisit -strategy=debug<CR>

