set background=dark
exe 'hi clear'
if exists('syntax_on')
 syntax reset
endif
let g:colors_name='jacob'

" Text:
exe 'hi JacobComment guifg=' . $jgrey
hi! link Comment JacobComment
exe 'hi JacobSpecialComment guifg=' . $jblue
hi! link SpecialComment JacobSpecialComment

exe 'hi JacobConstant guifg=' . $jpurple
hi! link Constant JacobConstant
exe 'hi JacobString guifg=' . $jmagenta
hi! link String JacobString
exe 'hi JacobCharacter guifg=' . $jred
hi! link Character JacobCharacter
exe 'hi JacobSpecialChar guifg=' . $jgrey
hi! link SpecialChar JacobSpecialChar
exe 'hi JacobNumber guifg=' . $jlpurple
hi! link Number JacobNumber
exe 'hi JacobFloat guifg=' . $jlpurple
hi! link Float JacobFloat
exe 'hi JacobBoolean guifg=' . $jpurple
hi! link Boolean JacobBoolean

exe 'hi JacobIdentifier guifg=' . $jblue
hi! link Identifier JacobIdentifier
exe 'hi JacobFunction guifg=' . $jlblue
hi! link Function JacobFunction

exe 'hi JacobStatement guifg=' . $jlyellow
hi! link Statement JacobStatement
exe 'hi JacobConditional guifg=' . $jlorange
hi! link Conditional JacobConditional
exe 'hi JacobRepeat guifg=' . $jlorange
hi! link Repeat JacobRepeat
exe 'hi JacobLabel guifg=' . $jyellow
hi! link Label JacobLabel
exe 'hi JacobOperator guifg=' . $jlorange
hi! link Operator JacobOperator
exe 'hi JacobKeyword guifg=' . $jlyellow
hi! link Keyword JacobKeyword
exe 'hi JacobException guifg=' . $jlred
hi! link Exception JacobException

exe 'hi JacobPreProc guifg=' . $jlcyan
hi! link PreProc JacobPreProc
exe 'hi JacobInclude guifg=' . $jcyan
hi! link Include JacobInclude
exe 'hi JacobDefine guifg=' . $jlcyan
hi! link Define JacobDefine
exe 'hi JacobMacro guifg=' . $jcyan
hi! link Macro JacobMacro
exe 'hi JacobPreCondit guifg=' . $jlcyan
hi! link PreCondit JacobPreCondit

exe 'hi JacobType guifg=' . $jlgreen . ' gui=NONE'
hi! link Type JacobType
exe 'hi JacobStorageClass guifg=' . $jlgreen
hi! link StorageClass JacobStorageClass
exe 'hi JacobStructure guifg=' . $jlgreen
hi! link Structure JacobStructure
exe 'hi JacobTypedef guifg=' . $jgreen
hi! link Typedef JacobTypedef

exe 'hi JacobSpecial guifg=' . $jgrey
hi! link Special JacobSpecial
exe 'hi JacobDelimiter guifg=' . $jgrey
hi! link Delimiter JacobDelimiter
exe 'hi JacobTag guifg=' . $jlcyan . ' guibg=' . $jlred
hi! link Tag JacobTag
exe 'hi JacobDebug guifg=' . $jcyan . ' guibg=' . $jlred
hi! link Debug JacobDebug

exe 'hi JacobEndOfBuffer guifg=' . $jmagenta
hi! link EndOfBuffer JacobEndOfBuffer
exe 'hi JacobError guibg=' . $jlred . ' guifg=' . $jwhite
hi! link Error JacobError
hi! link ErrorMsg Error
exe 'hi JacobFolded guibg=' . $jdgreen . ' guifg=' . $jwhite
hi! link Folded JacobFolded
exe 'hi JacobIgnore guifg=' . $jblack
hi! link Ignore JacobIgnore
exe 'hi JacobNonText guifg=' . $jlmagenta . ' gui=bold'
hi! link NonText JacobNonText
exe 'hi JacobNormal guifg=' . $jlgrey . ' guibg=' . $jblack
hi! link Normal JacobNormal
exe 'hi JacobSearch guifg=' . $jblack . ' guibg=' . $jlyellow
hi! link Search JacobSearch
exe 'hi JacobSpecialKey guibg=' . $jdred . ' guifg=' . $jlred
hi! link SpecialKey JacobSpecialKey
exe 'hi JacobTitle guifg=' . $jlpurple . ' gui=bold'
hi! link Title JacobTitle
exe 'hi JacobTodo guifg=' . $jorange . ' guibg=NONE gui=undercurl,bold'
hi! link Todo JacobTodo

" HTML:
hi! link htmlEndTag htmlTag

" Spell:
exe 'hi JacobSpellBad gui=undercurl guisp=' . $jlred
hi! link SpellBad JacobSpellBad
hi! clear SpellLocal
hi! clear SpellRare
hi! clear SpellCap

