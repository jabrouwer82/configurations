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
exe 'hi JacobStructure guifg=' . $jvlgreen
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


" Custom LSP Settings:
exe 'hi JacobVariableDef guifg=' . $jlred
exe 'hi JacobVariable guifg=' . $jvlred
exe 'hi JacobImmutable guifg=' . $jvlgrey
exe 'hi JacobFunctionCall guifg=' . $jvlblue
exe 'hi JacobBuiltinFunction guifg=' . $jcyan
hi! link @function.builtin JacobBuiltinFunction
hi! link @lsp.type.variable.scala JacobVariable
hi! link @lsp.type.method.scala JacobFunctionCall
hi! link @lsp.type.class.scala JacobTypedef
hi! link @lsp.type.modifier.scala JacobLabel
hi! link @lsp.mod.readonly JacobImmutable
hi! link @lsp.typemod.method.definition.scala JacobFunction
hi! link @lsp.typemod.class.abstract.scala JacobType
hi! link @lsp.typemod.parameter.readonly.scala JacobParam

lua << EOF
local scalaGroup = vim.api.nvim_create_augroup("Scala Highlight Overrides", { clear = true })
vim.api.nvim_create_autocmd("LspTokenUpdate", {
  group = scalaGroup,
  pattern = {"*.scala", "*.sbt"},
  callback = function(args)
    local token = args.data.token
    if token.type == "keyword" then
      local data = vim.api.nvim_buf_get_text(args.buf, token.line, token.start_col, token.line, token.end_col, {})
      if next(data) then
        local str = data[1]
        if str == "true" or str == "false" then
          vim.lsp.semantic_tokens.highlight_token(token, args.buf, args.data.client_id, "JacobBoolean")
        elseif str == "package" or str == "import" then
          vim.lsp.semantic_tokens.highlight_token(token, args.buf, args.data.client_id, "JacobInclude")
        elseif str == "var" or str == "null" then
          vim.lsp.semantic_tokens.highlight_token(token, args.buf, args.data.client_id, "JacobVariableDef")
        end
      end
    end
  end,
})

local vimGroup = vim.api.nvim_create_augroup("Vim Highlight Overrides", { clear = true })
vim.api.nvim_create_autocmd("LspTokenUpdate", {
  group = vimGroup,
  pattern = {"*.vim"},
  callback = function(args)
    local token = args.data.token
    if token.type == "comment" then
      local data = vim.api.nvim_buf_get_text(args.buf, token.line, token.end_col, token.line, token.end_col+1, {})[1]
      if next(data) then
        local str = data[1]
        if str == ":" then
          vim.lsp.semantic_tokens.highlight_token(token, args.buf, args.data.client_id, "JacobSpecialComment")
        end
      end
    end
  end,
})
EOF

" Treesitter:
hi! clear vimFunc
" hi! link TSAttribute JacobMacro
" hi! link TSInclude JacobInclude
" hi! link TSConditional JacobConditional
" hi! link TSBoolean JacobBoolean
" hi! link TSCharacterSpecial JacobSpecialChar
" hi! link TSComment JacobComment
" hi! link TSConstant JacobConstant
" hi! link TSConstBuiltin JacobConstant
" hi! link TSConstMacro JacobConstant
" hi! link TSCharacter JacobCharacter
" hi! link TSNamespace JacobNamespace

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
" Align with airline visual color.
exe 'hi JacobVisual guibg=' . $jdcyan
hi! link Visual JacobVisual
exe 'hi JacobColorColumn guibg=' . $jblackred
hi! link ColorColumn JacobColorColumn
exe 'hi JacobCursorColumn guibg=' . $jdgrey
hi! link CursorColumn JacobCursorColumn
exe 'hi JacobCursorLine gui=bold guibg=' . $jdgrey
hi! link CursorLine JacobCursorLine
exe 'hi JacobCursorLineNR gui=bold guifg=' . $jlblue . ' guibg=' . g:sign_bg
exe 'hi JacobNormalCursorLineNR gui=bold guifg=' . $jlblue . ' guibg=' . g:sign_bg
exe 'hi JacobInsertCursorLineNR gui=bold guifg=' . $jgreen . ' guibg=' . g:sign_bg
exe 'hi JacobCmdLineCursorLineNR gui=bold guifg=' . $jmagenta . ' guibg=' . g:sign_bg
exe 'hi JacobTermCursorLineNR gui=bold guifg=' . $jyellow . ' guibg=' . g:sign_bg
hi! link CursorLineNR JacobCursorLineNR
augroup cursorlinenumber
  au!
  au InsertEnter * :hi! link CursorLineNR JacobInsertCursorLineNR

  au CmdLineEnter * :hi! link CursorLineNR JacobCmdLineCursorLineNR | redraw

  au TermEnter * :hi! link CursorLineNR JacobTermCursorLineNR

  au InsertLeave,CmdLineLeave,TermLeave * :hi! link CursorLineNR JacobNormalCursorLineNR
