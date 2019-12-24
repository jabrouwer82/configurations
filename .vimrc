" This is a huge hybrid of content from defaults.vim and various online sources that solve all sorts of individual
" issues I've experienced in my personal workflow. I've attempted to comment most lines to explain their purpose,
" but some magic has been lost to search history on computers I haven't owned for years.

" Display files as utf-8.
set encoding=utf-8
" Sets this file to be read as utf-8.
scriptencoding=utf-8

" Turns syntax highlighting on.
syntax on

if system('uname') ==# "Darwin\n"
  " Use ligatures
  set macligatures
  
  " Sets my font.
  set guifont=Hasklug\ Nerd\ Font:h11
  
  function! Batterypercent()
    let g:batterypercent = system('pmset -g batt | grep -Eo "\d+%" | cut -d% -f1')[:-2]
  endfunction
else
  " Sets my font.
  set guifont=Hasklug\ Nerd\ Font\ 11

  " This should really check the existance of a battery ior something.
  " I'll worry about it when I get a linux laptop.
  function! Batterypercent()
    let g:batterypercent = "100"
  endfunction
endif

" Crap to make 24bit color work in terminals, these need to be adjusted per terminal.
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Allows truecolor settings, but requires use of guifg/guibg theme settings.
set termguicolors

" My custom color scheme, located at ~/.vim/colors/jacob.vim
colorscheme jacob

" Removes macvim/gvim scrollbars.
set guioptions=

" Displays tabs, nbsps, and trailing spaces with printable characters.
set list listchars=tab:▸\ ,nbsp:·,trail:–
" Shows a fancy arrow on wrapped lines.
set showbreak=↪\ 

" Vim will automatically save files when moving between buffers.
" This is pretty safe because all edit history is persisted, so it's still easy to undo changes if a buffer gets closed.
set autowrite
set autowriteall

" Automatically reread a file if some other process writes to it.
" Useful for editing files in a full IDE or other vim sessions simultaneously.
set autoread

" Highlights a cross over the cursor.
" Some highlighting gets a little strange due to my theme.
set cursorline
set cursorcolumn

" Always display the sign column, used by coc, ale, and gitgutter to display changes, errors, and warning.
set signcolumn=yes

" Automatic filetype detection.
filetype plugin indent on

" Use syntax highlighting to inform where folds occur.
set foldmethod=syntax
" Starts with everything unfolded
set foldlevel=99

" Pressing <Tab> in Insert mode will insert literal spaces instead of a tab character.
set expandtab
" These are reinforced for some filetypes in an autogroup later.
" A tab is two spaces.
set tabstop=2
" Use two spaces for autoindents.
set shiftwidth=2
" Also sets tabs to be inserted as 2 spaces.
set softtabstop=2

" Sets vim to not automatically insert newlines in long lines.
" This is the default value.
set textwidth=0

" These shorten the timeout for mappings, which allows the Terminal mapping for Esc to act almost like Insert mode Esc.
" Without these, arrow keys don't work in TerminalNormal mode.
set timeout
set ttimeout
" Lower this value for quicker but harder to use mappings.
set timeoutlen=300
" Make this as low as you want/can?
set ttimeoutlen=100

" Shows '@@@' in the number column if the last line is truncated.
set display=truncate

" Shows searches in real time.
set incsearch
" Highlights search matches.
set hlsearch

" Uses the ColorColumn highlight group to display a red column at the 121st column.
set colorcolumn=121

" The cursor position is already in my airline theme, no need for it to be set here.
set noruler

" Show the statusline for unfocused windows.
set laststatus=2
" This is pretty specific to some airline settings.
" Mode > filename[edit settings]  filetype < encoding < % cursor position < ale/coc stuff
set statusline=%#error#%a\ %*\ %<%.99f\ %h%w%#error#%m%*%#error#%r%*%y%=%-16(\ %l/%L,%c%V\ %)%P

" Makes vim use the system clipboard for yank and paste.
set clipboard=unnamed

" Enforces 5 lines of space between the cursor and the top/bottom of a window.
set scrolloff=5

" Persist undo changes to disk
set undofile
" Location of undo files.
set undodir=$VIM_TMP_DIR/undo//

" Number of undos to save.
set undolevels=10000
" If the files is less then 10000 lines, this will store the file for undo when reloading (autoread, :e, etc).
set undoreload=10000

