set background=dark
hi clear
if exists('syntax_on')
 syntax reset
endif
let g:colors_name = 'jacob'

" Colors:
"
" #000000
" #030303
" #555555
" #1E1E1E
" #D3D3D3
" #A8A8A8
" #FFFFFF
"
" #003B3B
" #0087AF
" #06989A
" #280400
" #4CB24C
" #5D3F98
" #5FD7FF
" #75507B
" #7D5FB8
" #7D7FB8
" #87FFAF
" #AD7FA8
" #BD5F78
" #C85050
" #D78700
" #EF2929
" #FCD54F
" #FF0000

" Text:
hi Boolean guifg=#7D5FB8
hi Character guifg=#BD5F78
hi Comment guifg=#06989A
hi Conditional guifg=#D78700
hi Constant guifg=#AD7FA8
hi Debug guifg=#75507B
hi Define guifg=#5FD7FF
hi Delimiter guifg=#FFFFFF gui=bold
hi Error guibg=#EF2929 guifg=#FFFFFF
hi Exception guifg=#FCD54F
hi Float guifg=#7D7FB8
hi Folded guibg=#003B3B guifg=#FFFFFF
hi Function guifg=#FFFFFF gui=bold
hi Identifier guifg=#5FD7FF gui=bold
hi Ignore guifg=#000000
hi Include guifg=#5FD7FF
hi Keyword guifg=#FCD54F
hi Label guifg=#FCD54F
hi Macro guifg=#5FD7FF
hi NonText guifg=#5D3F98
hi Normal guifg=#D3D3D3 guibg=#030303
hi Number guifg=#7D5FB8
hi Operator guifg=#D78700
hi PreCondit guifg=#5FD7FF
hi PreProc guifg=#5FD7FF
hi Repeat guifg=#FFFFFF
hi Search guifg=#000000 guibg=#FCD54F
hi Special guifg=#75507B
hi SpecialChar guifg=#75507B
hi SpecialComment guifg=#75507B
hi SpellBad guisp=#FF0000
hi Statement guifg=#FCD54F
hi StorageClass guifg=#87FFAF
hi String guifg=#AD7FA8
hi Structure guifg=#87FFAF
hi Tag guifg=#75507B
hi Title guifg=#AD7FA8 gui=bold
hi Todo guifg=#FCD54F gui=undercurl,bold
hi Type guifg=#87FFAF
hi Typedef guifg=#87FFAF

" Spell:
hi clear SpellLocal
hi clear SpellRare
hi clear SpellCap

" GUI:
hi ColorColumn guibg=#280400
hi CursorColumn guibg=#1E1E1E
hi CursorLine gui=bold guibg=#1E1E1E
hi CursorLineNR gui=bold guifg=#5FD7FF guibg=NONE
hi LineNR guifg=#A8A8A8 guibg=NONE
hi SpecialKey guibg=#FCD54F
hi StatusLine gui=NONE guifg=#7D5FB8 guibg=#1E1E1E
hi StatusLineTerm gui=NONE guifg=#7D5FB8 guibg=#1E1E1E
hi StatusLineTermNC guibg=NONE
" This should keep the vertical split highlight synced with airline, but it doesn't work for insert mode.
" hi! link VertSplit airline_a
hi VertSplit guibg=#000000 guifg=#0087AF
hi WildMenu gui=bold guifg=#FCD54F guibg=#1E1E1E

" Git Column:
hi GitAddSign guifg=#4CB24C gui=bold
hi GitChangeSign guifg=#5FD7FF gui=bold
hi GitDeleteSign guifg=#C85050 gui=bold
hi GitChangeDeleteSign guifg=#75507B gui=bold

" ALE Colors:
hi ALEWarningSign guifg=#FCD54F guibg=NONE
hi ALEWarning guifg=NONE guibg=NONE
hi LintErrorSign guifg=#EF2929 gui=bold

" Coc Colors:
hi Pmenu guibg=#555555
hi PmenuSel guifg=#555555
hi CocHighlightText gui=underline

" Space Display And Highlighting:
hi TrailingSpaces guibg=#C85050
hi DoubleSpaces guibg=#C85050
augroup spaces
  au!
  au BufReadPost,BufNewFile * hi DoubleSpaces guibg=#C85050
  au BufReadPost,BufNewFile routes hi DoubleSpaces guibg=NONE
augroup end
call matchadd('TrailingSpaces', '\s\+$', 100)
call matchadd('DoubleSpaces', '\S\zs\s\{2,}', 100)

