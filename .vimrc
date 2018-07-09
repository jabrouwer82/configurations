set nocompatible

execute pathogen#infect()

syntax on
set t_Co=256
colorscheme elflord
set list listchars=tab:\ \ ,trail:\ 
highlight SpecialKey ctermbg=Yellow guibg=Yellow

set relativenumber
set nu
set cursorline
set cursorcolumn
hi LineNR ctermbg=none ctermfg=gray
hi CursorLine cterm=bold ctermbg=235
hi CursorLineNR cterm=bold ctermbg=none ctermfg=lightblue
hi CursorColumn cterm=bold ctermbg=235

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
"" Remaps q to close to stop accidental clsoing windows
" cabbrev q <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'close' : 'q')<CR>
filetype plugin indent on
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set textwidth=0

" Some python bullshit.
function! SetupPython()
    setlocal softtabstop=2
    setlocal tabstop=2
    setlocal shiftwidth=2
endfunction
command! -bar SetupPython call SetupPython()

set incsearch
set hlsearch

"set foldmethod=indent

set colorcolumn=121
hi ColorColumn ctermbg=darkgrey

set noruler
set laststatus=2
set statusline=%#error#%a\ %*\ %<%.99f\ %h%w%#error#%m%*%#error#%r%*%y%=%-16(\ %l/%L,%c%V\ %)%P
hi StatusLine ctermfg=6 ctermbg=0 cterm=NONE

set scrolloff=5
set undofile
set directory=~/.local/tmp,/var/tmp,/tmp
set backspace=indent,eol,start

set ignorecase
set list
set listchars=tab:▸\

set clipboard=unnamedplus
" Set y to use system buffer by default
":nnoremap <expr> y (v:register ==# '"' ? '"+' : '') . 'y'
":nnoremap <expr> yy (v:register ==# '"' ? '"+' : '') . 'yy'
":nnoremap <expr> Y (v:register ==# '"' ? '"+' : '') . 'Y'
":xnoremap <expr> y (v:register ==# '"' ? '"+' : '') . 'y'
":xnoremap <expr> Y (v:register ==# '"' ? '"+' : '') . 'Y'

" Set p to use system buffer by default
":nnoremap <expr> p (v:register ==# '"' ? '"+' : '') . 'p'
":nnoremap <expr> P (v:register ==# '"' ? '"+' : '') . 'P'
":xnoremap <expr> p (v:register ==# '"' ? '"+' : '') . 'p'
":xnoremap <expr> P (v:register ==# '"' ? '"+' : '') . 'P'

" Set d to use blackhole buffer by deafult
":nnoremap <expr> d (v:register ==# '"' ? '"_' : '') . 'd'
":nnoremap <expr> dd (v:register ==# '"' ? '"_' : '') . 'dd'
":nnoremap <expr> D (v:register ==# '"' ? '"_' : '') . 'D'
":xnoremap <expr> d (v:register ==# '"' ? '"_' : '') . 'd'
":xnoremap <expr> D (v:register ==# '"' ? '"_' : '') . 'D'

" Tab shit
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

highlight StatusLine ctermfg=cyan guiFg=cyan

" Bizaro fix for tmux mouse scrolling
set mouse=a

" Hit enter again after entering a search to clear the highlighting
nnoremap <CR> :noh<CR><CR>

set directory=~/.local/tmp,/var/tmp,/tmp
set backupdir=~/.local/tmp,/var/tmp,/tmp
set undodir=~/.local/tmp,/var/tmp,/tmp

set nomodeline

" Space display and highlighting
"set list
"set listchars=space:·
"highlight SpecialKey ctermfg=darkgrey ctermbg=none
highlight DoubleSpaces ctermbg=red
highlight TrailingSpaces ctermbg=red
call matchadd('DoubleSpaces', '\S\zs\s\s\s*', 100)
call matchadd('TrailingSpaces', '\s\+$', 100)

" GitGutter
highlight GitGutterAdd ctermbg=none ctermfg=028 cterm=bold
highlight GitGutterChange ctermbg=none ctermfg=226 cterm=bold
highlight GitGutterDelete ctermbg=none ctermfg=196 cterm=bold
highlight GitGutterChangeDelete ctermbg=none ctermfg=208 cterm=bold
let g:gitgutter_diff_base = "origin/HEAD"


" Signature
let g:SignatureMarkTextHLDynamic = 1

" Ctrl P
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_arg_map = 1
let g:ctrlp_by_filename = 1
" let g:ctrlp_custom_ignore = '\v[\/](target)(\.(sqp|ico|git|svn))$'

" air-line
let g:airline_theme = 'simple'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#keymap#enabled = 1
