set background=dark
hi clear
if exists("syntax_on")
 syntax reset
endif
let g:colors_name = "jacob"
hi Normal guifg=#D3D3D3 guibg=#121212
hi Comment guifg=#06989A
hi Constant guifg=#AD7FA8
hi Special guifg=#75507B
hi Identifier cterm=bold guifg=#34E2E2
hi Statement guifg=#FCE94F
hi PreProc guifg=#5FD7FF
hi Type guifg=#87FFAF
hi Function guifg=#FFFFFF
hi Repeat guifg=#FFFFFF
hi Operator guifg=#EF2929
hi Ignore guifg=#000000
hi Error guibg=#EF2929 guifg=#FFFFFF
hi Todo guibg=#FCE94F guifg=#000000
hi String guifg=#AD7FA8
hi Character guifg=#AD7FA8
hi Number guifg=#AD7FA8
hi Boolean guifg=#AD7FA8
hi Float guifg=#AD7FA8
hi Conditional guifg=#FFFFFF
hi Label guifg=#FCE94F
hi Keyword guifg=#FCE94F
hi Exception guifg=#FCE94F
hi Include guifg=#5FD7FF
hi Define guifg=#5FD7FF
hi Macro guifg=#5FD7FF
hi PreCondit guifg=#5FD7FF
hi StorageClass guifg=#87FFAF
hi Structure guifg=#87FFAF
hi Typedef guifg=#87FFAF
hi Tag guifg=#75507B
hi SpecialChar guifg=#75507B
hi Delimiter guifg=#75507B
hi SpecialComment guifg=#75507B
hi Debug guifg=#75507B

hi SpecialKey guibg=#FCE94F
hi LineNR guifg=#A8A8A8 guibg=NONE
hi CursorLine cterm=bold guibg=#262626
hi CursorLineNR cterm=bold guifg=#5FD7FF guibg=NONE
hi CursorColumn cterm=bold guibg=#262626
hi StatusLine cterm=NONE guifg=#06989A guibg=#2E3436
hi ColorColumn guibg=#280400

" Space display and hilighting
hi TrailingSpaces guibg=red
hi DoubleSpaces guibg=red
au BufReadPost,BufNewFile * hi DoubleSpaces guibg=red
au BufReadPost,BufNewFile routes hi DoubleSpaces guibg=NONE
call matchadd('TrailingSpaces', '\s\+$', 100)
call matchadd('DoubleSpaces', '\S\zs\s\s\s*', 100)
