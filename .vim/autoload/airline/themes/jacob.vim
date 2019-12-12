let g:airline#themes#jacob#palette = {}

let s:normal = '#0087Af'
let s:insert = '#87D700'
let s:visual = '#6E4E8E'
let s:special = '#D78700'
let s:error = '#D70000'
let s:black = '#080808'
let s:dark = '#1C1C1C'
let s:light = '#767676'

let s:N_A = [ s:black , s:normal , 232 , 45 ]
let s:N_B = [ s:special , s:dark, 202 , 234 ]
let s:N_C = [ s:light , s:black, 243 , 232]
let g:airline#themes#jacob#palette.normal = airline#themes#generate_color_map(s:N_A, s:N_B, s:N_C)
let g:airline#themes#jacob#palette.normal_modified = {
  \ 'airline_c': [ s:error , s:black, 160 , 232 , '' ],
  \ }


let s:I_A = [ s:black, s:insert , 232 , 82 ]
let s:I_B = [ s:special , s:dark, 202 , 234 ]
let s:I_C = [ s:light , s:black, 243 , 232 ]
let g:airline#themes#jacob#palette.insert = airline#themes#generate_color_map(s:I_A, s:I_B, s:I_C)
let g:airline#themes#jacob#palette.insert_modified = copy(g:airline#themes#jacob#palette.normal_modified)
let g:airline#themes#jacob#palette.insert_paste = {
  \ 'airline_a': [ s:black , s:special , s:I_A[2] , 172 , '' ],
  \ }


let g:airline#themes#jacob#palette.replace = {
  \ 'airline_a': [ s:black , s:error , s:I_A[2] , 124 , '' ],
  \ }
let g:airline#themes#jacob#palette.replace_modified = copy(g:airline#themes#jacob#palette.normal_modified)


let s:V_A = [ s:black, s:visual , 232 , 184 ]
let s:V_B = [ s:special , s:dark, 202 , 234 ]
let s:V_C = [ s:light , s:black, 243 , 232 ]
let g:airline#themes#jacob#palette.visual = airline#themes#generate_color_map(s:V_A, s:V_B, s:V_C)
let g:airline#themes#jacob#palette.visual_modified = copy(g:airline#themes#jacob#palette.normal_modified)


let s:IA_A  = [ s:normal , s:dark , 239 , 232  , '' ]
let s:IA_B = [ s:black, s:normal , 239 , 234 , '' ]
let g:airline#themes#jacob#palette.inactive = airline#themes#generate_color_map(s:IA_A, s:IA_B, s:IA_B)
let g:airline#themes#jacob#palette.inactive_modified = {
  \ 'airline_c': [ s:error, '', 160, '', '' ],
  \ }

