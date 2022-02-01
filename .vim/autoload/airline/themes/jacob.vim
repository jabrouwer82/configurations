let g:airline#themes#jacob#palette = {}


let s:NORMAL = $jblue
let s:TERMINAL = $jyellow
let s:INSERT = $jgreen
let s:VISUAL = $jcyan
let s:MODIFIED = $jlred
let s:PASTE = $jlorange
let s:REPLACE = $jlred
let s:INACTIVE = $jpurple
let s:COMMAND = $jmagenta

let s:ALL_C = [$jlgrey, $jblack, '', '']
let s:ALL_B = [$jlorange, $jdgrey, '', '']
let s:ERROR = [$jblack, $jred, '', '']
let s:WARNING = [$jblack, $jlorange, '', '']

let s:N_A = [$jblack, s:NORMAL, '', '']
let g:airline#themes#jacob#palette.normal = airline#themes#generate_color_map(s:N_A, s:ALL_B, s:ALL_C)
let g:airline#themes#jacob#palette.normal_modified = {
  \ 'airline_c': [s:MODIFIED, $jblack, '', ''],
  \ }
let g:airline#themes#jacob#palette.normal.airline_warning = s:WARNING
let g:airline#themes#jacob#palette.normal.airline_error = s:ERROR
let g:airline#themes#jacob#palette.normal.airline_term = s:ALL_C


let s:I_A = [$jblack, s:INSERT, '', '']
let g:airline#themes#jacob#palette.insert = airline#themes#generate_color_map(s:I_A, s:ALL_B, s:ALL_C)
let g:airline#themes#jacob#palette.insert_modified = copy(g:airline#themes#jacob#palette.normal_modified)
let g:airline#themes#jacob#palette.insert_paste = {
  \ 'airline_a': [$jblack, s:PASTE, '', ''],
  \ }
let g:airline#themes#jacob#palette.insert.airline_warning = s:WARNING
let g:airline#themes#jacob#palette.insert.airline_error = s:ERROR
let g:airline#themes#jacob#palette.insert.airline_term = s:ALL_C


let s:R_A = [$jblack, s:REPLACE, '', '']
let g:airline#themes#jacob#palette.replace = airline#themes#generate_color_map(s:R_A, s:ALL_B, s:ALL_C)
let g:airline#themes#jacob#palette.replace_modified = copy(g:airline#themes#jacob#palette.normal_modified)
let g:airline#themes#jacob#palette.replace.airline_warning = s:WARNING
let g:airline#themes#jacob#palette.replace.airline_error = s:ERROR


let s:V_A = [$jblack, s:VISUAL, '', '']
let g:airline#themes#jacob#palette.visual = airline#themes#generate_color_map(s:V_A, s:ALL_B, s:ALL_C)
let g:airline#themes#jacob#palette.visual_modified = copy(g:airline#themes#jacob#palette.normal_modified)
let g:airline#themes#jacob#palette.visual.airline_warning = s:WARNING
let g:airline#themes#jacob#palette.visual.airline_error = s:ERROR
let g:airline#themes#jacob#palette.visual.airline_term = s:ALL_C


let s:IA_A  = [s:INACTIVE, $jdgrey, '' , '']
let s:IA_B = [$jgrey, $jblack, '', '']
let s:IA_C = [$jlgrey, $jdpurple, '', '']
let g:airline#themes#jacob#palette.inactive = airline#themes#generate_color_map(s:IA_A, s:IA_B, s:IA_C)
let g:airline#themes#jacob#palette.inactive_modified = copy(g:airline#themes#jacob#palette.normal_modified)
let g:airline#themes#jacob#palette.inactive.airline_warning = s:WARNING
let g:airline#themes#jacob#palette.inactive.airline_error = s:ERROR
let g:airline#themes#jacob#palette.inactive.airline_term = s:ALL_C


let s:C_A = [$jblack, s:COMMAND, '', '']
let g:airline#themes#jacob#palette.commandline = airline#themes#generate_color_map(s:C_A, s:ALL_B, s:ALL_C)
let g:airline#themes#jacob#palette.commandline_modified = copy(g:airline#themes#jacob#palette.normal_modified)
let g:airline#themes#jacob#palette.commandline.airline_warning = s:WARNING
let g:airline#themes#jacob#palette.commandline.airline_error = s:ERROR
let g:airline#themes#jacob#palette.commandline.airline_term = s:ALL_C


let s:T_A  = [$jblack, s:TERMINAL, '' , '']
let s:T_B = [s:TERMINAL, $jdgrey, '', '']
let g:airline#themes#jacob#palette.terminal = airline#themes#generate_color_map(s:T_A, s:T_B, s:ALL_C)
let g:airline#themes#jacob#palette.terminal.airline_term = s:ALL_C


let g:airline#themes#jacob#palette.accents = {
\  'red': [$jwhite, $jlmagenta, '', '']
\}



" Tabline:
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