augroup end
hi! link CursorLineNR JacobCursorLineNR
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
exe 'hi JacobPmenu guibg=' . $jvdblue . ' guifg=' . $jlgrey
hi! link Pmenu JacobPmenu
exe 'hi JacobPmenuSel guifg=' . $jdblue . ' guibg=' . $jlgrey
hi! link PmenuSel JacobPmenuSel
hi! link FloatBorder TelescopeBorder
exe 'hi JacobEndOfBuffer guifg=' . $jmagenta . ' guibg=' . g:sign_bg
hi! link EndOfBuffer JacobEndOfBuffer

" Git Column:
exe 'hi JacobGitAddSign guifg=' . $jgreen . ' guibg=' . g:sign_bg
hi! link GitAddSign JacobGitAddSign
exe 'hi JacobGitChangeSign guifg=' . $jlblue . ' guibg=' . g:sign_bg
hi! link GitChangeSign JacobGitChangeSign
exe 'hi JacobGitDeleteSign guifg=' . $jmagenta . ' guibg=' . g:sign_bg
hi! link GitDeleteSign JacobGitDeleteSign
exe 'hi JacobGitChangeDeleteSign guifg=' . $jpurple . ' guibg=' . g:sign_bg
hi! link GitChangeDeleteSign JacobGitChangeDeleteSign

