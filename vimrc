
" Sections:
"    -> my settings
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"mapclear
"mapclear!
"cmapclear
"imapclear
"comclear


" like <leader>w saves the current file
let mapleader = ","
"let g:mapleader = ","
"command! -bar ReloadVimrc source $MYVIMRC | doautocmd <nomodeline> FileType | normal zv
command! -bar ReloadVimrc source $MYVIMRC 
nnoremap <leader>R :ReloadVimrc<CR>
"nnoremap <leader>r :ReloadVimrc<CR>

nnoremap <leader>ce :e ~/.vimrc<CR>

""""""""""""""""""""
" plugins settings "
""""""""""""""""""""
" automatic vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" throws error after reloading vimrc: _neomake is not a command_
call plug#begin('~/.vim/plugged')
  Plug 'neomake/neomake'
  Plug 'tpope/vim-surround'
  Plug 'https://github.com/tpope/vim-repeat'
  "Plug 'tpope/vim-unimpaired'
  Plug 'chikamichi/mediawiki.vim'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'asciidoc/vim-asciidoc'
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/limelight.vim'
  Plug 'junegunn/seoul256.vim'
  Plug 'https://github.com/nelstrom/vim-docopen'
  Plug 'https://github.com/nelstrom/vim-cutlass'
  "Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'https://github.com/SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'https://github.com/vifm/vifm.vim'
  Plug 'https://github.com/fholgado/minibufexpl.vim'
  Plug 'https://github.com/vim-scripts/taglist.vim'
  Plug 'https://github.com/gotcha/vimpdb'
  Plug 'https://github.com/davidhalter/jedi-vim'
call plug#end()

"" Vim PythonIDE
au BufNewFile,BufRead *.py set tabstop=4 | set softtabstop=4 | set shiftwidth=4 | set textwidth=79 | set expandtab | set autoindent | set fileformat=unix

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
"" MiniBufExpl Colors
hi MBENormal               guifg=#808080 guibg=fg
hi MBEChanged              guifg=#CD5907 guibg=fg
hi MBEVisibleNormal        guifg=#5DC2D6 guibg=fg
hi MBEVisibleChanged       guifg=#F1266F guibg=fg
hi MBEVisibleActiveNormal  guifg=#A6DB29 guibg=fg
hi MBEVisibleActiveChanged guifg=#F1266F guibg=fg

"noremap <C-PageDown>   :MBEbn<CR>
""noremap <C-PageUp>     :MBEbp<CR>
noremap <leader>j   :MBEbn<CR>
noremap <leader>k     :MBEbp<CR>
"noremap <C-TAB>   :MBEbn<CR>
""noremap <C-S-TAB> :MBEbp<CR>

"TODO: toggle?
"map T :TaskList<CR>
""TODO
map <leader>P :TlistToggle<CR>


"" /Vim PythonIDE

let g:tmux_navigator_disable_when_zoomed = 1

  "Plug 'junegunn/limelight.vim'
  "Plug 'junegunn/vim-peekaboo'
  "Plug 'junegunn/vim-slash'
  "Plug 'junegunn/vim-easy-align'
  "Plug 'junegunn/rainbow_parentheses.vim'
  "Plug 'https://github.com/tpope/vim-surround'
  "Plug 'tpope/vim-fugitive'

"" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
"let g:UtliSnipsJumpForwardTrigger="<c-b>"
"let g:UtliSnipsJumpBackwardTrigger="<c-z>"
"let g:UltiSnipsSnippetsDir="/home/dennis/dotfiles/UltiSnips/"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories=["UltiSnips_priv", "UltiSnips"]

"" FZF
" double-binding...
"map <silent> <c-space> :files<cr>
"map <silent> <leader>t :tags<cr>
"map <silent> <leader>m :marks<cr>
let g:fzf_layout = { 'down': '~20%' }


