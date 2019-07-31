
function! ChapterPrev()
  ?==\s*\w
endfunction

function! ChapterNext()
  /==\s*\w
endfunction

inoremap <F7> <Esc>:call ChapterPrev()<CR>
inoremap <F8> <Esc>:call ChapterNext()<CR>
nnoremap <F7> :call ChapterPrev()<CR>
nnoremap <F8> :call ChapterNext()<CR>