" Location of swap files.
set directory=$VIM_TMP_DIR/dir//

" Write a duplicate file out when overwriting a file.
" Makes saving stupidly slow in some cases.
set backup
" Location of said backups.
set backupdir=$VIM_TMP_DIR/back//

" Allow backspacing over everything.
set backspace=indent,eol,start

" Keep a much longer history (this is the max at time of writing).
set history=10000

" Show incomplete commands.
set showcmd

" Fancy tab completion for : commands.
set wildmenu

" Searches will ignore case, use \C in searches for case sensitive searches.
set ignorecase

" Bizarro fix for tmux mouse scrolling.
set mouse=a

" I think this is off as a security measure, but I'm not sure and don't see the point in the feature in the first place.
set nomodeline

" New windows (<C-w>n) will open below the current one.
set splitbelow
" New windows (<C-w>v) will open to the right of the current one.
set splitright

" After 300 millis of no edits, a swap file will be written.
" After 300 millis, the CursorHold event fires.
set updatetime=300
" Blocks "hit enter" prompts on completion menu actions.
set shortmess+=c
" Adds a second line to the cmd bar.
set cmdheight=2

" Shows absolute line number for cursor.
set number
" Shows relative line numbers for all other lines.
set relativenumber

" Stop vim from resizing windows.
set noequalalways

" Use a space for window dividers.
set fillchars+=vert:\ 

" Turn on spellchecker. Use zg to add word to dictionary.
set spell



" Environment:
" This makes it easy to do :term man <cmd>, less gets weird.
let $MANPAGER='cat'


" AUTOCMDS:
" A lot of these are FileType autocommands, which should really be located in ~/.vim/after/ftplugin/[ft].vim.

" Save the reltime that vim starts.
augroup starttime
  au VimEnter let g:start_time=reltime()
augroup end

" Disables the swap file if the file isn't modified.
augroup swpctrl
  au!
  autocmd CursorHold,BufWritePost,BufReadPost,BufLeave *
    \ if isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif
augroup end

" My backup/undo/swp files are in a git repo that gets a new commit every write.
augroup tmpbackup
  au!
  au BufWritePost,FileWritePost,VimLeave * call Backup_tmp_files()
augroup end

augroup listspell
  au!
  au FileType list setlocal nospell
augroup end

augroup vimresize
  au!
  au VimResized * wincmd =
augroup end

" <leader>= will fix ts/js comparisons ie === or !== rather than == or !=
augroup tsjsft
  au!
  au FileType typescript,javascript nnoremap <silent><buffer> <leader>= :s/\(=\\|!\)=\([^=]\)/\1==\2/g<CR>:noh<CR>
augroup end

" Make terminal-mode not wrap lines, because it does it wrong: https://github.com/vim/vim/issues/2865
" Also disable spell checking because it highlights stupid stuff like powerline glyphs.
" Suspend job output when leaving the buffer or window, so that the window fades correctly.
augroup termft
  au!
  au BufEnter,BufWinEnter *
    \ if &buftype=='terminal'
    \ |   setlocal nowrap
    \ |   setlocal nospell
    \ | endif
  " au FocusLost,WinLeave *
  "   \ if &buftype=='terminal' && mode() == 't'
  "   \ |   call feedkeys("\<C-\>\<C-N>", 'x')
  "   " \ |   call term_setsize('', term_getsize('')[0], term_getsize('')[1]+6)
  "   \ | endif
augroup end

" Allow escape in fzf windows.
augroup fzfft
  au!
  au FileType fzf tmap <buffer> <Esc> <Esc>
augroup end

" Easier closing of vim help menus.
augroup helpft
  au!
  au FileType help noremap <buffer> q :q<CR>
augroup end

" Easier closing of bufferized commands.
augroup bufferizeft
  au!
  au FileType bufferize noremap <buffer> q :q<CR>
augroup end

" Automatically write any updates in the current file when focus is lost.
augroup focuslost
  au!
  au FocusLost * silent! update
augroup end