" GUI:
let g:sign_bg = $jvdgrey
exe 'hi JacobColorColumn guibg=' . $jvdred
hi! link ColorColumn JacobColorColumn
exe 'hi JacobCursorColumn guibg=' . $jdgrey
hi! link CursorColumn JacobCursorColumn
exe 'hi JacobCursorLine gui=bold guibg=' . $jdgrey
hi! link CursorLine JacobCursorLine
exe 'hi JacobCursorLineNR gui=bold guifg=' . $jlblue . ' guibg=' . g:sign_bg
exe 'hi JacobNormalCursorLineNR gui=bold guifg=' . $jlblue . ' guibg=' . g:sign_bg
exe 'hi JacobInsertCursorLineNR gui=bold guifg=' . $jlgreen . ' guibg=' . g:sign_bg
exe 'hi JacobCmdLineCursorLineNR gui=bold guifg=' . $jmagenta . ' guibg=' . g:sign_bg
exe 'hi JacobTermCursorLineNR gui=bold guifg=' . $jyellow . ' guibg=' . g:sign_bg
hi! link CursorLineNr JacobCursorLineNR
augroup cursorlinenumber
  au!
  au InsertEnter * :hi! link CursorLineNr JacobInsertCursorLineNR

  au CmdLineEnter * :hi! link CursorLineNr JacobCmdLineCursorLineNR

  au TermEnter * :hi! link CursorLineNr JacobTermCursorLineNR

  au InsertLeave,CmdLineLeave,TermLeave * hi! link CursorLineNR JacobNormalCursorLineNR
augroup end
hi! link CursorLineNr JacobCursorLineNR
exe 'hi JacobLineNR guifg=' . $jdcyan . ' guibg=' . g:sign_bg
hi! link LineNR JacobLineNR
exe 'hi JacobSignColumn guibg=' . g:sign_bg
hi! link SignColumn JacobSignColumn
exe 'hi JacobStatusLine gui=NONE guifg=' . $jpurple . ' guibg=' . $jdgrey
hi! link StatusLine JacobStatusLine
exe 'hi JacobStatusLineTerm gui=NONE guifg=' . $jpurple . ' guibg=' . $jdgrey
hi! link StatusLineTerm JacobStatusLineTerm
exe 'hi JacobStatusLineTermNC guibg=' . $jdpurple
hi! link StatusLineTermNC JacobStatusLineTermNC
" This should keep the vertical split highlight synced with airline, but it doesn't work for insert mode.
" hi! link VertSplit airline_a
exe 'hi JacobVertSplit guibg=' . $jdpurple . ' guifg=' . $jdpurple
hi! link VertSplit JacobVertSplit
exe 'hi JacobWildMenu gui=bold guifg=' . $jlyellow . ' guibg=' . $jdgrey
hi! link WildMenu JacobWildMenu

" Git Column:
exe 'hi JacobGitAddSign guifg=' . $jgreen . ' gui=bold guibg=' . g:sign_bg
hi! link GitAddSign JacobGitAddSign
exe 'hi JacobGitChangeSign guifg=' . $jlblue . ' gui=bold guibg=' . g:sign_bg
hi! link GitChangeSign JacobGitChangeSign
exe 'hi JacobGitDeleteSign guifg=' . $jlred . ' gui=bold guibg=' . g:sign_bg
hi! link GitDeleteSign JacobGitDeleteSign
exe 'hi JacobGitChangeDeleteSign guifg=' . $jpurple . ' gui=bold guibg=' . g:sign_bg
hi! link GitChangeDeleteSign JacobGitChangeDeleteSign

" ALE Colors:
exe 'hi JacobALEWarningSign guifg=' . $jlyellow . ' guibg=' . g:sign_bg
hi! link ALEWarningSign JacobALEWarningSign
exe 'hi JacobALEWarning guifg=NONE guibg=' . g:sign_bg
hi! link ALEWarning JacobALEWarning
exe 'hi JacobLintErrorSign guifg=' . $jlred . ' gui=bold guibg=' . g:sign_bg
hi! link LintErrorSign JacobLintErrorSign

