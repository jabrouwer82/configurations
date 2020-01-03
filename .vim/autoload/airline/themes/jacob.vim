let g:airline#themes#jacob#palette = {}

let s:N_A = [$jblack, $jblue, 232, 45]
let s:N_B = [$jlorange, $jdgrey, 202, 234]
let s:N_C = [$jlgrey, $jblack, 243, 232]
let g:airline#themes#jacob#palette.normal = airline#themes#generate_color_map(s:N_A, s:N_B, s:N_C)
let g:airline#themes#jacob#palette.normal_modified = {
  \ 'airline_c': [$jlred, $jblack, 160, 232, ''],
  \ }


let s:I_A = [$jblack, $jgreen, 232, 82]
let s:I_B = [$jlorange, $jdgrey, 202, 234]
let s:I_C = [$jlgrey, $jblack, 243, 232]
let g:airline#themes#jacob#palette.insert = airline#themes#generate_color_map(s:I_A, s:I_B, s:I_C)
let g:airline#themes#jacob#palette.insert_modified = copy(g:airline#themes#jacob#palette.normal_modified)
let g:airline#themes#jacob#palette.insert_paste = {
  \ 'airline_a': [$jblack, $jlorange, s:I_A[2], 172, ''],
  \ }


let g:airline#themes#jacob#palette.replace = {
  \ 'airline_a': [$jblack, $jlred, s:I_A[2], 124, ''],
  \ }
let g:airline#themes#jacob#palette.replace_modified = copy(g:airline#themes#jacob#palette.normal_modified)


let s:V_A = [$jblack, $jblue, 232, 184]
let s:V_B = [$jlorange, $jdgrey, 202, 234]
let s:V_C = [$jlgrey, $jblack, 243, 232]
let g:airline#themes#jacob#palette.visual = airline#themes#generate_color_map(s:V_A, s:V_B, s:V_C)
let g:airline#themes#jacob#palette.visual_modified = copy(g:airline#themes#jacob#palette.normal_modified)


let s:IA_A  = [$jpurple, $jdgrey, 239, 232 , '']
let s:IA_B = [$jblack, $jpurple, 239, 234, '']
let g:airline#themes#jacob#palette.inactive = airline#themes#generate_color_map(s:IA_A, s:IA_B, s:IA_B)
let g:airline#themes#jacob#palette.inactive_modified = {
  \ 'airline_c': [$jdred, '', 160, '', ''],
  \ }

