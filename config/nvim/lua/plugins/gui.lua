local vim = vim
local fn = vim.fn
local g = vim.g

local tabline_timer

return {
  'equalsraf/neovim-gui-shim',
  'vim-airline/vim-airline-themes', -- I'm using my own theme, I'm not sure I need to pull this in anymore.
  'airblade/vim-gitgutter', -- Display git status in each file.
  'kshenoy/vim-signature', -- Display marks in the sign column.
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",

    opts = {
      indent = {
        tab_char = "▏",
        highlight = "IBLIndent"
      },
      scope = {
        highlight = "IBLScope"
      },
      exclude = {
        filetypes = { "alpha" },
      },
    },
  },
  'gorodinskiy/vim-coloresque',
  'tpope/vim-fugitive', -- Git integration.
  {
    'nvim-tree/nvim-web-devicons', -- Adds icons for filetypes.
    opts = {
      override = {
        zsh = {
          icon = "𝐙",
          color = vim.env.jdcyan,
          name = "Zsh"
        },
      },
    },
  },
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
      -- Don't show the 'spell' section in the status bar.
      g.airline_detect_spell = 0

      local symbols = g.airline_symbols
      -- Create the symbols dict.
      if symbols == nil then
        symbols = {}
      end
      symbols.linenr = ''
      symbols.maxlinenr = ''
      symbols.colnr = '-'
      symbols.branch = ''
      symbols.dirty = '~ '
      symbols.notexists = '+'
      g.airline_symbols = symbols

      local mode_map = g.airline_mode_map
      -- Override some mode display values.
      if mode_map == nil then
        mode_map = {}
      end
      mode_map['n'] = 'N' -- Normal
      mode_map['__'] = '' -- Inactive
      mode_map['i'] = 'I' -- Insert
      mode_map['v'] = 'V' -- Visual
      mode_map['V'] = 'VL' -- Visual Line
      mode_map[''] = 'VB' -- Visual Block
      mode_map['t'] = ' ' -- Terminal
      mode_map['c'] = ' ' -- Command
      mode_map['R'] = 'R' -- Replace
      g.airline_mode_map = mode_map

      local filetype_overrides = g.airline_filetype_overrides
      if filetype_overrides == nil then
        filetype_overrides = {}
      end
      filetype_overrides.help = { 'Help', '%f' }
      g.airline_filetype_overrides = filetype_overrides
    end,
    config = function()
      -- Enables detection of whitespace errors.
      g['airline#extensions#whitespace#enabled'] = 0
      -- Don't show the encoding if it's what it should be.
      g['airline#parts#ffenc#skip_expected_string'] = 'utf-8[unix]'
      g['airline#extensions#nvimlsp#enabled'] = 1
      -- Don't show line numbers for errors and warnings
      g['airline#extensions#lsp#show_line_numbers'] = 0
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
        local airline = require("lazy.core.config").plugins['vim-airline']
        if airline ~= nil and airline._.loaded ~= nil and g['airline#extensions#tabline#enabled'] ~= 0 then
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
      if tabline_timer ~= nil then
        tabline_timer:start(0, 300, tablineUpdate)
      end
    end
  },
  {
    "startup-nvim/startup.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    opts = {
      -- every line should be same width without escaped \
      header = {
        type = "text",
        oldfiles_directory = false,
        align = "center",
        fold_section = false,
        title = "Header",
        margin = 5,
        content = require("config/header"),
        highlight = "StartupHeader",
        default_color = "",
        oldfiles_amount = 0,
      },
      body = {
        type = "mapping",
        oldfiles_directory = false,
        align = "center",
        fold_section = false,
        title = "Basic Commands",
        margin = 5,
        content = {
          { "  New File", "lua require'startup'.new_file()", "n" },
          { "󰚰  Update Plugins", "Lazy update", "u" },
          { "  Option Terminal", "term", "t" },
        },
        highlight = "StartupCommands",
        default_color = "",
        oldfiles_amount = 0,
      },
      body_2 = {
        type = "oldfiles",
        oldfiles_directory = false,
        align = "center",
        fold_section = false,
        title = "Oldfiles",
        margin = 5,
        content = "",
        highlight = "StartupOldfiles",
        default_color = "",
        oldfiles_amount = 5,
      },
      body_3 = {
        type = "oldfiles",
        oldfiles_directory = true,
        align = "center",
        fold_section = true,
        title = "",
        margin = 5,
        content = "",
        highlight = "StartupDirOldfiles",
        oldfiles_amount = 5,
      },
      clock = {
        type = "text",
        content = function()
          local clock = " " .. os.date("%H:%M")
          local date = " " .. os.date("%Y-%m-%d")
          return { clock, date }
        end,
        oldfiles_directory = false,
        align = "center",
        fold_section = false,
        title = "",
        margin = 5,
        highlight = "StartupClock",
        default_color = "",
        oldfiles_amount = 0,
      },
      footer = {
        type = "text",
        oldfiles_directory = false,
        align = "center",
        fold_section = false,
        title = "Footer",
        margin = 5,
        content = function()
          local lazy = require("lazy")
          local plugins = lazy.plugins()
          local total_plugins = #plugins
          return { "Lazy Plugins: " .. total_plugins }
        end,
        highlight = "StartupFooter",
        default_color = "",
        oldfiles_amount = 0,
      },

      options = {
        mapping_keys = true,
        cursor_column = 0.5,
        empty_lines_between_mappings = false,
        disable_statuslines = true,
        paddings = { 1, 1, 1, 1, 1, 1 },
      },
      mappings = {
        execute_command = "<CR>",
        open_file = "o",
        open_file_split = "<c-o>",
        open_section = "<TAB>",
        open_help = "?",
      },
      colors = {
        background = "#0000FF",
        folded_section = "FF0000",
      },
      parts = { "header", "body", "body_2", "body_3", "clock", "footer" },
    },
  },
}


