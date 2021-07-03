" Run clang-format on save
function! Formatonsave()
  let l:formatdiff = 1
  pyf /usr/share/clang/clang-format.py
endfunction
" autocmd BufWritePre *.h,*.hpp,*.hxx,*.cc,*.cpp,*.cxx call Formatonsave()

