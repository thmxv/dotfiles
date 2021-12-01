
" tnoremap <Esc> <C-\><C-n>:set number<CR>
tnoremap <Esc> <C-\><C-n>
"tnoremap <M-[> <Esc>
"tnoremap <C-v><Esc> <Esc>

tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

inoremap <C-h> <Esc><C-w>h
inoremap <C-j> <Esc><C-w>j
inoremap <C-k> <Esc><C-w>k
inoremap <C-l> <Esc><C-w>l

vnoremap <C-h> <Esc><C-w>h
vnoremap <C-j> <Esc><C-w>j
vnoremap <C-k> <Esc><C-w>k
vnoremap <C-l> <Esc><C-w>l

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" nnoremap <leader>t :split \| ter<CR>a
" nnoremap <leader>vt :vsplit \| ter<CR>a

" make term load bashrc
" let &shell='/usr/bin/bash --login'

" remove line number
" if(exists("##TermOpen"))
"   autocmd TermOpen * setlocal nonumber norelativenumber
" endif
" if(exists("##TermEnter"))
"   autocmd TermEnter * setlocal nonumber norelativenumber
" endif
" if(exists("##TerminalOpen"))
"   autocmd TerminalOpen * setlocal nonumber norelativenumber
" endif
" if(exists("##TerminalEnter"))
"   autocmd TerminalEnter * setlocal nonumber norelativenumber
" endif
