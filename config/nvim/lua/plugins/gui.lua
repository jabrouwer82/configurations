return {
  'equalsraf/neovim-gui-shim',
  'vim-airline/vim-airline-themes', -- I'm using my own theme, I'm not sure I need to pull this in anymore.
  'airblade/vim-gitgutter', -- Display git status in each file.
  'kshenoy/vim-signature', -- Display marks in the sign column.
  'yggdroot/indentline',
  'gorodinskiy/vim-coloresque',
  'tpope/vim-fugitive', -- Git integration.
  {
    'lambdalisue/battery.vim',
    init = function()
      vim.g.battery_watch_on_startup = 1
    end,
    config = function()
      vim.g['battery#component_format'] = '%v%%'
    end,
  },
  {
    'vim-airline/vim-airline', -- Pretty ui.
    init = function()
      -- Use my custom airline theme.
      vim.g.airline_theme = 'jacob'
      -- Use powerline symbols.
      vim.g.airline_powerline_fonts = 1
    end,
    config = function()
      -- Create the symbols dict.
      if vim.fn.exists('g:airline_symbols') == 0 then
        vim.g.airline_symbols = {}
      end
      -- Use a better symbol for dirty branches.
      vim.g.airline_symbols.dirty = '  '
      -- Don't show the 'spell' section in the status bar.
      vim.g.airline_detect_spell = 0
      -- Override some mode display values.
      if vim.fn.exists('g:airline_mode_map') == 0 then
        vim.g.airline_mode_map = {}
      end
      -- Can't use fancy unicode here, it breaks the terminal airline.
      -- Inactive
      -- vim.g.airline_mode_map['__'] = ' '
      -- Normal
      -- vim.g.airline_mode_map['n'] = ' '
      -- Insert
      -- vim.g.airline_mode_map['i'] = ' '
      -- Visual
      -- vim.g.airline_mode_map['v'] = ' '
      -- Visual Line
      -- vim.g.airline_mode_map['V'] = ' '
      -- Visual Block
      -- vim.g.airline_mode_map[''] = ' '
      -- Terminal
      -- vim.g.airline_mode_map['t'] = ' '
      -- Command
      -- vim.g.airline_mode_map['c'] = ' '
      -- Replace
      -- vim.g.airline_mode_map['R'] = ' '

      -- Enables detection of whitespace errors.
      vim.g['airline#extensions#whitespace#enabled'] = 0
      -- Don't show the encoding if it's what it should be.
      vim.g['airline#parts#ffenc#skip_expected_string'] = 'utf-8[unix]'
      vim.g['airline#extensions#nvimlsp#enabled'] = 1
      -- vim.g.airline#extensions#nvimmetals#enabled = 1

      -- Shows a list of attached lsps and the current function.
      vim.fn['airline#parts#define_function']('j_status', 'LspStatus')
      vim.g.airline_section_y = vim.fn['airline#section#create']({'j_status'})
      -- Change the line number section to not include the percentage.
      vim.g.airline_section_z = vim.fn['airline#section#create']({'linenr', 'maxlinenr', 'colnr'})

      -- Enable the tabline.
      vim.g['airline#extensions#tabline#enabled'] = 1
      -- Show visible buffers of current tab in tabline.
      vim.g['airline#extensions#tabline#show_splits'] = 1
      -- Truncate buffer names in the tabline to just the filename without extension.
      vim.g['airline#extensions#tabline#fnamemod'] = ':t:r'
      -- Number tabs by tab number (splits is the default?)
      vim.g['airline#extensions#tabline#tab_nr_type'] = 1
      -- Customization I added to always show the tab label, even in bufferline mode.
      vim.g['airline#extensions#tabline#show_tabs_label'] = 1
      -- Don't show the tab count.
      vim.g['airline#extensions#tabline#show_tab_count'] = 0
      -- Don't show close button for tabs.
      vim.g['airline#extensions#tabline#show_close_button'] = 0

    end
  }
}
