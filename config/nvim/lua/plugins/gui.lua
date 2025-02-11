local vim = vim
local fn = vim.fn
local g = vim.g

local tabline_timer

return {
  'equalsraf/neovim-gui-shim',
  'vim-airline/vim-airline-themes', -- I'm using my own theme, I'm not sure I need to pull this in anymore.
  'airblade/vim-gitgutter', -- Display git status in each file.
  'kshenoy/vim-signature', -- Display marks in the sign column.
  'yggdroot/indentline',
  'gorodinskiy/vim-coloresque',
  'tpope/vim-fugitive', -- Git integration.
  {
    'stevearc/dressing.nvim',
    opts = {},
  },
  {
    'lambdalisue/battery.vim',
    init = function()
      g.battery_watch_on_startup = 1
    end,
    config = function()
      g['battery#component_format'] = '%v%%'
    end,
  },
  {
    'vim-airline/vim-airline', -- Pretty ui.
    init = function()
      -- Use my custom airline theme.
      g.airline_theme = 'jacob'
      -- Use powerline symbols.
      g.airline_powerline_fonts = 1
    end,
    config = function()
      -- Create the symbols dict.
      if fn.exists('g:airline_symbols') == 0 then
        g.airline_symbols = {}
      end
      -- Use a better symbol for dirty branches.
      g.airline_symbols.dirty = '  '
      -- Don't show the 'spell' section in the status bar.
      g.airline_detect_spell = 0
      -- Override some mode display values.
      if fn.exists('g:airline_mode_map') == 0 then
        g.airline_mode_map = {}
      end
      -- Can't use fancy unicode here, it breaks the terminal airline.
      -- Inactive
      -- g.airline_mode_map['__'] = ' '
      -- Normal
      -- g.airline_mode_map['n'] = ' '
      -- Insert
      -- g.airline_mode_map['i'] = ' '
      -- Visual
      -- g.airline_mode_map['v'] = ' '
      -- Visual Line
      -- g.airline_mode_map['V'] = ' '
      -- Visual Block
      -- g.airline_mode_map[''] = ' '
      -- Terminal
      -- g.airline_mode_map['t'] = ' '
      -- Command
      -- g.airline_mode_map['c'] = ' '
      -- Replace
      -- g.airline_mode_map['R'] = ' '

      -- Enables detection of whitespace errors.
      g['airline#extensions#whitespace#enabled'] = 0
      -- Don't show the encoding if it's what it should be.
      g['airline#parts#ffenc#skip_expected_string'] = 'utf-8[unix]'
      g['airline#extensions#nvimlsp#enabled'] = 1
      -- g.airline#extensions#nvimmetals#enabled = 1

      -- Shows a list of attached lsps and the current function.
      fn['airline#parts#define_function']('j_status', 'LspStatus')
      g.airline_section_y = fn['airline#section#create']({'j_status'})
      -- Change the line number section to not include the percentage.
      g.airline_section_z = fn['airline#section#create']({'linenr', 'maxlinenr', 'colnr'})

      -- Enable the tabline.
      g['airline#extensions#tabline#enabled'] = 1
      -- Show visible buffers of current tab in tabline.
      g['airline#extensions#tabline#show_splits'] = 1
      -- Truncate buffer names in the tabline to just the filename without extension.
      g['airline#extensions#tabline#fnamemod'] = ':t:r'
      -- Number tabs by tab number (splits is the default?)
      g['airline#extensions#tabline#tab_nr_type'] = 1
      -- Customization I added to always show the tab label, even in bufferline mode.
      g['airline#extensions#tabline#show_tabs_label'] = 1
      -- Don't show the tab count.
      g['airline#extensions#tabline#show_tab_count'] = 0
      -- Don't show close button for tabs.
      g['airline#extensions#tabline#show_close_button'] = 0

      -- Replaces the top right tabline buffer label with a clock and battery like '2/11 14:06:25 |99%|'.
      local function tablineUpdate()
        if require("lazy.core.config").plugins['vim-airline']._.loaded ~= nil and g['airline#extensions#tabline#enabled'] ~= 0 then
          vim.schedule(function()
            g['airline#extensions#tabline#buffers_label'] = fn.strftime('%m/%d %T') .. ' |' .. fn['battery#component_escaped']() .. '|'
            fn['airline#util#doautocmd']('BufMRUChange')
            fn['airline#extensions#tabline#redraw']()
          end)
        end
      end

      -- If there's already a timer, stop it.
      if tabline_timer ~= nil then
        tabline_timer:stop()
        tabline_timer:close()
      end
      -- Start a new timer
      tabline_timer = vim.uv.new_timer()
      tabline_timer:start(0, 300, tablineUpdate)
    end
  }
}
