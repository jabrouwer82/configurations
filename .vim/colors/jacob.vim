set background=dark
hi clear
if exists('syntax_on')
 syntax reset
endif
let g:colors_name = 'jacob'
hi Boolean guifg=#7D5FB8
hi Character guifg=#BD5F78
hi Comment guifg=#06989A
hi Conditional guifg=#FF9925
hi Constant guifg=#AD7FA8
hi Debug guifg=#75507B
hi Define guifg=#5FD7FF
hi Delimiter guifg=#FFFFFF cterm=bold
hi Error guibg=#EF2929 guifg=#FFFFFF
hi Exception guifg=#FCE94F
hi Float guifg=#7D7FB8
hi Function guifg=#FFFFFF cterm=bold
hi Folded guibg=#003B3B guifg=#FFFFFF
hi Identifier guifg=#34E2E2 cterm=bold
hi Ignore guifg=#000000
hi Include guifg=#5FD7FF
hi Keyword guifg=#FCE94F
hi Label guifg=#FCE94F
hi Macro guifg=#5FD7FF
hi Normal guifg=#D3D3D3
hi Number guifg=#7D5FB8
hi Operator guifg=#EF2929
hi PreCondit guifg=#5FD7FF
hi PreProc guifg=#5FD7FF
hi Repeat guifg=#FFFFFF
hi Special guifg=#75507B
hi SpecialChar guifg=#75507B
hi SpecialComment guifg=#75507B
hi SpellBad guibg=#680000 guifg=#FFFFFF
hi Statement guifg=#FCE94F
hi StorageClass guifg=#87FFAF
hi String guifg=#AD7FA8
hi Structure guifg=#87FFAF
hi Tag guifg=#75507B
hi Todo guibg=#FCE94F guifg=#000000
hi Type guifg=#87FFAF
hi Typedef guifg=#87FFAF

hi GitAddSign guifg=#4CB24C cterm=bold
hi GitChangeSign guifg=#5FD7FF cterm=bold
hi GitDeleteSign guifg=#C85050 cterm=bold
hi GitChangeDeleteSign guifg=#75507B cterm=bold
hi LintErrorSign guifg=#EF2929 cterm=bold
hi SpecialKey guibg=#FCE94F
hi LineNR guifg=#A8A8A8 guibg=NONE
hi CursorLine cterm=bold guibg=#262626
hi CursorLineNR cterm=bold guifg=#5FD7FF guibg=NONE
hi CursorColumn cterm=bold guibg=#262626
hi StatusLine cterm=NONE guifg=#06989A guibg=#2E3436
hi ColorColumn guibg=#280400

" ALE Colors:
hi ALEWarningSign guifg=#FCE94F guibg=NONE
hi ALEWarning guifg=NONE guibg=NONE

" Space display and hilighting
hi TrailingSpaces guibg=#C85050
hi DoubleSpaces guibg=#C85050
au BufReadPost,BufNewFile * hi DoubleSpaces guibg=#C85050
au BufReadPost,BufNewFile routes hi DoubleSpaces guibg=NONE
call matchadd('TrailingSpaces', '\s\+$', 100)
call matchadd('DoubleSpaces', '\S\zs\s\{2,}', 100)