""" NERDTree
"noremap <leader>t :NERDTreeToggle<CR>
"noremap <leader>f :NERDTreeFind<CR>
"" always open NERDTree on opening
""autocmd vimenter * NERDTree
"
"" close NERDTree when opening a file
"let NERDTreeQuitOnOpen=1
"
"" always show hidden files
"let NERDTreeShowHidden=1
"
"" NERDTree opening when starting with no file(s) specified
""autocmd StdinReadPre * let s:std_in=1
""autocmd StdinReadPre * let s:std_in=2
""autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"
"" close vim if NERDTree is the only window left
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" find files and populate the quickfix list
fun! FindFiles(filename)
  let error_file = tempname()
  silent exe '!find . -name "'.a:filename.'" | xargs file | sed "s/:/:1:/" > '.error_file
  set errorformat=%f:%l:%m
  exe "cfile ". error_file
  copen
  call delete(error_file)
endfun
command! -nargs=1 FindFile call FindFiles(<q-args>)

" navigate to last buffer
noremap <leader># :b#<cr>

" Neomake
augroup _neomake_config
  au!
  autocmd! BufWritePost * Neomake
augroup END
let g:neomake_open_list=2

syntax enable
set shiftwidth=2
set tabstop=2

"set guifont=Menlo\ 12

"""""""""
" color "
"""""""""
"colorscheme solarized
" https://github.com/junegunn/seoul256.vim
" seoul256 (dark):
"   Range:   233 (darkest) ~ 239 (lightest)
"   Default: 237
let g:seoul256_background = 233

" seoul256 (light):
"   Range:   252 (darkest) ~ 256 (lightest)
"   Default: 253
"let g:seoul256_background = 256

if $USER != "root"
  color seoul256
endif
" this one only vor gvim?
"colorscheme seoul256
" Light color scheme
"colo seoul256-light

" Switch
"set background=dark
"set background=light

"""""""""""""""""""
" Goyo & Limelight"
"""""""""""""""""""
" distraction-free writing

"let g:limelight_conceal_ctermfg = '#00000'
"let g:limelight_conceal_ctermfg = '#ffff00'
let g:limelight_paragraph_span = 2
let g:limelight_default_coefficient = 0.7
" turn on :Goyo
function! s:goyo_enter()

  if ! has("gui_running")
"    ! echo -e "\033]710;xft:DejaVu Sans Mono:style=Regular:size=15\033\\"
"    ! echo -e "\033]711;xft:DejaVu Sans Mono:style=Bold:size=15\033\\"
"    ! echo -e "\033]712;xft:DejaVu Sans Mono:style=Oblique:size=15\033\\"
"    ! echo -e "\033]713;xft:DejaVu Sans Mono:style=Bold Oblique:size=15\033\\"
   ! focus.sh -on
  else
    set guifont=Monaco\ 15
    colorscheme seoul256
  endif
  silent !tmux set status off
  Goyo 65%x80%
  Limelight 0.7 " the higher the darker
  set nolist
  set so=3
  "TODO: change font-size to 15 (perl:font-size (URxvt))
  "silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  "set noshowmode
  "set noshowcmd
  "set scrolloff=999
  "Limelight
  " ...
endfunction

" turn off :Goyo!
function! s:goyo_leave()
  silent !tmux set status on
"  silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
"  set showmode
"  set showcmd
"  set scrolloff=5
  if ! has("gui_running")
"    ! echo -e "\033]710;xft:DejaVu Sans Mono:style=Regular:size=10\033\\"
"    ! echo -e "\033]711;xft:DejaVu Sans Mono:style=Bold:size=10\033\\"
"    ! echo -e "\033]712;xft:DejaVu Sans Mono:style=Oblique:size=10\033\\"
"    ! echo -e "\033]713;xft:DejaVu Sans Mono:style=Bold Oblique:size=10\033\\"
    ! focus.sh -off
  else
    set guifont=DejaVu\ Sans\ Mono\ 10
    colorscheme seoul256
  endif
  Limelight!
  set list
  
  set so=7
  " ...
endfunction

nnoremap <F9> :Goyo<CR>

"$term->cmd_parse("\033]" . $escapecodes{$type} . ";" . $newfont . "\033\\");
"xft:DejaVu Sans Mono:style=Bold Oblique:size=11
"echo -e "\033]710;xft:DejaVu Sans Mono:style=Bold Oblique:size=17\033\\"

"xft:Inconsolata for Powerline:size=12

"$ echo -e "\033]710;DejaVu Sans Mono:style=Book:size=10\033\\"
"DejaVu Sans Mono:style=Book:size=10

"$ echo -e "\033]710;-xos4-terminus-medium-r-normal--12-120-72-72-c-60-iso10646-1\033\\"
"-xos4-terminus-medium-r-normal--12-120-72-72-c-60-iso10646-1
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

"function! FocusOn()
"  call Goyo 75%x75%
"  call Limelight 0.8
"endfunction
"
"function! FocusOff()
"  call Goyo!
"  call Limelight!
"endfunction

"""""""""""""""""""""""""""""""""""""""""""
" help help me, Ronda! - helper functions "
"""""""""""""""""""""""""""""""""""""""""""

"if &ft =~ 'asciidoc' || &ft =~ 'mediawiki'
"  inoremap <F7> <Esc>:call AprevChapter()<CR>
"  inoremap <F8> <Esc>:call AnextChapter()<CR>
"  nnoremap <F7> :call AprevChapter()<CR>
"  nnoremap <F8> :call AnextChapter()<CR>
"elseif &ft =~ 'markdown'
"  inoremap <F7> <Esc>:call MDprevChapter()<CR>
"  inoremap <F8> <Esc>:call MDnextChapter()<CR>
"  nnoremap <F7> :call MDprevChapter()<CR>
"  nnoremap <F8> :call MDnextChapter()<CR>
"elseif &ft =~ 'vim'
"  inoremap <F7> <Esc>:call VIprevChapter()<CR>
"  inoremap <F8> <Esc>:call VInextChapter()<CR>
"  nnoremap <F7> :call VIprevChapter()<CR>
"  nnoremap <F8> :call VInextChapter()<CR>
"endif


function! WSKill()
  :'<,'>s/\s\{2,\}/ /g
endfun

fun! NewlKill()
  :'<,'>s/\n/ /g
endfun

" s.a. :h regex, magix, multi
fun! OneFlow()
  :'<,'>s/\(\s\|\n\)\{1}\s\{1,\}/ /g
endfun

" quite ugly, but works: delete auto-completion anchors ('<,'>)
vmap <leader>of :<del><del><del><del><del>call OneFlow()<CR>

function! MakeFileExecutable()
    !chmod u+x %
    ":call system('chmod u+x ' . shellescape(fname)) [https://stackoverflow.com/questions/17459104/how-to-execute-an-external-command-in-vim-script#17459161]
    "    :r this
endfunction

function! OpenFileInBrowser()
  " TODO: use same tab every time (possible?)
  :!x-www-browser % > /dev/null 2>&1 &
endfunction

nnoremap <leader>gf :call OpenFileInBrowser()<CR><CR>

"=== evoke a web browser
function! Browser()
  let line0 = getline (".")
  "let line = matchstr (line0, "http[^ ]*")
  " WIP: Stop at first closed bracket (markdown-links). Improve with matching opening bracket
  let line = matchstr (line0, "http[^ |)]*")
  echo "line1:".line1
  if line==""
    let line = matchstr (line0, "ftp[^ ]*")
  endif
  if line==""
    let line = matchstr (line0, "file[^ ]*")
  endif
  let line = escape (line, "#?&;|%")
  if line==""
    let line = "\"" . (expand("%:p")) . "\""
  endif
  " TODO: --remote something
  exec ':silent !x-www-browser ' . line . ' &'
endfunction
nnoremap <leader>gl :call Browser()<CR>:redraw!<CR>

if exists("ChapterPrev")
else
  function! ChapterPrev()
    ?##\s*\w
  endfunction
  " assuming this func does not exist as well
  function! ChapterNext()
    /##\s*\w
  endfunction
  inoremap <F7> <Esc>:call ChapterPrev()<CR>
  inoremap <F8> <Esc>:call ChapterNext()<CR>
  nnoremap <F7> :call ChapterPrev()<CR>
  nnoremap <F8> :call ChapterNext()<CR>
endif

if has("gui_running")
  " GUI is running or is about to start.
  set lines=60 columns=100
endif

set modeline
set modelines=5
"set modeline modelines=5

"inoremap <buffer> <C-v> <Left><C-O>"+p



""" freddy {{{
"
"function! InsertStatuslineColor(mode)
"  echo a:mode
"  if a:mode == 'i'
"    hi statusline guifg=red ctermfg=red
"    set cursorcolumn
"    set cul!
"  elseif a:mode == 'r'
"    hi statusline guifg=blue ctermfg=lightblue
"    "hi statusline ctermfg=green
"    set cursorcolumn
"  else "(a:mode == 'v')
"    hi statusline guifg=magenta ctermfg=magenta
"  endif
"  " TODO: no cursorline if in Focus/Goyo-mode
"  "set cursorline
"endfunction
"
"function! InsertLeaveActions()
"  echo "sth newLEave"
"  set nocul!
"  "org: hi statusline guifg=NONE ctermfg=NONE ctermbg=NONE
"  hi statusline guifg=darkgrey ctermfg=darkgrey guibg=white ctermfg=white
"  "hi statusline guifg=orange ctermfg=NONE guibg=white ctermbg=white
"  set nocursorcolumn
"  "set nocursorline
"endfunction
"
"func! Sth2()
"  echo "sth newww"
"endfunc
"
"au InsertEnter * call InsertStatuslineColor(v:insertmode)
""au InsertEnter * call InsertStatslineColor(v:insertmode)
""autocmd InsertEnter *
"
"au InsertLeave * call InsertLeaveActions()

" to handle exiting insert mode via a control-C
"inoremap <c-c> <c-o>:call InsertLeaveActions()<cr><c-c>

" default of statusline
"hi statusline guibg=grey ctermfg=black ctermbg=white
"hi statusline guibg=grey ctermfg=black ctermbg=white


"}}}
"map <F5> <Esc><C-s>:! ./%<cr> "noremap <F5> <Esc><C-s>:! echo "____________" && ./%<cr>
noremap <F5> <Esc><C-s>:! ./%<cr>

""""""""""""""""""
" autocorrection "
""""""""""""""""""

" wann geladen wird # Maske # Aktivieren # Zu verwendende Sprache
" https://wiki.archlinux.de/title/Rechtschreibprüfung_unter_Vim
" save power, check spell not in real-time!2017-03-20"au BufNewFile,BufRead,BufEnter *.adoc setlocal spell spelllang=de_de
"au BufNewFile,BufRead,BufEnter *.md setlocal spell spelllang=de_de
"au BufNewFile,BufRead,BufEnter *.txt setlocal spell spelllang=de_de
"au BufNewFile,BufRead,BufEnter README setlocal spell spelllang=en_us

"iabbrev teh the
"iab INnovation Innovation
" WIP [http://vim.wikia.com/wiki/Changing_case_with_regular_expressions]
" %s/\<\(\u\)\(\u\)\(\l\+\)/\1\L\2\L\3/cg transalte to iabbrev:
"iab \<\(\u\)\(\u\)\(\l\+\) \1\L\2\L\3

" or better yet: do it in a final phase after writing
" results in resource-saving

" turn WOrd into Word
nnoremap <F4> :%s:\<\(\u\)\(\u\)\(\l\+\):\1\L\2\L\3:cg<CR>
" turn into function: if not found, echo "finished" or sth the like.

" dictionaries
" TODO: check if file exists
set dictionary=/usr/share/dict/american-english
set dict+=/usr/share/dict/ngerman

set complete+=k


"""""""""""""""""""""""
" File: mediawiki.vim "
"""""""""""""""""""""""
" Many MediaWiki wikis prefer line breaks only at the end of paragraphs
" (like in a text processor), which results in long, wrapping lines.
setlocal wrap linebreak
setlocal textwidth=0

" No auto-wrap at all.
" s.a. PASTEMODE (set paste)
setlocal formatoptions-=tc formatoptions+=l
if v:version >= 602 | setlocal formatoptions-=a | endif

" Make navigation more amenable to the long wrapping lines.
"noremap <buffer> k gk
" disadvantage: counting lines and motion diverge with wrapping lines (e.g. d8j)
noremap k gk
noremap j gj
noremap <Up> gk
noremap <Down> gj
noremap <End> g$
noremap <Home> g0
nnoremap 0 g0
nnoremap ^ g^
nnoremap $ g$
noremap D dg$
noremap C cg$
nnoremap A g$a

inoremap <Up> <C-o>gk
inoremap <Down> <C-o>gj
inoremap <End> <C-o>g$
inoremap <Home> <C-o>g0

" utf-8 should be set if not already done globally
setlocal fileencoding=utf-8
" explicit setting of fileencoding globally
setglobal fileencoding=utf-8
" is unix fileformat obvious?
setglobal fileformat=unix
setlocal matchpairs+=<:>

" Treat lists, indented text and tables as comment lines and continue with the
" same formatting in the next line (i.e. insert the comment leader) when hitting
" <CR> or using "o".
setlocal comments=n:#,n:*,n:\:,s:{\|,m:\|,ex:\|}
setlocal formatoptions+=roq

" match HTML tags (taken directly from $VIM/ftplugin/html.vim)
if exists("loaded_matchit")
    let b:match_ignorecase=0
    let b:match_skip = 's:Comment'
    let b:match_words = '<:>,' .
  \ '<\@<=[ou]l\>[^>]*\%(>\|$\):<\@<=li\>:<\@<=/[ou]l>,' .
  \ '<\@<=dl\>[^>]*\%(>\|$\):<\@<=d[td]\>:<\@<=/dl>,' .
  \ '<\@<=\([^/][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>'
endif


" Other useful mappings
"" mediawiki {{{
"" Insert a matching = automatically while starting a new header.
if &filetype =~ 'mediawiki' " works?
  inoremap <buffer> <silent> = <C-R>=(getline('.')==''\|\|getline('.')=~'^=\+$')?"==\<Lt>Left>":"="<CR>

  " Enable folding based on ==sections==
  setlocal foldexpr=getline(v:lnum)=~'^\\(=\\+\\)[^=]\\+\\1\\(\\s*<!--.*-->\\)\\=\\s*$'?\">\".(len(matchstr(getline(v:lnum),'^=\\+'))-1):\"=\"
endif

" }}}

setlocal fdm=marker

" map <F8> :setfiletype mediawiki<CR>
if has("autocmd")
  autocmd!
  " native vimperator-Plugin <C-i>
  au BufRead,BufNewFile *web6.codeprobe.de*.tmp* set filetype=mediawiki
  au BufRead,BufNewFile *freddy*.tmp* set filetype=mediawiki
  " FF-Plugin-It's all text <C-e>
  au BufRead,BufNewFile *web6.codeprobe.de_wiki_* set filetype=mediawiki
  au BufRead,BufNewFile *freddy_wiki* set filetype=mediawiki
  " Qutebrowser-External Editor <C-e>
  au BufRead,BufNewFile *qutebrowser-editor* set filetype=mediawiki
  " awesome-autocheck
  "autocmd BufWritePost *awesome/rc.lua !awesome -k | !echo -n "Press Enter to continue..." && read -s<cr>"
  " waits for return after every errorcode
  "autocmd BufWritePost *awesome/rc.lua :exe "! awesome -k && read -s"
  " waits for return only after errorcode >=1
  autocmd BufWritePost *awesome/rc.lua :exe "! awesome -k"
  

endif

fun! DemoteWikiTitels()
  :%s/===\s/== /cg
  :%s/\s===/ ==/cg
endfun
"""""""""""""""""""""""""""""""""""
" watch changes in vimrc and load "
"""""""""""""""""""""""""""""""""""

" already set with autoread?
" problem with Neomake
"augroup myvimrc
"    au!
"    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
"augroup END

"function! ReloadVimrc()
"  command! -bar ReloadVimrc source $MYVIMRC | doautocmd <nomodeline> FileType | normal zv
"endfunction

"if !exists("*ReloadVimrc")
"function! ReloadVimrc()
"  source ~/.vimrc
""   echo "vimrc reloaded!"
"endfunction
"endif


"""""""""""""""""
" amix settings "
"""""""""""""""""


"set listchars=eol:$
" in newer version space too:
"set listchars=eol:$,tab:>-,extends:>,precedes:<,space:␣
set listchars=eol:$,tab:>-,extends:>,precedes:<
"set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
" end of line characters
set list
set number
set norelativenumber " (https://blog.petrzemek.net/2016/04/06/things-about-vim-i-wish-i-knew-earliernnoremap <leader>u :set relativenumber!<CR>
nnoremap <leader>u :set relativenumber!<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread


"""""""""""""""
" Fast saving "
noremap <leader>w :w!<cr>
" write and quit
noremap <leader>W :wq
" quit all
noremap <leader>Q :qa
" quick save
noremap <C-s> :w!<cr>
" TODO: does not return to INSERTMODE after reload
imap <C-s> <Esc>:w<cr>

if has('gui_running')
  command! Sav browse confirm saveas
endif

" :W sudo saves the file 
" (useful for handling the permission-denied error)
command! W w !sudo tee > /dev/null %
cmap w!! %!sudo tee > /dev/null %

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
"set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en' 
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
  set wildignore+=.git\*,.hg\*,.svn\*
endif

"Always show current position
set ruler

" Height of the command bar
set cmdheight=3

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
set mouse=a
endif

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch
noremap <silent> <leader><cr> :noh<cr>
"nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>

" Makes search act like search in modern browsers
set incsearch 

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
noremap <space> /
noremap <c-space> ?

" Disable highlight when <leader><cr> is pressed


" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch 
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set visualbell
set t_vb=
set tm=500

" Add a bit extra margin to the left
set foldcolumn=3


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

try
    " colorscheme desert
catch
endtry

"set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile
set undodir=~/tmp/.vimundo
set undofile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
"set shiftwidth=4
"set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines
noremap <leader>W :set wrap!<CR>
set wrapscan


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>
vnoremap // y/<C-R>0<CR>
vnoremap ?? y?<C-R>0<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
noremap j gj
noremap k gk


" Smart way to move between windows
" conflicts with vim-tmux-navigator (defines it anyway)
"noremap <C-j> <C-W>j
"noremap <C-k> <C-W>k
"noremap <C-h> <C-W>h
"noremap <C-l> <C-W>l

" how to split
set splitbelow
set splitright

" Close the current buffer
"map <leader>bd :Bclose<cr>:tabclose<cr>gT
"map <leader>bd :Bclose<cr><leader>tc
noremap <leader>bc :Bclose<cr>

" Close all the buffers
noremap <leader>ba :bufdo bd<cr>

" Useful mappings for managing tabs
noremap <leader>tn :tabnew<cr>
noremap <leader>to :tabonly<cr>
noremap <leader>tc :tabclose<cr>
noremap <leader>tm :tabmove 
noremap <leader>t<leader> :tabnext 

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
noremap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
noremap <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
noremap <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
" do not it COMMIT_EDITMSG !?
"autocmd BufReadPost *
"     \ if line("'\"") > 0 && line("'\"") <= line("$") |
"     \   exe "normal! g`\"" |
"     \ endif
" Remember info about open buffers on close
set viminfo^=%


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ CWD:%r%{getcwd()}%h\ \ Line:%l\\%L
" or %{line('$')}?


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
"map 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
" does not work if bound with meta-key <M-j>
"noremap <A-j> mz:m+<cr>`z
"noremap <A-k> mz:m-2<cr>`z
"vmap <A-j> :m'>+<cr>`<my`>mzgv`yo`z
"vmap <A-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Move visual selection
"vnoremap K :m '<-2<cr>gv=gv 
"vnoremap J :m '>+1<cr>gv=gv
vnoremap <A-j> :m '<-2<cr>gv=gv 
vnoremap <A-k> :m '>+1<cr>gv=gv

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ag searching and cope displaying
"    requires ag.vim - it's much better than vimgrep/grep
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NOTE: You must, of course, install ag / the_silver_searcher
command! -bang -nargs=* -complete=file Ag call ag#Ag('grep<bang>',<q-args>)
command! -bang -nargs=* -complete=file AgAdd call ag#Ag('grepadd<bang>', <q-args>)
command! -bang -nargs=* -complete=file AgFromSearch call ag#AgFromSearch('grep<bang>', <q-args>)
command! -bang -nargs=* -complete=file LAg call ag#Ag('lgrep<bang>', <q-args>)
command! -bang -nargs=* -complete=file LAgAdd call ag#Ag('lgrepadd<bang>', <q-args>)
command! -bang -nargs=* -complete=file AgFile call ag#Ag('grep<bang> -g', <q-args>)
command! -bang -nargs=* -complete=help AgHelp call ag#AgHelp('grep<bang>',<q-args>)
command! -bang -nargs=* -complete=help LAgHelp call ag#AgHelp('lgrep<bang>',<q-args>)

" s.a. ~/.vim/doc/ag.txt
" When you press gv you Ag after the selected text
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

" Stay in visual mode after indenting
vnoremap < <gv
vnoremap > >gv

vnoremap x xgv

" Open Ag and put the cursor in the right position
noremap <leader>a :Ag 

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you snarch with Ag, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
noremap <leader>cc :botright cope<cr>
noremap <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
noremap <leader>n :cn<cr>
noremap <leader>p :cp<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
setlocal nospell
setglobal nospell
" Pressing ,ss will toggle and untoggle spell checking
noremap <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
noremap <leader>sn ]s
noremap <leader>sp [s
noremap <leader>sa zg
noremap <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" default printer paper
set printoptions=paper:A4

" shortmessages
" ORG: filnxtToO
set shm=filnx

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
noremap <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
"map <leader>x :e ~/buffer.md<cr>
" rather asciidoc

function! ScribbleIntro()
    " _line_ results in the line number of expression, here: "$": last line of buffer
    " _min_ returns the minimum value. Here: 20 (if there are less lines than that number accordingly)
    " calculate range: within first 20 existing lines
    let ll = min([20, line("$")])
    " position cursor at start of file
    call cursor(1,1)
    " search for pattern == Day: 2017-03-20 with date of today
    let today = strftime('%F')
    let headtoday = "\=\= Day: ".today
    let match = search(headtoday,'', ll)
    if (match)
      "echo "found: ".headtoday
      let cursor_pos = getpos(".")
      let cursor_line = cursor_pos[1]
      echo "cursor: ".cursor_line
      call append(cursor_line, '')
      call cursor(cursor_line+1,1)
      startinsert
"      exe cursor_line."put =\n"
    else
      echo "not found: ".headtoday
      let headtoday = headtoday . "\n"
      " put after line 1
      1put =headtoday
      " set cursor one line below
      call cursor(2, 1)
      startinsert
      normal! o
    endif
endfunction

function! OpenNotesOfTheDay()
  "let file = call system('find_notesoftheday.sh')
  "read! find_notesoftheday.sh  "works
  "execute '!find_notesoftheday.sh'
  " does not work yet
  let file = execute read! "/home/dennis/dotfiles/bin/find_notesoftheday.sh"
  let file = "asd"
  " workaround does not work yet
  "let file = $foundnotes
"  let file = read find_notesoftheday.sh
  echo "found:" .file

endfunction

      "normal! /headtoday
      "normal! o
"map <leader>x :e ~/buffer.adoc<cr>:call ScribbleIntro()<CR>
noremap <leader>x :e ~/buffer.adoc<cr>:call ScribbleIntro()<CR>



" Toggle paste mode on and off
noremap <leader>pp :setlocal paste!<cr>:setlocal paste?<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" copy current line and comment out original line (detect comment-sign for tp)
au! BufRead * call Commentswitch()
"let b:commentstr = ""
fun! Commentswitch()
  if len(&commentstring)>=1
    let b:commentstr=split(&commentstring, '%s')[0]
  endif
endfunction
nnoremap <leader>c :.t-1<CR>:exe ":normal i" . b:commentstr<CR>j<Esc>
" function! comment_str
" let comment=split(&commentstring, '%s')
"   if len(comment)==1
"     call add(comment, '')
"   endif
" endfunction
" insert something [https://unix.stackexchange.com/questions/8101/how-to-insert-the-result-of-a-command-into-the-text-in-vim]
" dynamic comment character [https://vi.stackexchange.com/questions/13028/how-can-i-return-the-current-filetypes-comment-character-in-vimscript]


function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("Ag \"" . l:pattern . "\" " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Clear all registers.
function! ClearRegisters()
    let regs='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-="*+'
    let i=0
    while (i<strlen(regs))
        exec 'let @'.regs[i].'=""'
        let i=i+1
    endwhile
endfunction
 
command! ClearRegisters call ClearRegisters()

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""
" Maintainer: 
"       Amir Salihefendic
"       http://amix.dk - amix@amix.dk
"
" Version: 
"       5.0 - 29/05/12 15:43:36
"
" Blog_post: 
"       http://amix.dk/blog/post/19691#The-ultimate-Vim-configuration-on-Github
"
" Awesome_version:
"       Get this config, nice color schemes and lots of plugins!
"
"       Install the awesome version from:
"
"           https://github.com/amix/vimrc
"
" Syntax_highlighted:
"       http://amix.dk/vim/vimrc.html
"
" Raw_version: 
"       http://amix.dk/vim/vimrc.txt
"
"""""""""""""""""""""""""""""""""""""""""""


"" Statusline color
set laststatus=2

function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi StatusLine ctermfg=white ctermbg=darkgreen
    " w/o cterm=bold?
    hi StatusLine guifg=white guibg=seagreen gui=bold
    set cursorline
  elseif a:mode == 'r'
    hi statusline ctermbg=darkblue cterm=bold
    hi statusline guibg=lightblue gui=bold
    set cursorline
  else
    !echo "in Else!"
    hi statusline ctermbg=grey ctermfg=blue
    set cursorline
  endif
endfunction

au InsertLeave * call ColorNorm()
au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertChange * call InsertStatuslineColor(v:insertmode)

"inoremap <c-c> <c-o>:call InsertLeaveActions()<cr><c-c>

func! ColorNorm()
  "hi statusline ctermfg=7* ctermbg=8 term=NONE cterm=NONE
  " term necessary for urxvt as terminal?
  " cterm=undercurl,bold
  hi statusline ctermfg=7 ctermbg=black cterm=NONE term=NONE
  hi statusline guifg=white guibg=DarkBlue gui=NONE guisp=NONE
  set nocursorline
endfunction

call ColorNorm()