" Sets some custom settings per filetype.
augroup filetypestuff
  au!
  " Sets svgs to be treated like html.
  au BufEnter *.svg setlocal foldmethod=indent
  au BufEnter *.svg setf html

  " sbt files are just scala.
  au BufRead,BufNewFile *.sbt setf scala

  " There's not a language plugin for JSON5 (json with comments).
  au FileType json syntax match Comment +\/\/.\+$+

  " Some python/rust bullshit. Both language plugins override the obviously superior 2 space indentation.
  au FileType rust setlocal tabstop=2 softtabstop=2 shiftwidth=2
  au FileType python setlocal tabstop=2 softtabstop=2 shiftwidth=2

  " The vim language plugin overrides my setting.
  au FileType vim setlocal textwidth=0
augroup end

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid, when inside an event handler (happens when dropping a file on gvim) and
" for a commit message (it's likely a different one than last time).
augroup autocursorpos
  au!
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif
augroup END



" FUNCTIONS:

" Calls the script that backs up my backup/undo/swp.
let g:backup_time_delta=60*15
function! Backup_tmp_files()
  if !exists('g:last_backup_ts') || reltimefloat(reltime(g:last_backup_ts)) > g:backup_time_delta
    echom 'Backing up tmp files, this might take > 10 seconds...'
    call system('sh -c ' . $VIM_TMP_DIR . '/backup.sh > ' . $VIM_TMP_DIR . '/log.txt 2>&1')
    let g:last_backup_ts=reltime()
    " These two lines clear the message.
    echon "\r\r"
    echon ''
  endif
endfunction

" Allow saving of files as sudo when I forgot to start vim using sudo.
fun SuWrite()
  echo 'Sudo writing file' | silent write '!sudo tee "%" > /dev/null' | edit!
endfun

" These two functions allow me to use fzf for spell suggestions, which is much nicer than the default ui.
function! FzfSpellSink(word)
  exe 'normal! "_ciw'.a:word
endfunction

function! FzfSpell()
  let suggestions = spellsuggest(expand('<cword>'))
  return fzf#run({'source': suggestions, 'sink': function('FzfSpellSink'), 'down': 10 })
endfunction

" Creates a new window that will be at least 120 chars wide, no guarantee about height.
function! NewWindow()
  if winwidth('%') / 2 < 120
    wincmd n
  else
    wincmd v
  endif
endfunction


" COMMANDS:
" :W to use sudo to write a file.
command! W :call SuWrite()


" MAPPINGS:
let mapleader=';'

" - to open new terminal.
noremap - :term<CR>
" _ to open new terminal with given command.
noremap _ :term 
" \ to open new vertical terminal.
noremap <Bslash> :vert term<CR>
" | to open new vertical terminal with given command.
noremap <Bar> :vert term 

" <leader># or <leader>3 to go to alt buffer.
noremap <leader># <C-^>
noremap <leader>3 <C-^>

" Skip SpellLocal and SpellRare.
noremap [s [S
noremap ]s ]S

" Don't use Ex mode, use Q for formatting.
" Revert with ":unmap Q".
noremap Q gq

" Create new window.
" noremap <leader>w call NewWindow()

" Switch windows
noremap <leader><Up> :wincmd k<CR>
noremap <leader><Down> :wincmd j<CR>
noremap <leader><Left> :wincmd h<CR>
noremap <leader><Right> :wincmd l<CR>

" Move windows.
noremap <leader>J :wincmd J<CR>
noremap <leader>K :wincmd K<CR>
noremap <leader>H :wincmd H<CR>
noremap <leader>L :wincmd L<CR>

" Rotate windows.
noremap [r :wincmd r<CR>
noremap ]r :wincmd R<CR>

" Next/prev window.
noremap [w :wincmd w<CR>
noremap ]w :wincmd W<CR>

" <leader>n or <leader>- will create a new split below this one.
noremap <leader>n :wincmd n<CR>
noremap <leader>- :wincmd n<CR>

" <leader>v or <leader>\ or <leader>| will create a new split to the right of this one.
noremap <leader>v :wincmd v<CR>
noremap <leader><bslash> :wincmd v<CR>
noremap <leader><Bar> :wincmd v<CR>

" Esc to enter terminal normal mode
tnoremap <Esc> <C-\><C-n>

" Repeat the last : command
" noremap <leader>: @:

" [m ]m navigate marks.
noremap [m ['zz
noremap ]m ]'zz

" Deletes the on-disk file in the current buffer, but does not close to buffer in case it was an accident.
nnoremap <leader><Del> :call delete(expand('%:p'))<CR>

