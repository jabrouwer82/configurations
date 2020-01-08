let g:airline#themes#jacob#palette = {}

let s:N_A = [$jblack, $jblue, '', '']
let s:N_B = [$jlorange, $jdgrey, '', '']
let s:N_C = [$jlgrey, $jblack, '', '']
let g:airline#themes#jacob#palette.normal = airline#themes#generate_color_map(s:N_A, s:N_B, s:N_C)
let g:airline#themes#jacob#palette.normal_modified = {
  \ 'airline_c': [$jlred, $jblack, '', '', ''],
  \ }


let s:I_A = [$jblack, $jgreen, '', '']
let s:I_B = [$jlorange, $jdgrey, '', '']
let s:I_C = [$jlgrey, $jblack, '', '']
let g:airline#themes#jacob#palette.insert = airline#themes#generate_color_map(s:I_A, s:I_B, s:I_C)
let g:airline#themes#jacob#palette.insert_modified = copy(g:airline#themes#jacob#palette.normal_modified)
let g:airline#themes#jacob#palette.insert_paste = {
  \ 'airline_a': [$jblack, $jlorange, s:I_A[2], '', ''],
  \ }


let g:airline#themes#jacob#palette.replace = {
  \ 'airline_a': [$jblack, $jlred, s:I_A[2], '', ''],
  \ }
let g:airline#themes#jacob#palette.replace_modified = copy(g:airline#themes#jacob#palette.normal_modified)


let s:V_A = [$jblack, $jblue, '', '']
let s:V_B = [$jlorange, $jdgrey, '', '']
let s:V_C = [$jlgrey, $jblack, '', '']
let g:airline#themes#jacob#palette.visual = airline#themes#generate_color_map(s:V_A, s:V_B, s:V_C)
let g:airline#themes#jacob#palette.visual_modified = copy(g:airline#themes#jacob#palette.normal_modified)


let s:IA_A  = [$jpurple, $jdgrey, '', '' , '']
let s:IA_B = [$jblack, $jpurple, '', '', '']
let g:airline#themes#jacob#palette.inactive = airline#themes#generate_color_map(s:IA_A, s:IA_B, s:IA_B)
let g:airline#themes#jacob#palette.inactive_modified = {
  \ 'airline_c': [$jdred, '', '', '', ''],
  \ }

let g:airline#themes#jacob#palette.tabline = {}

" Inactive tabs/buffers.
let g:airline#themes#jacob#palette.tabline.airline_tab = [
  \ $jpurple, $jdgrey, '', '', '']
let g:airline#themes#jacob#palette.tabline.airline_tab_right = g:airline#themes#jacob#palette.tabline.airline_tab

" Active tab/buffer and tab number.
let g:airline#themes#jacob#palette.tabline.airline_tabmod = [
  \ $jdgrey, $jblue, '', '', '']
let g:airline#themes#jacob#palette.tabline.airline_tabmod_right = g:airline#themes#jacob#palette.tabline.airline_tabmod

" Tabline labels.
let g:airline#themes#jacob#palette.tabline.airline_tablabel = [
  \ $jgreen, $jblack, '', '', '']

" Buffers not currently open in a window.
let g:airline#themes#jacob#palette.tabline.airline_tabhid = [
  \ $jmagenta, $jblack, '', '', '']
let g:airline#themes#jacob#palette.tabline.airline_tabhid_right = g:airline#themes#jacob#palette.tabline.airline_tabhid

" Unselected modified buffers.
let g:airline#themes#jacob#palette.tabline.airline_tabmod_unsel = [
  \ $jpurple, $jdgrey, '', '', '']
let g:airline#themes#jacob#palette.tabline.airline_tabmod_unsel_right = g:airline#themes#jacob#palette.tabline.airline_tabmod_unsel

" ???
let g:airline#themes#jacob#palette.tabline.airline_tabtype = [
  \ $jdgrey, $jlyellow, '', '', '']