" LSP:
" Errors
exe 'hi JacobDiagnosticError guifg=' . $jlred
hi! link DiagnosticError JacobDiagnosticError
exe 'hi JacobDiagnosticSignError guibg=' . g:sign_bg . ' gui=bold guifg=' . $jlred
hi! link DiagnosticSignError JacobDiagnosticSignError
exe 'hi JacobDiagnosticUnderlineError gui=underline guisp=' . $jlred
hi! link DiagnosticUnderlineError JacobDiagnosticUnderlineError
exe 'hi JacobDiagnosticVirtualTextError gui=underline guisp=' . $jlred . ' guifg=' . $jlred . ' guibg=' . $jdred
hi! link DiagnosticVirtualTextError JacobDiagnosticVirtualTextError
exe 'hi JacobDiagnosticVirtualLinesError guifg=' . $jlred . ' guibg=' . $jdred
hi! link DiagnosticVirtualLinesError JacobDiagnosticVirtualLinesError
" Warnings
exe 'hi JacobDiagnosticWarn guifg=' . $jlyellow
hi! link DiagnosticWarn JacobDiagnosticWarn
exe 'hi JacobDiagnosticSignWarn guibg=' . g:sign_bg . ' guifg=' . $jlyellow
hi! link DiagnosticSignWarn JacobDiagnosticSignWarn
exe 'hi JacobDiagnosticUnderlineWarn gui=underline guisp=' . $jlyellow
hi! link DiagnosticUnderlineWarn JacobDiagnosticUnderlineWarn
exe 'hi JacobDiagnosticVirtualTextWarn gui=underline guisp=' . $jlyellow . ' guifg=' . $jlyellow . ' guibg=' . $jdyellow
hi! link DiagnosticVirtualTextWarn JacobDiagnosticVirtualTextWarn
exe 'hi JacobDiagnosticVirtualLinesWarn guifg=' . $jlyellow . ' guibg=' . $jdyellow
hi! link DiagnosticVirtualLinesWarn JacobDiagnosticVirtualLinesWarn
" Info
exe 'hi JacobDiagnosticInfo guifg=' . $jlgrey
hi! link DiagnosticInfo JacobDiagnosticInfo
exe 'hi JacobDiagnosticSignInfo guibg=' . g:sign_bg . ' guifg=' . $jwhite
hi! link DiagnosticSignInfo JacobDiagnosticSignInfo
exe 'hi JacobDiagnosticUnderlineInfo gui=underline guisp=' . $jlgrey
hi! link DiagnosticUnderlineInfo JacobDiagnosticUnderlineInfo
exe 'hi JacobDiagnosticVirtualTextInfo gui=underline guisp=' . $jlgrey . ' guifg=' . $jlgrey . ' guibg=' . $jdgrey
hi! link DiagnosticVirtualTextInfo JacobDiagnosticVirtualTextInfo
exe 'hi JacobDiagnosticVirtualLinesInfo guifg=' . $jlgrey . ' guibg=' . $jdgrey
hi! link DiagnosticVirtualLinesInfo JacobDiagnosticVirtualLinesInfo
" Hints
exe 'hi JacobDiagnosticHint guifg=' . $jcyan
hi! link DiagnosticHint JacobDiagnosticHint
exe 'hi JacobDiagnosticSignHint guibg=' . g:sign_bg . ' guifg=' . $jlcyan
hi! link DiagnosticSignHint JacobDiagnosticSignHint
exe 'hi JacobDiagnosticUnderlineHint gui=underline guisp=' . $jcyan
hi! link DiagnosticUnderlineHint JacobDiagnosticUnderlineHint
exe 'hi JacobDiagnosticVirtualTextHint gui=underline guisp=' . $jcyan . ' guifg=' . $jcyan . ' guibg=' . $jvdcyan
hi! link DiagnosticVirtualTextHint JacobDiagnosticVirtualTextHint
exe 'hi JacobDiagnosticVirtualLinesHint guifg=' . $jcyan . ' guibg=' . $jvdcyan
hi! link DiagnosticVirtualLinesHint JacobDiagnosticVirtualLinesHint

exe 'hi JacobLspCodeLens guifg=' . $jdcyan
hi! link LspCodeLens JacobLspCodeLens
exe 'hi JacobLspCodeLensSeparator guifg=' . $jdpurple
hi! link LspCodeLensSeparator JacobLspCodeLensSeparator

exe 'hi JacobLspReferenceText gui=underline,italic guisp=' . $jlcyan . ' guibg=' . $jdcyan
hi! link LspReferenceText JacobLspReferenceText
exe 'hi JacobLspReferenceRead gui=underline,italic guisp=' . $jlblue . ' guibg=' . $jdblue
hi! link LspReferenceRead JacobLspReferenceRead
exe 'hi JacobLspReferenceWrite gui=underline,italic guisp=' . $jlpurple . ' guibg=' . $jdpurple
hi! link LspReferenceWrite JacobLspReferenceWrite
exe 'hi JacobLspReferenceTarget gui=underline,italic guisp=' . $jlmagenta . ' guibg=' . $jdmagenta
hi! link LspReferenceTarget JacobLspReferenceTarget

" CMP:
exe 'hi JacobCmpItemAbbrMatch guifg=' . $jblue
hi! link CmpItemAbbrMatch JacobCmpItemAbbrMatch
exe 'hi JacobCmpItemAbbrMatchFuzzy guifg=' . $jyellow
hi! link CmpItemAbbrMatchFuzzy JacobCmpItemAbbrMatchFuzzy
exe 'hi JacobCmpItemAbbrDeprecated gui=strikethrough guifg=' . $jgrey
hi! link CmpItemAbbrDeprecated JacobCmpItemAbbrDeprecated
exe 'hi JacobCmpItemKindUnset guifg=' . $jred
hi! link CmpItemKind JacobCmpItemKindUnset