" Center the cursor when jumping to marks.
noremap <expr> ' "'" . nr2char(getchar()) . "zz"
noremap <expr> ` "`" . nr2char(getchar()) . "zz"

" Center the cursor when jumping between search matches.
noremap n nzz
noremap N Nzz

" Use ;/ to search this file for the current word/selection.
vnoremap <leader>/ y/<C-r>"<CR>
nnoremap <leader>/ /<C-r><C-w><CR>

" <leader>s will prepare a :s command for the current word/selection.
vnoremap <leader>s y:%s/<C-r>"\C/<C-r>"/g
nnoremap <leader>s :%s/<C-r><C-w>\C/<C-r><C-w>/g

" <leader>c to toggle comment.
nnoremap <leader>c :Commentary<CR>
vnoremap <leader>c :Commentary<CR>

" Lazy indentation decrementors.
vnoremap <leader>, <
nnoremap <leader>, <<
" Lazy indentation incrementors
nnoremap <leader>. >>
vnoremap <leader>. >

" <leader>== auto indents the whole file.
" Save current cursor location: 'mqHmw'
" Move back to old location and remove marks: '`w:delm w<CR>zt`q:delm q<CR>'
nnoremap <silent> <leader>== mqHmwgg=G`w:delm w<CR>zt`q:delm q<CR>:SignatureRefresh<CR>

" Pressing enter will clear search highlighting.
nnoremap <silent> <CR> :noh<CR>

" <leader>bd will use the bufkill plugin to close buffers and leave windows open.
nnoremap <leader>bd :BD!<CR>

" <leader>z will use winzoom to zoom and unzoom windows like tmux.
noremap <silent> <leader>z :ZoomWin<CR>

