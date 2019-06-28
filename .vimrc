set encoding=utf-8
scriptencoding=utf-8

syntax on
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
colorscheme jacob
set list listchars=tab:\ \ ,trail:\ 
set autowriteall
set autoread
au FocusLost * !silent update

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
set signcolumn=yes

" Allow saving of files as sudo when I forgot to start vim using sudo.
fun SuWrite()
  silent write !sudo tee "%" > /dev/null
  edit!
endfun
com W :call SuWrite()

filetype plugin indent on
set foldmethod=syntax
set foldlevel=99 " Starts with everything unfolded
au BufEnter *.svg set foldmethod=indent
au BufEnter *.svg setf html
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set textwidth=0

let mapleader=';'

" Repeat the last : command
nnoremap <leader>; @:

" Save current cursor location: 'mqHmw'
" Move back to old location and remove marks: '`w:delm w<CR>zt`q:delm q<CR>'

" Forces moving to a mark or to the next/previous search to center the line.
nnoremap <expr> ' "'" . nr2char(getchar()) . "zz"
nnoremap <expr> ` "`" . nr2char(getchar()) . "zz"
nnoremap n nzz
nnoremap N Nzz

" Maps // and rg to search this file and the filesystem, respectively, for the
" highlighted word / word under the cursor
vnoremap <leader>/ y/<C-r>"<CR>
nnoremap <leader>/ /<C-r><C-w><CR>
vnoremap <leader>s y:%s/<C-r>"\C/<C-r>"/g
nnoremap <leader>s :%s/<C-r><C-w>\C/<C-r><C-w>/g
vnoremap rg y:Rg <C-r>"<CR>
nnoremap rg :Rg <C-r><C-w><CR>
vnoremap <expr> <leader>w "xi" . nr2char(getchar()) . "<esc>pa" . nr2char(getchar()) . "<esc>"
nnoremap <expr> <leader>w "diwi" . nr2char(getchar()) . "<esc>pa" . nr2char(getchar()) . "<esc>"

" Switches quote types
nnoremap <leader>' :s/["`]/'/g<CR>:noh<CR>
vnoremap <leader>' :s/["`]/'/g<CR>:noh<CR>
nnoremap <leader>" :s/['`]/"/g<CR>:noh<CR>
vnoremap <leader>" :s/['`]/"/g<CR>:noh<CR>
nnoremap <leader>` :s/['"]/`/g<CR>:noh<CR>
vnoremap <leader>` :s/['"]/`/g<CR>:noh<CR>

" Switches UPPER and lower case
nnoremap <leader>c guiw
vnoremap <leader>c u
nnoremap <leader>C gUiw
vnoremap <leader>C U

" Stupid indentation inc/decremenors
vnoremap <leader>, <
nnoremap <leader>, <<
nnoremap <leader>. >>
vnoremap <leader>. >

" For making ts/js comparisions === or !== rather than == or !=
nnoremap <silent> s= :s/\(=\\|!\)=\([^=]\)/\1==\2/g<CR>:noh<CR>
vnoremap <silent> s= :s/\(=\\|!\)=\([^=]\)/\1==\2/g<CR>:noh<CR>

" Auto indent the whole file
nnoremap <silent> <leader><tab> mqHmwgg=G`w:delm w<CR>zt`q:delm q<CR>:SignatureRefresh<CR>

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
set backup
set undofile
set undolevels=1000
set undoreload=10000

set undodir=$HOME/.tmp/vim/undo
set directory=$HOME/.tmp/vim/dir
set backupdir=$HOME/.tmp/vim/back
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
nnoremap <silent> <CR> :noh<CR>

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
Plug 'edkolev/tmuxline.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-characterize'
Plug 'gorodinskiy/vim-coloresque'
Plug 'tkhren/vim-fake'
Plug 'airblade/vim-gitgutter'
Plug 'ivanov/vim-ipython', { 'for': 'py' }
Plug 'kshenoy/vim-signature'
Plug 'tpope/vim-unimpaired'
Plug 'w0rp/ale'
Plug 'tpope/vim-commentary'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'garbas/vim-snipmate'
Plug 'hlissner/vim-multiedit'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-fugitive'
Plug 'chrisbra/Recover.vim'
Plug 'gre/play2vim'
Plug 'sheerun/vim-polyglot'
Plug 'markonm/traces.vim'
call plug#end()

" html5.vim
let g:html5_event_handler_attributes_complete = 0

" Recover
let g:RecoverPlugin_Delete_Unmodified_Swapfile = 1

" vim-multiline
let g:multiedit_mark_character = '>'
" Insert a disposable marker after the cursor
nmap <leader>ma :MultieditAddMark a<CR>
" Insert a disposable marker before the cursor
nmap <leader>mi :MultieditAddMark i<CR>
" Make a new line and insert a marker
nmap <leader>mo o<Esc>:MultieditAddMark i<CR>
nmap <leader>mO O<Esc>:MultieditAddMark i<CR>
" Insert a marker at the end/start of a line
nmap <leader>mA $:MultieditAddMark a<CR>
nmap <leader>mI ^:MultieditAddMark i<CR>
" Make the current selection/word an edit region
vmap <leader>m :MultieditAddRegion<CR>
nmap <leader>mm viw:MultieditAddRegion<CR>
" Restore the regions from a previous edit session
nmap <leader>mu :MultieditRestore<CR>
" Move cursor between regions n times
map ]m :MultieditHop 1<CR>
map [m :MultieditHop -1<CR>
" Start editing!
nmap <leader>M :Multiedit<CR>
" Clear the word and start editing
nmap <leader>C :Multiedit!<CR>
" Unset the region under the cursor
nmap <silent> <leader>md :MultieditClear<CR>
" Unset all regions
nmap <silent> <leader>mr :MultieditReset<CR>

" ALE
"let g:ale_lint_on_text_changed = 'never'
let g:ale_python_pylint_options = '--rcfile ~/.pylintrc'
let g:ale_scala_scalastyle_config = '/home/jabrouwer/personal/configurations/scalastyle.xml'
let g:ale_scala_scalastyle_options = '-w false -v true'
let g:ale_sh_shellcheck_options = '-e SC1090,SC2207'
let g:ale_typescript_tslint_config_path = '/home/jabrouwer/personal/configurations/tslint.json'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%]%[code]%[%severity%]: %s'
" The following delay the commands until after ALE loads, otherwise ALE overwrites them
autocmd VimEnter * nmap [l <Plug>(ale_previous_wrap)
autocmd VimEnter * nmap ]l <Plug>(ale_next_wrap)
autocmd VimEnter * hi link ALEErrorSign LintErrorSign

" fzf
" Maps Ctrl-t and Ctrl-p to open fzf
map <C-p> :FZF<cr>
map <C-t> :FZF<cr>

" vim-json
let g:vim_json_syntax_conceal = 0

" GitGutter
hi link GitGutterAdd GitAddSign
hi link GitGutterChange GitChangeSign
hi link GitGutterDelete GitDeleteSign
hi link GitGutterChangeDelete GitChangeDeleteSign

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
