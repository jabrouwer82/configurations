set background=dark
exe "hi clear"
if exists('syntax_on')
 syntax reset
endif
let g:colors_name = 'jacob'

let $jblack="#00080A"
let $jwhite="#E4FDFD"

let $jdgrey="#252A2d"
let $jgrey="#6B7A82"
let $jlgrey="#B1CBD7"

let $jdblue="#0D3D55"
let $jblue="#1A7DAA"
let $jlblue="#28B8FF"

let $jdcyan="#165550"
let $jcyan="#2CAAA0"
let $jlcyan="#42FFF0"

let $jdgreen="#2D553A"
let $jgreen="#5AAA75"
let $jlgreen="#87FFAF"

let $jdpurple="#392C55"
let $jpurple="#7358AA"
let $jlpurple="#AD84FF"

let $jdorange="#552F0F"
let $jorange="#AA5E1F"
let $jlorange="#FF8D2F"

let $jdyellow="#55461A"
let $jyellow="#AA8D34"
let $jlyellow="#FFD54F"

let $jvdred="#280400"
let $jdred="#551A1A"
let $jred="#AA3535"
let $jlred="#FF5050"

let $jdmagenta="#552A3D"
let $jmagenta="#AA557B"
let $jlmagenta="#FF80B9"

" Text:
exe "hi Boolean guifg=" . $jpurple
exe "hi Character guifg=" . $jlmagenta
exe "hi Comment guifg=" . $jblue
exe "hi Conditional guifg=" . $jlorange
exe "hi Constant guifg=" . $jlpurple
exe "hi Debug guifg=" . $jpurple
exe "hi Define guifg=" . $jlblue
exe "hi Delimiter guifg=" . $jwhite . " gui=bold"
exe "hi Error guibg=" . $jlred . " guifg=" . $jwhite
exe "hi Exception guifg=" . $jlyellow
exe "hi Float guifg=" . $jpurple
exe "hi Folded guibg=" . $jdgreen . " guifg=" . $jwhite
exe "hi Function guifg=" . $jwhite . " gui=bold"
exe "hi Identifier guifg=" . $jlblue . " gui=bold"
exe "hi Ignore guifg=" . $jblack
exe "hi Include guifg=" . $jlblue
exe "hi Keyword guifg=" . $jlyellow
exe "hi Label guifg=" . $jlyellow
exe "hi Macro guifg=" . $jlblue
exe "hi NonText guifg=" . $jlcyan
exe "hi Normal guifg=" . $jlgrey . " guibg=" . $jblack
exe "hi Number guifg=" . $jpurple
exe "hi Operator guifg=" . $jlorange
exe "hi PreCondit guifg=" . $jlblue
exe "hi PreProc guifg=" . $jlblue
exe "hi Repeat guifg=" . $jwhite
exe "hi Search guifg=" . $jblack . " guibg=" . $jlyellow
exe "hi Special guifg=" . $jpurple
exe "hi SpecialChar guifg=" . $jpurple
exe "hi SpecialComment guifg=" . $jpurple
exe "hi SpellBad guisp=" . $jlred
exe "hi Statement guifg=" . $jlyellow
exe "hi StorageClass guifg=" . $jlgreen
exe "hi String guifg=" . $jlpurple
exe "hi Structure guifg=" . $jlgreen
exe "hi Tag guifg=" . $jpurple
exe "hi Title guifg=" . $jlpurple . " gui=bold"
exe "hi Todo guifg=" . $jlyellow . " gui=undercurl,bold"
exe "hi Type guifg=" . $jlgreen
exe "hi Typedef guifg=" . $jlgreen

exe "hi link htmlEndTag htmlTag"

" Spell:
exe "hi clear SpellLocal"
exe "hi clear SpellRare"
exe "hi clear SpellCap"

" GUI:
exe "hi ColorColumn guibg=" . $jvdred
exe "hi CursorColumn guibg=" . $jdgrey
exe "hi CursorLine gui=bold guibg=" . $jdgrey
exe "hi CursorLineNR gui=bold guifg=" . $jlblue . " guibg=NONE"
exe "hi LineNR guifg=" . $jlgrey . " guibg=NONE"
exe "hi SpecialKey guibg=" . $jlyellow
exe "hi StatusLine gui=NONE guifg=" . $jpurple . " guibg=" . $jdgrey
exe "hi StatusLineTerm gui=NONE guifg=" . $jpurple . " guibg=" . $jdgrey
exe "hi StatusLineTermNC guibg=NONE"
" This should keep the vertical split highlight synced with airline, but it doesn't work for insert mode.
" hi! link VertSplit airline_a
exe "hi VertSplit guibg=" . $jblack . " guifg=" . $jblue
exe "hi WildMenu gui=bold guifg=" . $jlyellow . " guibg=" . $jdgrey

" Git Column:
exe "hi GitAddSign guifg=" . $jgreen . " gui=bold"
exe "hi GitChangeSign guifg=" . $jlblue . " gui=bold"
exe "hi GitDeleteSign guifg=" . $jlred . " gui=bold"
exe "hi GitChangeDeleteSign guifg=" . $jpurple . " gui=bold"

" ALE Colors:
exe "hi ALEWarningSign guifg=" . $jlyellow . " guibg=NONE"
exe "hi ALEWarning guifg=NONE guibg=NONE"
exe "hi LintErrorSign guifg=" . $jlred . " gui=bold"

" Coc Colors:
exe "hi Pmenu guibg=" . $jgrey
exe "hi PmenuSel guifg=" . $jgrey
exe "hi CocHighlightText gui=underline"

" Space Display And Highlighting:
exe "hi TrailingSpaces guibg=" . $jdred
exe "hi DoubleSpaces guibg=" . $jdred
augroup spaces
  au!
  au BufReadPost,BufNewFile * exe "hi DoubleSpaces guibg=" . $jdred
  au BufReadPost,BufNewFile routes hi DoubleSpaces guibg=NONE
augroup end
call matchadd('TrailingSpaces', '\s\+$', 100)
call matchadd('DoubleSpaces', '\S\zs\s\{2,}', 100)

