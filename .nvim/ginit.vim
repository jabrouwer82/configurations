" Neovim-qt settings.
if exists(':Gui')
  " Set font in editor.
  GuiFont Hasklug Nerd Font:h11
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
    inoremap <D-v> <c-r>+
    tnoremap <D-v> <c-\><c-n>"+i
    cnoremap <D-v> <c-r>+
  endif
endif

" VimR settings.
if has('gui_vimr')
  VimRSetFontAndSize "HasklugNerdFontComplete-Regular", 11
endif