" ]t and [t for next/previous tab.
noremap ]t :tabn<CR>
noremap [t :tabp<CR>

" <leader>t to create new tab.
noremap <leader>t :tabnew<CR>
" <leader>tc to close the current tab.
noremap <leader>tc :tabc<CR>

" <leader>b to Bufferize a command.
noremap <leader>b :Bufferize 

" Use <leader><tab> in to get fzf spell suggestions.
nnoremap <leader><Tab> :call FzfSpell()<CR>

" Highlight debugging.
noremap <leader>` :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
  \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
  \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

  " For shenanigans.
" noremap <leader>r ggg?G``:set invspell<CR>

  " Smart Home, moves to the first non-whitespace character.
noremap <expr> <Home> col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
imap <Home> <C-O><Home>


" Vim-polyglot:
let g:polyglot_disabled = ['scala']

" PLUGINS:
" Auto-install vim-plug. This places probably too much trust in junegunn's github.
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup vimplug
    au!
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  augroup end
endif

call plug#begin('~/.vim/plugged')
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'yggdroot/indentline'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-characterize'
Plug 'gorodinskiy/vim-coloresque'
Plug 'airblade/vim-gitgutter'
Plug 'kshenoy/vim-signature'
Plug 'tpope/vim-unimpaired'
Plug 'w0rp/ale'
Plug 'tpope/vim-commentary'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'tpope/vim-fugitive'
Plug 'chrisbra/Recover.vim'
Plug 'gre/play2vim'
Plug 'sheerun/vim-polyglot'
Plug 'markonm/traces.vim'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'jeffkreeftmeijer/vim-numbertoggle'
" Plug 'TaDaa/vimade' " Fades inactive buffers.
Plug 'qpkorr/vim-bufkill'
Plug 'regedarek/zoomwin'
Plug 'andrewradev/bufferize.vim'
Plug 'airblade/vim-rooter'
Plug 'tjdevries/coc-zsh'
Plug 'tpope/vim-markdown'
Plug 'moll/vim-bbye' " Dep for vim-symlink.
Plug 'aymericbeaumet/vim-symlink' " Automatically follow symlinks.
Plug 'tpope/vim-surround' " cs/ds/ys/css/dss/yss to change/delete/surround a word/line.
Plug 'tpope/vim-repeat' " Allow . to work with (some) plugins.
Plug 'glts/vim-magnum' " Numeric library, dep for radical.
Plug 'glts/vim-radical' " gA, crd/crx/cro/crb for decimal/hex/octal/binary conversions.
Plug 'arthurxavierx/vim-caser' " Change cases.
Plug 'tommcdo/vim-fubitive' " Bitbucket plugin for fugitive
Plug 'tpope/vim-rhubarb' " Githug plugin for fugitive
Plug 'zplugin/zplugin-vim-syntax' " Syntax highlighting for zplugin.
" Plug 'roman/golden-ratio' " Automatically resize windows.
Plug 'jabrouwer82/vim-scala' " My customized version of derekwyatt/vim-scala.
call plug#end()

" Caser:
" gsm MixedCase
" gsc camelCase
" gs_ snake_case
" gsu UPPER_CASE
" gst Title Case
" gss Sentence case
" gs  space case
" gs- kebab-case
" gs. dot.case

" Yankstack:
" These have to use nmap rather than nnoremap.
nmap [p <Plug>yankstack_substitute_older_paste
nmap ]p <Plug>yankstack_substitute_newer_paste

" Indentline:
let g:indentLine_char = '▏'

" Rooter:
let g:rooter_patterns = ['build.sbt', '.git/', 'build.sc']
let g:rooter_silent_chdir = 1

" Html5:
let g:html5_event_handler_attributes_complete = 0

" Recover:
let g:RecoverPlugin_Delete_Unmodified_Swapfile = 1

" ALE:
"let g:ale_lint_on_text_changed = 'never'
let g:ale_python_pylint_options = '--rcfile ~/.pylintrc'
"let g:ale_scala_scalastyle_config = '/home/jbrouwer/personal/configurations/scalastyle.xml'
let g:ale_scala_scalastyle_options = '-w false -v true'
let g:ale_sh_shellcheck_options = '-e SC1090,SC2207'
let g:ale_typescript_tslint_config_path = '/home/jbrouwer/personal/configurations/tslint.json'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%]%[code]%[%severity%]: %s'
" The following delay the commands until after ALE loads, otherwise ALE overwrites them
augroup aledelayed
  au!
  autocmd VimEnter * nmap [l <Plug>(ale_previous_wrap)
  autocmd VimEnter * nmap ]l <Plug>(ale_next_wrap)
  autocmd VimEnter * hi link ALEErrorSign LintErrorSign
augroup end

" FZF:

let g:fzf_preview_base='bat --terminal-width $FZF_PREVIEW_COLUMNS --style full --color always'
let g:fzf_preview_range=' --line-range :$((FZF_PREVIEW_LINES-2)) '
let g:fzf_preview_sed=" | sed '1d;$d'"

let $FZF_PREVIEW_COMMAND=g:fzf_preview_base . g:fzf_preview_range . ' {} ' . g:fzf_preview_sed
let g:fzf_preview_buffers='farg={2}; ' . g:fzf_preview_base . g:fzf_preview_range . ' ${farg:s/~/$HOME} ' . g:fzf_preview_sed
" let g:fzf_preview_marks="l='{3}'; f='{4}'; fn=${f:s/~/$HOME}; fl=$(echo $(wc -l $fn) | cut -d' ' -f1); sl=$((0 < line-lines/2 ? line-lines/2 : 0)); el=$((fl < (sl + $FZF_PREVIEW_LINES) ? fl : (sl + $FZF_PREVIEW_LINES))); sl=$((endl-lines)); " . g:fzf_preview_base . '--line-range $((sl)):$((el)) --highlight-line $l $fn'
let g:fzf_preview_windows='farg={3..}; fn=${farg:s/> //}; ' . g:fzf_preview_base . g:fzf_preview_range . ' ${fn:s/~/$HOME} ' . g:fzf_preview_sed

command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
" TODO: It would be super cool if this could highlight the cursor position in the buffer.
command! -bar -bang -nargs=? -complete=buffer Buffers  call fzf#vim#buffers(
  \ <q-args>,
  \ {'options': ['--preview',  g:fzf_preview_buffers]},
  \ <bang>0
  \)
command! -bang -nargs=? GFiles call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)
" TODO: This doesn't highlight the correct line number.
command! -bang -nargs=* Rg call fzf#vim#grep(
  \ "rg --column --line-number --no-heading --color=always ".shellescape(<q-args>),
  \ 1,
  \ fzf#vim#with_preview(),
  \ <bang>0
  \)
command! -bar -bang Commands call fzf#vim#commands(<bang>0)
command! -bar -bang Marks call fzf#vim#marks(<bang>0)
command! -bar -bang Windows call fzf#vim#windows(
  \ {'options': ['--preview',  g:fzf_preview_windows]},
  \ <bang>0
  \)
command! -bar -bang Commits call fzf#vim#commits(<bang>0)
command! -bar -bang BCommits call fzf#vim#buffer_commits(<bang>0)
command! -bar -bang Maps call fzf#vim#maps("n", <bang>0)
command! -bang -nargs=* History call s:history(<q-args>, <bang>0)

noremap <C-p> :FZF<cr>
noremap <C-t> :FZF<cr>
noremap <leader><Space> :Files<CR>
noremap <leader><S-Space> :Files 
noremap <leader><CR> :Buffers<cr>
vnoremap <leader>rg y:Rg <C-r>"
nnoremap <leader>rg :Rg <C-r><C-w>
noremap <leader>g :GFiles?<cr>
noremap <leader>: :History:<CR>
noremap <leader>// :History/<CR>
noremap <leader>m :Maps<CR>
noremap <leader>w :Windows<CR>
noremap <leader>?? :Commits<CR>
noremap <leader>? :BCommits<CR>
noremap <leader>:: :Commands<CR>

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Json:
let g:vim_json_syntax_conceal = 0

" GitGutter:
hi link GitGutterAdd GitAddSign
hi link GitGutterChange GitChangeSign
hi link GitGutterDelete GitDeleteSign
hi link GitGutterChangeDelete GitChangeDeleteSign

let g:gitgutter_diff_base = 'origin/HEAD'

" Signature:
let g:SignatureMarkTextHLDynamic = 1

" Airline:
let g:airline_theme = 'jacob'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#keymap#enabled = 1
let g:airline_detect_spell=0
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
" let g:airline#extensions#tabline#fnamemod = ':t'
" Replaces the "tabs" label in the tabline with the abbreviated pwd.
augroup tablinecwd
  au!
  au DirChanged,VimEnter * let g:airline#extensions#tabline#tabs_label = pathshorten(fnamemodify(getcwd(), ":~"))
augroup end

" This chunk puts a clock and battery meter in the top right of the airline tabline.
call Batterypercent()

if exists('g:tablinetimer')
  call timer_stop(g:tablinetimer)
endif
let g:tablinetimer = timer_start(&updatetime, 'Tablineupdate', { 'repeat': -1 })

if exists('g:batterytimer')
  call timer_stop(g:batterytimer)
endif
let g:batterytimer = timer_start(&updatetime, 'Updatebattery')

function! Updatebattery(timer)
  call Batterypercent()
  if g:batterypercent < 2
    echom 'BATTERY VERY LOW'
    let g:batterytimer = timer_start(300, 'Updatebattery')
  elseif g:batterypercent < 10
    let g:batterytimer = timer_start(2000, 'Updatebattery')
  elseif g:batterypercent < 50
    let g:batterytimer = timer_start(60*1000, 'Updatebattery')
  else
    let g:batterytimer = timer_start(5*60*1000, 'Updatebattery')
  endif
endfunction

function! Tablineupdate(timer)
  let g:airline#extensions#tabline#buffers_label = strftime('%F %T') . ' |' . g:batterypercent . '%%|'
  call airline#util#doautocmd('BufMRUChange')
  call airline#extensions#tabline#redraw()
endfunction

" Coc:
let g:coc_global_extensions = [
  \ 'coc-metals',
  \ 'coc-vimlsp',
  \ 'coc-highlight',
  \ 'coc-yaml',
  \ 'coc-rls',
  \ 'coc-python',
  \ 'coc-json',
  \]


let g:coc_user_config = {
\  'coc.preferences.colorSupport': v:true,
\  'rust-client.rustupPath': '/Users/jbrouwer/.cargo/bin/rustup',
\}

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <CR> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for do codeAction of current line
nmap <leader>ac <Plug>(coc-codeaction)

" Remap for do action format
nnoremap <silent> F :call CocAction('format')<CR>

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap for rename current word
" Unsupported by metals
" nmap <leader>rn <Plug>(coc-rename)
" Use this for now:
nmap <silent> <leader>rn :call CocAction('runCommand', 'document.renameCurrentWord')<CR>



augroup coccustom
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Coc Vimlsp:
let g:markdown_fenced_languages = [
      \ 'vim',
      \ 'help'
      \]