" Coc Colors:
exe 'hi JacobPmenu guibg=' . $jdblue . ' guifg=' . $jlgrey
hi! link Pmenu JacobPmenu
exe 'hi JacobPmenuSel guifg=' . $jdblue . ' guibg=' . $jlgrey
hi! link PmenuSel JacobPmenuSel
exe 'hi JacobCocHighlightText gui=underline guisp=' . $jwhite
hi! link CocHighlightText JacobCocHighlightText
exe 'hi JacobCocInfoHighlight gui=underline guisp=' . $jlgrey
hi! link CocInfoHighlight JacobCocInfoHighlight
exe 'hi JacobCocWarningHighlight gui=underline guisp=' . $jlyellow
hi! link CocWarningHighlight JacobCocWarningHighlight
exe 'hi JacobCocErrorHighlight gui=underline guisp=' . $jlred
hi! link CocErrorHighlight JacobCocErrorHighlight
exe 'hi JacobCocErrorFloat guifg=' . $jlred
hi! link CocErrorFloat JacobCocErrorFloat
hi! link CocErrorSign LintErrorSign
hi! link CocWarningSign ALEWarningSign
exe 'hi JacobCocWarningFloat guifg=' . $jlyellow
hi! link CocWarningFloat JacobCocWarningFloat
exe 'hi JacobCocInfoSign guifg=' . $jlgrey . ' guibg=' . g:sign_bg
hi! link CocInfoSign JacobCocInfoSign
exe 'hi JacobCocInfoFloat guifg=' . $jlgrey
hi! link CocInfoFloat JacobCocInfoFloat
exe 'hi JacobCocHintSign guifg=' . $jlcyan . ' guibg=' . g:sign_bg
hi! link CocHintSign JacobCocHintSign
exe 'hi JacobCocHintFloat guifg=' . $jlcyan
hi! link CocHintFloat JacobCocHintFloat

" Signature Marks:
exe 'hi JacobMarks guifg=' . $jlmagenta . ' guibg=' . g:sign_bg
hi! link Marks JacobMarks

" GitGutter:
hi! link GitGutterAdd GitAddSign
hi! link GitGutterAddLineNr GitAddSign
exe 'hi JacobGitGutterAddLine guibg=' . $jvdgreen
hi! link GitGutterAddLine JacobGitGutterAddLine
hi! link GitGutterChange GitChangeSign
hi! link GitGutterChangeLineNr GitChangeSign
exe 'hi JacobGitGutterChangeLine guibg=' . $jvdblue
hi! link GitGutterChangeLine JacobGitGutterChangeLine
hi! link GitGutterDelete GitDeleteSign
hi! link GitGutterDeleteLineNr GitDeleteSign
exe 'hi JacobGitGutterDeleteLine guibg=' . $jvdred
hi! link GitGutterDeleteLine JacobGitGutterDeleteLine
hi! link GitGutterChangeDelete GitChangeDeleteSign
hi! link GitGutterChangeDeleteLineNr GitChangeDeleteSign
exe 'hi JacobGitGutterChangeDeleteLine guibg=' . $jvdpurple
hi! link GitGutterChangeDeleteLine JacobGitGutterChangeDeleteLine

" Clap:
exe 'hi JacobClapSpinner guibg=' . $jvdblue . ' guifg=' . $jpurple
hi! link ClapSpinner JacobClapSpinner
exe 'hi JacobClapInput guibg=' . $jvdblue . ' guifg=' . $jlgrey
hi! link ClapInput JacobClapInput
exe 'hi JacobClapSearchText guibg=' . $jvdblue . ' guifg=' . $jcyan
hi! link ClapSearchText JacobClapSearchText
hi! link ClapCurrentSelection PmenuSel
hi! link ClapCurrentSelectionSign PmenuSel
exe 'hi JacobClapSelected guibg=' . $jdblue . ' guifg=' . $jcyan . 'gui=underline guisp=' . $jcyan
hi! link ClapSelected JacobClapSelected
exe 'hi JacobClapSelectedSign guifg=' . $jcyan
hi! link ClapSelectedSign JacobSlapSelectedSign
hi! link ClapDisplay Pmenu
exe 'hi JacobClapPreview guibg=' . $jvdblue . ' guifg=' . $jlgrey
hi! link ClapPreview JacobClapPreview
hi! link ClapNoMatchesFound Error

" Terminal Ansi Colors:
let g:terminal_color_0 = $jblack
let g:terminal_color_1 = $jred
let g:terminal_color_2 = $jgreen
let g:terminal_color_3 = $jyellow
let g:terminal_color_4 = $jblue
let g:terminal_color_5 = $jpurple
let g:terminal_color_6 = $jcyan
let g:terminal_color_7 = $jlgrey
let g:terminal_color_8 = $jgrey
let g:terminal_color_9 = $jlred
let g:terminal_color_10 = $jlgreen
let g:terminal_color_11 = $jlyellow
let g:terminal_color_12 = $jlblue
let g:terminal_color_13 = $jlpurple
let g:terminal_color_14 = $jlcyan
let g:terminal_color_15 = $jwhite
let g:terminal_ansi_colors = [
  \ g:terminal_color_0, g:terminal_color_1, g:terminal_color_2, g:terminal_color_3,
  \ g:terminal_color_4, g:terminal_color_5, g:terminal_color_6, g:terminal_color_7,
  \ g:terminal_color_8, g:terminal_color_9, g:terminal_color_10, g:terminal_color_11,
  \ g:terminal_color_12, g:terminal_color_13, g:terminal_color_14, g:terminal_color_15,
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

