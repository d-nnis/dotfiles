
set laststatus=2

function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi StatusLine ctermbg=darkgreen ctermfg=white cterm=bold
  elseif a:mode == 'r'
    hi statusline ctermbg=blue cterm=bold
  else
    hi statusline ctermbg=grey ctermfg=blue
  endif
endfunction

au InsertLeave * call ColorNrm()
au InsertEnter * call InsertStatuslineColr(v:insertmode)
au InsertChange * call InsertStatuslineColr(v:insertmode)

func! ColorNorm()
  hi statusline ctermfg=7* ctermbg=8 term=NONE cterm=NONE gui=NONE
endfunction

call ColorNorm()