hi! link CmpItemKindText JacobComment

hi! link CmpItemKindVariable JacobPmenu
hi! link CmpItemKindProperty JacobPmenu
hi! link CmpItemKindColor JacobPmenu
hi! link CmpItemKindFile JacobPmenu
hi! link CmpItemKindFolder JacobPmenu

hi! link CmpItemKindConstant JacobConstant
hi! link CmpItemKindStruct JacobConstant
hi! link CmpItemKindEnum JacobConstant

hi! link CmpItemKindOperator JacobOperator

hi! link CmpItemKindInterface JacobTypeDef
hi! link CmpItemKindClass JacobTypeDef
hi! link CmpItemKindEnumMember JacobTypeDef


hi! link CmpItemKindTypeParameter JacobType

hi! link CmpItemKindFunction JacobFunction
hi! link CmpItemKindMethod JacobFunction
hi! link CmpItemKindConstructor JacobFunction

hi! link CmpItemKindKeyword JacobKeyword

hi! link CmpItemKindUnit JacobNumber

hi! link CmpItemKindSnippet JacobMacro
hi! link CmpItemKindModule JacobMacro
hi! link CmpItemKindField JacobMacro

hi! link CmpItemKindValue JacobItemKindUnset
hi! link CmpItemKindEvent JacobItemKindUnset
hi! link CmpItemKindReference JacobItemKindUnset


" Telescope:
hi! link TelescopeNormal JacobPmenu
hi! link TelescopeSelection JacobPmenuSel
exe 'hi JacobTelescopeHighlightText gui=underline guisp=' . $jwhite
hi! link TelescopeMatching JacobTelescopeHighlightText
exe 'hi JacobTelescopeResultsComment guifg=' . $jblack
hi! link TelescopeResultsComment JacobTelescopeResultsComment
exe 'hi JacobTelescopePreviewLine gui=underline guisp=' . $jwhite
hi! link TelescopePreviewLine JacobTelescopePreviewLine
exe 'hi JacobTelescopePromptCounter guifg=' . $jlorange
hi! link TelescopePromptCounter JacobTelescopePromptCounter
exe 'hi JacobTelescopeResultsNumber guifg=' . $jpurple
hi! link TelescopeResultsNumber JacobTelescopeResultsNumber


" Dap Ui:
exe 'hi DapBreakpointSign guibg=' . g:sign_bg . ' guifg=' . $jlpurple
exe 'hi DapBreakpointLine gui=underline guisp=' . $jpurple
" exe 'hi DapBreakpointNum gui=underline guisp=' . $jlpurple
exe 'hi DapStoppedSign guibg=' . g:sign_bg . ' guifg=' . $jlblue
exe 'hi DapStoppedLine gui=underline guisp=' . $jblue

" Signature Marks:
exe 'hi JacobMarks guifg=' . $jlmagenta . ' guibg=' . g:sign_bg
hi! link Marks JacobMarks

" GitGutter:
hi! link GitGutterAdd GitAddSign
hi! link GitGutterAddLineNr GitAddSign
exe 'hi JacobGitGutterAddLine guibg=' . $jblackgreen
hi! link GitGutterAddLine JacobGitGutterAddLine
hi! link GitGutterChange GitChangeSign
hi! link GitGutterChangeLineNr GitChangeSign
exe 'hi JacobGitGutterChangeLine guibg=' . $jblackblue
hi! link GitGutterChangeLine JacobGitGutterChangeLine
hi! link GitGutterDelete GitDeleteSign
hi! link GitGutterDeleteLineNr GitDeleteSign
exe 'hi JacobGitGutterDeleteLine guibg=' . $jblackred
hi! link GitGutterDeleteLine JacobGitGutterDeleteLine
hi! link GitGutterChangeDelete GitChangeDeleteSign
hi! link GitGutterChangeDeleteLineNr GitChangeDeleteSign
exe 'hi JacobGitGutterChangeDeleteLine guibg=' . $jblackpurple
hi! link GitGutterChangeDeleteLine JacobGitGutterChangeDeleteLine

