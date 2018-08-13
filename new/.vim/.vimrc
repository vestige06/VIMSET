filetype plugin on
syntax enable
execute pathogen#infect()
silent! call repeat#set("\<Plug>surround", v:count)

:set nu

fun! DeleteAllBuffersInWindow()
    let s:curWinNr = winnr()
    if winbufnr(s:curWinNr) == 1
        ret
    endif
    let s:curBufNr = bufnr("%")
    exe "bn"
    let s:nextBufNr = bufnr("%")
    while s:nextBufNr != s:curBufNr
        exe "bn"
        exe "bdel ".s:nextBufNr
        let s:nextBufNr = bufnr("%")
    endwhile
endfun

function! UpdateCtags()
    let curdir=getcwd()
    while !filereadable("./tags")
        cd ..
        if getcwd() == "/"
            break
        endif
    endwhile
    if filewritable("./tags")
        !ctags -R --file-scope=yes --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --c++-kinds=+p --fields=+iaS --extra=+q
        TlistUpdate
    endif
    execute ":cd " . curdir
endfunction


autocmd BufWritePost *.c,*.h,*.cpp call UpdateCtags()

map <F12> :!xelatex  %<CR>

map <F2> :buffers<CR>
map <Left> :bp<CR>
map <Right> :bn<CR>

"F3 F4 is for format html indent
map <F3> :filetype indent on<CR> :set ft=html<CR> :set smartindent<CR>
map <F4> :filetype indent on<CR> :set ft=php<CR> :set smartindent<CR>

map <Leader> <Plug>(easymotion-prefix)

" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)


"remove all buffer 
map <Leader>ba :call DeleteAllBuffersInWindow()

autocmd! bufwritepost $HOME/.vimrc source %

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

colorscheme CandyPaper


let g:livepreview_previewer = 'okular'

let g:livepreview_engine = 'xelatex'
