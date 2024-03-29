" ALE
nmap <Leader>a :ALEFix<CR>

" Black
nmap <Leader>b :Black<CR>
" autocmd BufWritePre *.py execute ':Black'

" limelight
let g:limelight_conceal_guifg = 'Gray'
let g:limelight_conceal_ctermfg = 'Gray'
let g:limelight_default_coefficient = 0.1

" Goyo
nmap <Leader>g :Goyo<CR>
function! s:goyo_enter()
  set scrolloff=999
  Limelight
endfunction

function! s:goyo_leave()
  set scrolloff=5
  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" Autocommands
" special treat, save xresources colors to kitty colors
autocmd BufWritePost ~/.Xresources.d/colors :silent exec "!xtokitty"

" map fuzzy search
nnoremap <Leader>o :GFiles<CR>
nnoremap <Leader>o :GFiles!<CR>

" Vue
let g:vim_vue_plugin_load_full_syntax = 1