" Fidget
exe 'hi JacobFidgetNormal guibg=' . $jblack . ' guifg=' . $jdgrey
hi! link FidgetNormal JacobFidgetNormal
exe 'hi JacobFidgetProgressDone guibg=' . $jblack . ' guifg=' . $jgrey
hi! link FidgetProgressDone JacobFidgetProgressDone
exe 'hi JacobFidgetProgress guibg=' . $jred . ' guifg=' . $jgreen
hi! link FidgetProgress JacobFidgetProgress
exe 'hi JacobFidgetGroup guibg=' . $jblack . ' guifg=' . $jcyan
hi! link FidgetGroup JacobFidgetGroup
exe 'hi JacobFidgetIcon guibg=' . $jblack . ' guifg=' . $jcyan
hi! link FidgetIcon JacobFidgetIcon
exe 'hi JacobFidgetGroupSeparator guibg=' . $jblack . ' guifg=' . $jgrey
hi! link FidgetGroupSeparator JacobFidgetGroupSeparator
exe 'hi JacobFidgetBorder guibg=' . $jblack . ' guifg=' . $jblackcyan
hi! link FidgetBorder JacobFidgetBorder

" Indent Blank Line IBL
exe 'hi JacobIBLIndent guifg=' . $jvdgrey
hi! link IBLIndent JacobIBLIndent
exe 'hi JacobIBLScope guifg=' . $jdblue
hi! link IBLScope JacobIBLScope

" Splash Screen
exe 'hi JacobDashboardHeader guifg=' . $jdcyan . ' guibg=' . $jblack
hi! link DashboardHeader JacobDashboardHeader
exe 'hi JacobDashboardFooter guifg=' . $jpurple . ' guibg=' . $jblack
hi! link DashboardFooter JacobDashboardFooter
exe 'hi JacobDashboardProjectTitle guifg=' . $jcyan . ' guibg=' . $jblack
hi! link DashboardProjectTitle JacobDashboardProjectTitle
" exe 'hi JacobDashboardProjectTitleIcon guifg=' . $jgreen . ' guibg=' . $jblack
" hi! link DashboardProjectTitleIcon JacobDashboardProjectTitleIcon
" exe 'hi JacobDashboardProjectIcon guifg=' . $jorange . ' guibg=' . $jblack
" hi! link DashboardProjectIcon JacobDashboardProjectIcon
exe 'hi JacobDashboardMruTitle guifg=' . $jcyan . ' guibg=' . $jblack
hi! link DashboardMruTitle JacobDashboardMruTitle
" exe 'hi JacobDashboardMruIcon guifg=' . $jlblue . ' guibg=' . $jblack
" hi! link DashboardMruIcon JacobDashboardMruIcon
exe 'hi JacobDashboardFiles guifg=' . $jvlcyan . ' guibg=' . $jblack
hi! link DashboardFiles JacobDashboardFiles
" exe 'hi JacobDashboardShortCutIcon guifg=' . $jvlgrey . ' guibg=' . $jblack
" hi! link DashboardShortCutIcon JacobDashboardShortCutIcon

exe 'hi JacobStartupHeader guifg=' . $jdcyan . ' guibg=' . $jvdgrey
hi! link StartupHeader JacobStartupHeader
exe 'hi JacobStartupCommands guifg=' . $jgreen . ' guibg=' . $jvdgrey
hi! link StartupCommands JacobStartupCommands
exe 'hi JacobStartupOldfiles guifg=' . $jpurple . ' guibg=' . $jvdgrey
hi! link StartupOldfiles JacobStartupOldfiles
exe 'hi JacobStartupDirOldfiles guifg=' . $jpurple . ' guibg=' . $jvdgrey
hi! link StartupDirOldfiles JacobStartupDirOldfiles
exe 'hi JacobStartupFooter guifg=' . $jdcyan . ' guibg=' . $jvdgrey
hi! link StartupFooter JacobStartupFooter
exe 'hi JacobStartupClock guifg=' . $jdcyan . ' guibg=' . $jvdgrey
hi! link StartupClock JacobStartupClock

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
