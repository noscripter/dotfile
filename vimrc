set nu
syntax on
"set list
set ffs=unix,dos,mac
set hlsearch
set incsearch
nnoremap <Leader>2 :set tabstop=2  softtabstop=2 shiftwidth=2<CR>
nnoremap <Leader>4 :set tabstop=4  softtabstop=4 shiftwidth=4<CR>
set tabstop=4  softtabstop=4 shiftwidth=4
set fileencodings=utf-8,gbk,utf-16le,cp1252,iso-8859-15,ucs-bom
set fileformats=unix,dos,mac
nnoremap <Leader>eg :e ++enc=gbk<CR>
nnoremap <Leader>eu :e ++enc=utf8<CR>
set backspace=indent,eol,start
set clipboard+=unnamed
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufRead,BufNewFile *.json setf json
autocmd BufNewFile,BufReadPost *.xtpl set filetype=html
au BufNewFile,BufRead *.vm set ft=velocity
au BufNewFile,BufRead *.xtpl set ft=html
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xtpl set ft=html
autocmd BufNewFile,BufRead *.rss,*.atom setfiletype xml
autocmd Filetype make set noexpandtab
autocmd Filetype yaml set expandtab
autocmd FocusGained, BufEnter * :silent! !
autocmd FileType python syn keyword pythonDecorator True None False self
autocmd BufNewFile,BufRead *.jinja set syntax=htmljinja
autocmd BufNewFile,BufRead *.mako set ft=mako
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufNewFile,BufRead *.bat,*.sys setf dosbatch
autocmd BufNewFile,BufRead *.cmd if getline(1) =~ '^/\*' | setf rexx | else | setf dosbatch | endif
au! BufRead,BufNewFile *.bat if getline(1) =~ '--\*-Perl-\*--' | setf perl | endif
au! BufNewFile,BufRead *.btm call s:FTbtm()
set viminfo^=%
function! s:FTbtm()
  if exists("g:dosbatch_syntax_for_btm") && g:dosbatch_syntax_for_btm
    setf dosbatch
  else
    setf btm
  endif
endfunction
set nobackup
set noswapfile
set nowritebackup
set iskeyword-=_
set foldmethod=indent
set expandtab
colorscheme desert
set guifont=Inconsolata-dz\ for\ Powerline:h16
set autoread
set wildignore=*.o,*~,*.pyc
set guioptions-=r
set guioptions-=l
set guioptions-=R
set guioptions-=L
if has("win16") || has("win32")
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif
set backspace=eol,start,indent
syntax enable
set smarttab
set textwidth=80
set autoindent
set smartindent
set paste
"autocmd GUIEnter * set fullscreen
if has("gui_macvim")
    set fuoptions=maxvert,maxhorz
endif
set cursorcolumn
set cursorline
set autochdir
hi ColorColumn ctermbg=red guibg=red
set colorcolumn=+1
set foldlevelstart=99

nnoremap <leader>f :%!js-beautify -j -q -B -f -<CR>
au FileType json setlocal equalprg=python\ -mjson.tool
nmap <c-s> :w<CR>

command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction

function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts.' '
    echon 'shiftwidth='.&l:sw.' '
    echon 'softtabstop='.&l:sts.' '
    if &l:et
      echon ' expandtab'.' '
    else
      echon ' noexpandtab'.' '
    endif
  finally
    echohl None
  endtry
endfunction

function! GuiTabLabel()
  let label = ''
  let bufnrlist = tabpagebuflist(v:lnum)
  " Add '+' if one of the buffers in the tab page is modified
  for bufnr in bufnrlist
    if getbufvar(bufnr, "&modified")
      let label = '+'
      break
    endif
  endfor
  " Append the tab number
  let label .= v:lnum.': '
  " Append the buffer name
  let name = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
  if name == ''
    " give a name to no-name documents
    if &buftype=='quickfix'
      let name = '[Quickfix List]'
    else
      let name = '[No Name]'
    endif
  else
    " get only the file name
    let name = fnamemodify(name,":t")
  endif
  let label .= name
  " Append the number of windows in the tab page
  let wincount = tabpagewinnr(v:lnum, '$')
  return label . '  [' . wincount . ']'
endfunction
set guitablabel=%{GuiTabLabel()}
