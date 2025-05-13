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
    "goolord/alpha-nvim",
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      local utils = require("alpha.utils")

      local path_ok, plenary_path = pcall(require, "plenary.path")
      if not path_ok then
        return
      end

      local dashboard = require("alpha.themes.dashboard")
      local if_nil = vim.F.if_nil

      local file_icons = {
        enabled = true,
        highlight = true,
        -- available: devicons, mini, to use nvim-web-devicons or mini.icons
        -- if provider not loaded and enabled is true, it will try to use another provider
        provider = "devicons",
      }

      local function icon(fn)
        if file_icons.provider ~= "devicons" and file_icons.provider ~= "mini" then
          vim.notify("Alpha: Invalid file icons provider: " .. file_icons.provider .. ", disable file icons", vim.log.levels.WARN)
          file_icons.enabled = false
          return "", ""
        end

        local ico, hl = utils.get_file_icon(file_icons.provider, fn)
        if ico == "" then
          file_icons.enabled = false
          vim.notify("Alpha: Mini icons or devicons get icon failed, disable file icons", vim.log.levels.WARN)
        end
        return ico, hl
      end

      local function file_button(fn, sc, short_fn, autocd)
        short_fn = short_fn or fn
        local ico_txt
        local fb_hl = {}

        if file_icons.enabled then
          local ico, hl = icon(fn)
          local hl_option_type = type(file_icons.highlight)
          if hl_option_type == "boolean" then
            if hl and file_icons.highlight then
              table.insert(fb_hl, { hl, 0, #ico })
            end
          end
          if hl_option_type == "string" then
            table.insert(fb_hl, { file_icons.highlight, 0, #ico })
          end
          ico_txt = ico .. "  "
        else
          ico_txt = ""
        end
        local cd_cmd = (autocd and " | cd %:p:h" or "")
        local file_button_el =
        dashboard.button(sc, ico_txt .. short_fn, "<cmd>e " .. vim.fn.fnameescape(fn) .. cd_cmd .. " <CR>")
        local fn_start = short_fn:match(".*[/\\]")
        if fn_start ~= nil then
          table.insert(fb_hl, { "Comment", #ico_txt - 2, #fn_start + #ico_txt })
        end
        file_button_el.opts.hl = fb_hl
        return file_button_el
      end

      local default_mru_ignore = { "gitcommit" }

      local mru_opts = {
        ignore = function(path, ext)
          return (string.find(path, "COMMIT_EDITMSG")) or (vim.tbl_contains(default_mru_ignore, ext))
        end,
        autocd = false,
      }

      --- @param start number
      --- @param cwd string? optional
      --- @param items_number number? optional number of items to generate, default = 10
      local function mru(start, cwd, items_number, opts)
        opts = opts or mru_opts
        items_number = if_nil(items_number, 10)

        local oldfiles = {}
        for _, v in pairs(vim.v.oldfiles) do
          if #oldfiles == items_number then
            break
          end
          local cwd_cond
          if not cwd then
            cwd_cond = true
          else
            cwd_cond = vim.startswith(v, cwd)
          end
          local ignore = (opts.ignore and opts.ignore(v, utils.get_extension(v))) or false
          if (vim.fn.filereadable(v) == 1) and cwd_cond and not ignore then
            oldfiles[#oldfiles + 1] = v
          end
        end
        local target_width = 50

        local tbl = {}
        for i, fn in ipairs(oldfiles) do
          local short_fn
          if cwd then
            short_fn = vim.fn.fnamemodify(fn, ":.")
          else
            short_fn = vim.fn.fnamemodify(fn, ":~")
          end

          if #short_fn > target_width then
            short_fn = plenary_path.new(short_fn):shorten(1, { -2, -1 })
            if #short_fn > target_width then
              short_fn = plenary_path.new(short_fn):shorten(1, { -1 })
            end
          end

          local shortcut = tostring(i + start - 1)

          local file_button_el = file_button(fn, shortcut, short_fn, opts.autocd)
          tbl[i] = file_button_el
        end
        return {
          type = "group",
          val = tbl,
          opts = {},
        }
      end

      local header = {
        type = "text",
        val = {
[[                                                        _▄▓█▀`_▄▀]],
[[                               ,                ,█▄,▄████▀╠▄▓█▀`]],
[[                            _▄█` _           _▄████████████▀"]],
[[                   _    _▄▓██╙_▄█"         ███▀▀████████████▄▄]],
[[                 ╓█▌▄▓████▓▄▓██"      ⌐ ▄ ▐██▄▓█████████████▄▄,_]],
[[             _,▄████████████▀       ╒█▌▐████████████████████████▀"]],
[[            ███▀╠█████████████▀     ╟██████▀╓███████████████████▄,]],
[[       ▄ ╓  ██▓████████████████▓▄▄_ ██████▀ ██   ██████"▀▀██████████▓▄]],
[[      ██,████████████████████████"` ╘▀▀╓▄▄▄██▄████▀"       ╙████████████]],
[[      ███████"██▀▀█████████████████▄▄,██▀` ▓███▀            `█████████▌""]],
[[     ▐█████▀▀▐█M _▓████▀▀ ╙▀████████████▄                    └█████████▄]],
[[      ▀▀ ▄▄▄▓▀█████▀          ╙███████████                    ████████"╙]],
[[       ▄█▀" ²████`    ▄█  ,     ▀███████▄                     ████████▄]],
[[        `          ╓▓█▀ ╓█"      ████████▌                   ,████████▌]],
[[            ╥  ,▄▓██▀▄▓█▀        ▐████████⌐                 _█████████M]],
[[          _██▓████████▀           ████████▌                ▄█████████▌]],
[[        ,▓████████████▓▄▄        ▐████████▌              ▄██████████▌]],
[[      ▓██"╟█████████████▄▄▄▄_   ┌███████▌▀            ╓▓███████████▀]],
[[      ██▄███████████████████╙  ▄████████           ▄▓█████████████]],
[[ █ ╫███████████████████████████████████▌     _╓▄████████████████"]],
[[╫███████╟██▀▀███████▀██████████████████▄▄▄▓███████████████████╙]],
[[▐██████N▐█  ,███▀▀"  ,█████████████████████████████████████▀"]],
[[ ██▀▀ ,▄██████"    ╓▓███████████████████████████████████▀"]],
[[ ` ▄█▀Γ Φ███"   ▄▓█████████████████████████████████▀▀"]],
[[   ▀Γ        ╓▓███████████████████████████████▀▀"]],
[[          ,▄█████████████████████████▀▀▀"'              ___,___]],
[[         ▓███████████████████▀▀""                _▄▄████████████████▓▄,]],
[[       ▄███████████████▀▀"                   _▄██████████████████████████▄,]],
[[      ▄██████████████▀                    ,▄████████████████████████████████▄]],
[[     ▐██████████████                   _▄████████████████████▀▀▀▀█████████████_]],
[[     ██████████████"                 ▄█████████████████▀╙            `╙▀▀██████]],
[[     ███████████████               ▄███████████████▀▀                     `▀████]],
[[     ████████████████▓▄_        ╓▓███████████████▀                           ▀██]],
[[     ██████████████████████████████████████████▀                              ╙█]],
[[      ███████████████████████████████████████▀]],
[[       ▀███████████████████████████████████▀]],
[[        '▀███████████████████████████████▀]],
[[           ╙▀██████████████████████████▀]],
[[               ╙▀███████████████████▀"]],
        },
        opts = {
          position = "center",
          hl = "AlphaHeader",
          -- wrap = "overflow";
        },
      }

      local section_mru = {
        type = "group",
        val = {
          {
            type = "text",
            val = "Recent files",
            opts = {
              hl = "AlphaMru",
              shrink_margin = false,
              position = "center",
            },
          },
          { type = "padding", val = 1 },
          {
            type = "group",
            val = function()
              return { mru(0, vim.fn.getcwd()) }
            end,
            opts = { shrink_margin = false },
          },
        },
      }

      local buttons = {
        type = "group",
        val = {
          { type = "text", val = "Quick links", opts = { hl = "AlphaQuickLinks", position = "center" } },
          { type = "padding", val = 1 },
          dashboard.button("e", "  New file", "<cmd>ene<CR>"),
          dashboard.button("SPC f f", "󰈞  Find file"),
          dashboard.button("SPC f g", "󰊄  Live grep", "<cmd>RG<CR>"),
          dashboard.button("c", "  Configuration", "<cmd>cd $CFG<CR>"),
          dashboard.button("u", "  Update plugins", "<cmd>Lazy sync<CR>"),
          dashboard.button("q", "󰅚  Quit", "<cmd>qa<CR>"),
        },
        position = "center",
      }

      local config = {
        layout = {
          { type = "padding", val = 2 },
          header,
          { type = "padding", val = 2 },
          section_mru,
          { type = "padding", val = 2 },
          buttons,
        },
        opts = {
          margin = 5,
          setup = function()
            vim.api.nvim_create_autocmd('DirChanged', {
              pattern = '*',
              group = "alpha_temp",
              callback = function ()
                require('alpha').redraw()
                vim.cmd('AlphaRemap')
              end,
            })
          end,
        },
      }


      require("alpha").setup(
        config
      )
    end,
  },
}
