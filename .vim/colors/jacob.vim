set background=dark
exe 'hi clear'
if exists('syntax_on')
 syntax reset
endif
let g:colors_name = 'jacob'

" Text:
exe 'hi Comment guifg=' . $jgrey
exe 'hi SpecialComment guifg=' . $jblue

exe 'hi Constant guifg=' . $jpurple
exe 'hi String guifg=' . $jmagenta
exe 'hi Character guifg=' . $jred
exe 'hi SpecialChar guifg=' . $jgrey
exe 'hi Number guifg=' . $jlpurple
exe 'hi Float guifg=' . $jlpurple
exe 'hi Boolean guifg=' . $jpurple

exe 'hi Identifier guifg=' . $jblue
exe 'hi Function guifg=' . $jlblue

exe 'hi Statement guifg=' . $jlyellow
exe 'hi Conditional guifg=' . $jlorange
exe 'hi Repeat guifg=' . $jlorange
exe 'hi Label guifg=' . $jyellow
exe 'hi Operator guifg=' . $jlorange
exe 'hi Keyword guifg=' . $jlyellow
exe 'hi Exception guifg=' . $jlred

exe 'hi PreProc guifg=' . $jlcyan
exe 'hi Include guifg=' . $jcyan
exe 'hi Define guifg=' . $jlcyan . ' guibg=' . $jlred
exe 'hi Macro guifg=' . $jcyan
exe 'hi PreCondit guifg=' . $jlcyan . ' guibg=' . $jlred

exe 'hi Type guifg=' . $jlgreen . ' gui=NONE'
exe 'hi StorageClass guifg=' . $jlgreen . ' guibg=' . $jlred
exe 'hi Structure guifg=' . $jlgreen . ' guibg=' . $jlred
exe 'hi Typedef guifg=' . $jgreen

exe 'hi Special guifg=' . $jgrey
exe 'hi Delimiter guifg=' . $jgrey
exe 'hi Tag guifg=' . $jlcyan . ' guibg=' . $jlred
exe 'hi Debug guifg=' . $jcyan . ' guibg=' . $jlred

exe 'hi EndOfBuffer guifg=' . $jmagenta
exe 'hi Error guibg=' . $jlred . ' guifg=' . $jwhite
exe 'hi Folded guibg=' . $jdgreen . ' guifg=' . $jwhite
exe 'hi Ignore guifg=' . $jblack
exe 'hi NonText guifg=' . $jlmagenta . ' gui=bold'
exe 'hi Normal guifg=' . $jlgrey . ' guibg=' . $jblack
exe 'hi Search guifg=' . $jblack . ' guibg=' . $jlyellow
exe 'hi SpecialKey guibg=' . $jdred . ' guifg=' . $jlred
exe 'hi Title guifg=' . $jlpurple . ' gui=bold'
exe 'hi Todo guifg=' . $jlyellow . ' guibg=NONE gui=undercurl,bold'

" HTML:
hi link htmlEndTag htmlTag

" Spell:
exe 'hi SpellBad guisp=' . $jlred
hi clear SpellLocal
hi clear SpellRare
hi clear SpellCap

" GUI:
exe 'hi ColorColumn guibg=' . $jvdred
exe 'hi CursorColumn guibg=' . $jdgrey
exe 'hi CursorLine gui=bold guibg=' . $jdgrey
exe 'hi CursorLineNR gui=bold guifg=' . $jlblue . ' guibg=NONE'
exe 'hi LineNR guifg=' . $jlgrey . ' guibg=NONE'
exe 'hi StatusLine gui=NONE guifg=' . $jpurple . ' guibg=' . $jdgrey
exe 'hi StatusLineTerm gui=NONE guifg=' . $jpurple . ' guibg=' . $jdgrey
exe 'hi StatusLineTermNC guibg=' . $jlblue
" This should keep the vertical split highlight synced with airline, but it doesn't work for insert mode.
" hi! link VertSplit airline_a
exe 'hi VertSplit guibg=' . $jblue . ' guifg=' . $jblue
exe 'hi WildMenu gui=bold guifg=' . $jlyellow . ' guibg=' . $jdgrey

" Git Column:
exe 'hi GitAddSign guifg=' . $jgreen . ' gui=bold'
exe 'hi GitChangeSign guifg=' . $jlblue . ' gui=bold'
exe 'hi GitDeleteSign guifg=' . $jlred . ' gui=bold'
exe 'hi GitChangeDeleteSign guifg=' . $jpurple . ' gui=bold'

" ALE Colors:
exe 'hi ALEWarningSign guifg=' . $jlyellow . ' guibg=NONE'
exe 'hi ALEWarning guifg=NONE guibg=NONE'
exe 'hi LintErrorSign guifg=' . $jlred . ' gui=bold'

" Coc Colors:
exe 'hi Pmenu guibg=' . $jdblue
exe 'hi PmenuSel guifg=' . $jdgrey
exe 'hi CocHighlightText gui=underline'

" Terminal Ansi Colors:
let g:terminal_ansi_colors = [
  \ $jblack, $jred, $jgreen, $jyellow, $jblue, $jpurple, $jcyan, $jlgrey,
  \ $jgrey, $jlred, $jlgreen, $jlyellow, $jlblue, $jlpurple, $jlcyan, $jwhite,
  \]

" Space Display And Highlighting:
" exe 'hi TrailingSpaces guibg=' . $jdred
" exe 'hi DoubleSpaces guibg=' . $jdred
" augroup spaces
"   au!
"   au BufReadPost,BufNewFile * exe 'hi DoubleSpaces guibg=' . $jdred
"   au BufReadPost,BufNewFile routes hi DoubleSpaces guibg=NONE
" augroup end
" call matchadd('TrailingSpaces', '\s\+$', 100)
" call matchadd('DoubleSpaces', '\S\zs\s\{2,}', 100)

