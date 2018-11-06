set encoding=utf-8
scriptencoding=utf-8

syntax on
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
colorscheme jacob
set list listchars=tab:\ \ ,trail:\ 

" Commands
":command JDeleteEmptyLines g/^\s*$/d
":command JFixOpenBraces %s/\n *{/ {/
":command JFixIfs %s/if ( \(.*\) )/if (\1)/
":command JRemoveTrailingSpaces %s/\s*$//

set number
" Enabled relative number for non-insert mode files with focus
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
set cursorline
set cursorcolumn

" Allow saving of files as sudo when I forgot to start vim using sudo.
com W w !sudo tee "%" > /dev/null

filetype plugin indent on
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set textwidth=0

" Wrap stuff in brackets, quotes, etc
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $4 <esc>`>a><esc>`<i<<esc>
vnoremap $5 <esc>`>a"<esc>`<i"<esc>
vnoremap $6 <esc>`>a'<esc>`<i'<esc>
vnoremap $7 <esc>`>a`<esc>`<i`<esc>

" Maps // and rg to search this file and the filesystem, respectively, for the
" highlighted word / word under the cursor
vnoremap // y/<C-R>"<CR>
nnoremap // /<C-r><C-w><CR>
vnoremap rg y:Rg <C-R>"<CR>
nnoremap rg :Rg <C-r><C-w><CR>

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

set noruler
set laststatus=2
set statusline=%#error#%a\ %*\ %<%.99f\ %h%w%#error#%m%*%#error#%r%*%y%=%-16(\ %l/%L,%c%V\ %)%P

set scrolloff=5
set undofile
set directory=~/.local/tmp,/var/tmp,/tmp
set backspace=indent,eol,start

set ignorecase
set list
set listchars=tab:▸\

set clipboard=unnamedplus

" Tab shit
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

" Bizaro fix for tmux mouse scrolling
set mouse=a

" Hit enter again after entering a search to clear the highlighting
nnoremap <CR> :noh<CR><CR>

set directory=~/.local/tmp,/var/tmp,/tmp
set backupdir=~/.local/tmp,/var/tmp,/tmp
set undodir=~/.local/tmp,/var/tmp,/tmp

set nomodeline

source ~/.vim/Dec2hex.vim

" Auto-install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug '/usr/share/fzf'
Plug 'junegunn/fzf.vim'
Plug 'yggdroot/indentline'
Plug 'chrisbra/recover.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'leafgarland/typescript-vim', { 'for': 'ts' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-characterize'
Plug 'gorodinskiy/vim-coloresque'
Plug 'tkhren/vim-fake'
Plug 'airblade/vim-gitgutter'
Plug 'ivanov/vim-ipython', { 'for': 'py' }
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'groenewege/vim-less', { 'for': 'less' }
Plug 'derekwyatt/vim-scala', { 'for': 'scala' }
Plug 'kshenoy/vim-signature'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-haml', { 'for': 'sass' }
Plug 'w0rp/ale'
Plug 'tpope/vim-commentary'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'garbas/vim-snipmate'
Plug 'terryma/vim-multiple-cursors'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'tpope/vim-markdown'
Plug 'vim-scripts/nginx.vim'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-fugitive'
call plug#end()

" ALE
let g:ale_lint_on_text_changed = 'never'
let g:ale_python_pylint_options = '--rcfile ~/.pylintrc'
let g:ale_scala_scalastyle_config = '/home/jabrouwer/personal/configurations/scalastyle.xml'
let g:ale_scala_scalastyle_options = '-w false -v true'
let g:ale_sh_shellcheck_options = '-e SC1090,SC2207'
autocmd VimEnter * nmap [l <Plug>(ale_previous_wrap)
autocmd VimEnter * nmap ]l <Plug>(ale_next_wrap)

" fzf
" Maps Ctrl-t to open fzf
map <C-p> :FZF<cr>

" vim-json
let g:vim_json_syntax_conceal = 0

" GitGutter
highlight GitGutterAdd guibg=NONE guifg=#00AF00 cterm=bold
highlight GitGutterChange guibg=NONE guifg=#00AFFF cterm=bold
highlight GitGutterDelete guibg=NONE guifg=#D70000 cterm=bold
highlight GitGutterChangeDelete guibg=NONE guifg=#AF00FF cterm=bold
let g:gitgutter_diff_base = 'origin/HEAD'

" Signature
let g:SignatureMarkTextHLDynamic = 1

" air-line
let g:airline_theme = 'simple'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#keymap#enabled = 1

" Fake
call fake#define('nonsentence', 'fake#capitalize('
                        \ . 'join(map(range(fake#int(3,15)),"fake#gen(\"nonsense\")"))'
                        \ . ' . fake#chars(1,"..............!?"))')
call fake#define('lorem', 'join(map(range(fake#int(3,10)),"fake#gen(\"nonsentence\")"))')
com Lorem exe "normal! i" . "<p>" . fake#gen("lorem") . "</p>"
