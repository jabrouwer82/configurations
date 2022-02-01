" Neovim-qt settings.
if exists(':Gui')
  " Add/subtract a whole number to/from the font size.
  function! AdjustFontSize(amount)
    redir => tmpfont | GuiFont
    redir END
    let newfont = substitute(tmpfont, ':h\(\d\+\)', '\=":h".(submatch(1)+a:amount)', '')
    execute 'GuiFont' trim(newfont)
  endfunction

  let g:jfont = 'Hasklug Nerd Font:h11'
  function! ResetFont()
    execute 'GuiFont' g:jfont
  endfunction

  " Set font in editor.
  :call ResetFont()
  " Set font in gui to match the editor font.
  GuiAdaptiveFont 1
  " Render ligatures.
  GuiRenderLigatures 1
  " Match gui colorscheme to editor colorscheme.
  GuiAdaptiveColor 1
  " Don't use the gui tabline.
  GuiTabline 0
  " " Do use the guiscrollbar.
  " GuiScrollBar 1
  call GuiWindowFullScreen(1)

  " Right Click Context Menu (Copy-Cut-Paste)
  nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
  inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
  xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
  snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv

  if g:uname ==# "Darwin"
    " Command copy/paste shortcuts
    nnoremap <D-v> <c-\><c-n>p
    inoremap <D-v> <c-r><c-o>+
    tnoremap <D-v> <c-\><c-n>p:startinsert<CR>
    cnoremap <D-v> <c-r>+
    " CMD-+ to increment font size.
    nnoremap <D-=> :call AdjustFontSize(1)<CR>
    inoremap <D-=> <ESC>:call AdjustFontSize(1)<CR>a
    xnoremap <D-=> :call AdjustFontSize(1)<CR>gv
    snoremap <D-=> <ESC>:call AdjustFontSize(1)<CR>gv
    tnoremap <D-=> <C-\><C-n>:call AdjustFontSize(1)<CR>:startinsert<CR>
    " CMD-- to increment font size.
    nnoremap <D--> :call AdjustFontSize(-1)<CR>
    inoremap <D--> <ESC>:call AdjustFontSize(-1)<CR>a
    xnoremap <D--> :call AdjustFontSize(-1)<CR>gv
    snoremap <D--> <ESC>:call AdjustFontSize(-1)<CR>gv
    tnoremap <D--> <C-\><C-n>:call AdjustFontSize(-1)<CR>:startinsert<CR>
    " CMD-0 to reset font size to my default.
    nnoremap <D-0> :call ResetFont()<CR>
    inoremap <D-0> <ESC>:call ResetFont()<CR>a
    xnoremap <D-0> :call ResetFont()<CR>gv
    snoremap <D-0> <ESC>:call ResetFont()<CR>gv
    tnoremap <D-0> <C-\><C-n>:call ResetFont()<CR>:startinsert<CR>
  endif
endif

" VimR settings.
if has('gui_vimr')
  VimRSetFontAndSize "HasklugNerdFontComplete-Regular", 11
endif
