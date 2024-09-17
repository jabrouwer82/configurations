local fn = vim.fn
local api = vim.api
local map = vim.keymap.set
local t = function(str) return vim.api.nvim_replace_termcodes(str, true, true, true) end
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
---@type boolean|string
local packer_bootstrap = false
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

ListLsps = function()
  local clients = vim.lsp.get_active_clients()
  local res = {}
  for _, msg in ipairs(clients) do
    table.insert(res, '[' .. msg.name .. ']')
  end
  return table.concat(res, " ")
end

return require('packer').startup(function(use)
  -- Let packer manage itself.
  use 'wbthomason/packer.nvim'

  -- Completions plugin.
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      -- Completions from LSP.
      { "hrsh7th/cmp-nvim-lsp" },
      -- Completions from buffer.
      { "hrsh7th/cmp-buffer" },
      -- Completions from path.
      { "hrsh7th/cmp-path" },
      -- Completions from cmd history.
      { "hrsh7th/cmp-cmdline" },
      -- Completions from vsnip.
      { "hrsh7th/cmp-vsnip" },
      -- VSCode compatible snippets.
      { "hrsh7th/vim-vsnip" },
      -- Expands lsp compat with snippets.
      { "hrsh7th/vim-vsnip-integ" },
      -- Completions for zsh.
      { "tamago324/cmp-zsh" },
      -- Completions for nvim lua.
      { "hrsh7th/cmp-nvim-lua" },
      -- Completions for dap prompts.
      { "rcarriga/cmp-dap" },
    },
  })
  -- Scala LSP plugin, more full featured than lspconfig.
  use({
    "scalameta/nvim-metals",
    requires = {
      -- Useful functions.
      "nvim-lua/plenary.nvim",
      -- Debug Adapter Protocol.
      "mfussenegger/nvim-dap",
    },
  })
  -- Better Quick Fix window, adds a preview window.
  use {'kevinhwang91/nvim-bqf', ft = 'qf'}
  -- Default lsp configs for a variety of languages.
  use 'neovim/nvim-lspconfig'
  -- Pulls in some preexisting vscode snippets for vsnip.
  use "rafamadriz/friendly-snippets"
  -- Fuzzy finder with great UI.
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'}, }
  }
  -- Handlers for lsp functions like codeActions, binds to vim.lsp.buf.* rather than :Telescope.
  use {'gbrlsnchs/telescope-lsp-handlers.nvim'}
  -- Telescope plugin for searching emojis
  use {'xiyaowong/telescope-emoji.nvim'}
  -- Telescope plugin for searching cheatsheets
  use {
    'sudormrfbin/cheatsheet.nvim',
    requires = {
      {'nvim-telescope/telescope.nvim'},
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
    }
  }
  -- Telescope plugin for searching scaladex for packages
  use { 'softinio/scaladex.nvim' }

  -- Easy access to lsp status messages.
  use { 'nvim-lua/lsp-status.nvim' }

  -- Better lua support.
  use { 'folke/neodev.nvim' }

  -- DAP UI
  use { 'nvim-telescope/telescope-dap.nvim' }
  use { 'theHamsta/nvim-dap-virtual-text' }
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }
  use { 'nvim-treesitter/playground' }
  use { 'nvim-treesitter/nvim-treesitter-textobjects' }
  use { 'nvim-treesitter/nvim-treesitter-context' }
  use { 'JoosepAlviste/nvim-ts-context-commentstring' }

  use {
    'kristijanhusak/vim-dadbod-ui',
    requires = {
      { 'tpope/vim-dadbod', lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
    },
  }

  use {
    'gsuuon/model.nvim',
  }

  --------------
  -- Mappings --
  --------------

  ------------------
  -- LSP mappings --
  ------------------
  -- This is handled in my vimrc.
  -- map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")

  -- Generally using <space> as a sort of lsp <leader>.
  map("n", "<space>c", [[<cmd>lua vim.lsp.codelens.run()<CR>]], {desc = "Run current codelens"})
  map("n", "<space>n", "<cmd>lua vim.lsp.buf.rename()<CR>", {desc = "Rename symbol"})
  map("n", "<space>f", "<cmd>lua vim.lsp.buf.format({async=true})<CR>", {desc = "Format buffer"})
  map("n", "<space>i", "<cmd>MetalsOrganizeImports<CR>", {desc = "Organize imports"})
  map("n", "<space>;", "<cmd>lua vim.lsp.buf.code_action()<CR>", {desc = "Run available code action"})
  map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", {desc = "Goto previous diagnostic"})
  map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", {desc = "Goto next diagnostic"})
  map("n", "<space>t", '<cmd>lua require"metals.tvp".toggle_tree_view()<CR>', {desc = "Toggle tree view"})
  map("n", "<space>rt", '<cmd>lua require"metals.tvp".reveal_in_tree()<CR>', {desc = "Show current symbol in tree view"})
  map("n", "<space><tab>", [[<cmd>lua vim.lsp.buf.signature_help()<CR>]], {desc = "Show docs for current function signature"})
  map("i", "<M- >", [[<cmd>lua vim.lsp.buf.signature_help()<CR>]], {desc = "Show docs for current function signature"})
  -- Fallbacks where I prefer the telescope version.
  map("n", "<space><space>d", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", {desc = "Open document symbols in quickfix"})
  map("n", "<space><space>gr", "<cmd>lua vim.lsp.buf.references()<CR>", {desc = "Open references in quickfix"})
  map("n", "<space><space>s", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", {desc = "Open all workspace symbols in quickfix"})
  map("n", "<space><space>a", [[<cmd>lua vim.diagnostic.setqflist()<CR>]], {desc = "Show workspace diagnostics in quickfix"})
  map("n", "<space><space>b", "<cmd>lua vim.diagnostic.setloclist()<CR>", {desc = "Set loc with buffer diagnostics"})
  map("n", "<space><space>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Goto definition"})
  map("n", "<space><space>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", {desc = "Goto implementation"})
  map("n", "<space><space>y", "<cmd>lua vim.lsp.buf.type_definition()<CR>", {desc = "Goto type definition"})
  map("n", "<space><space>e", [[<cmd>lua vim.diagnostic.setqflist({severity = "E"})<CR>]], {desc = "Show all errors in quickfix"})
  map("n", "<space><space>w", [[<cmd>lua vim.diagnostic.setqflist({severity = "W"})<CR>]], {desc = "Show all warning in quickfix"})
  -- Other lsp functions I've seen mapped:
  -- vim.diagnostic.open_float()
  -- vim.lsp.buf.declaration

  ------------------
  -- DAP mappings --
  ------------------
  map("n", "<CR>c", [[<cmd>lua require"dap".continue()<CR>]], {desc = "DAP: Continue"})
  map("n", "<CR>s", [[<cmd>lua require"dap".close()<CR>]], {desc = "DAP: Stop"})
  map("n", "<CR>l", [[<cmd>lua require"dap".run_last()<CR>]], {desc = "DAP: Run Last"})

  map("n", "<CR>b", [[<cmd>lua require"dap".toggle_breakpoint()<CR>]], {desc = "DAP: Toggle breakpoint"})
  map("n", "<CR>e", [[<cmd>lua require"dap".set_exception_breakpoints({"all"})<CR>]], {desc = "DAP: Set exception breakpoints"})

  map("n", "<CR><Left>", [[<cmd>lua require"dap".step_back()<CR>]], {desc = "DAP: Step back"})
  map("n", "<CR><Right>", [[<cmd>lua require"dap".step_over()<CR>]], {desc = "DAP: Step over"})
  map("n", "<CR><Up>", [[<cmd>lua require"dap".step_out()<CR>]], {desc = "DAP: Step out"})
  map("n", "<CR><Down>", [[<cmd>lua require"dap".step_into()<CR>]], {desc = "DAP: Step into"})
  map("n", "<CR>.", [[<cmd>lua require"dap".run_to_cursor()<CR>]], {desc = "DAP: Continue to cursor"})

  map("n", "<CR><S-Up>", [[<cmd>lua require"dap".up()<CR>]], {desc = "DAP: Go up the call stack"})
  map("n", "<CR><S-Down>", [[<cmd>lua require"dap".down()<CR>]], {desc = "DAP: Go down the call stack"})

  map("n", "<CR>r", [[<cmd>lua require"dap".repl.toggle({}, 'vsplit')<CR>]], {desc = "DAP: Toggle repl/results"})
  map("n", "<CR>k", [[<cmd>lua require"dap.ui.widgets".hover()<CR>]], {desc = "DAP: Show hover widget"})
  map("n", "<CR>?", [[<cmd>lua local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes)<CR>]], {desc = "DAP: Show hover widget"})
  map("n", "<CR>ui", [[<cmd>lua require"dapui".toggle();vim.cmd("set cmdheight=2")<CR>]], {desc = "DAP: Toggle ui"})
  map("v", "<CR>;", [[<cmd>lua require'dapui'.eval();vim.cmd("set cmdheight=2")<CR>]], {desc = "DAP: Evaluate highlighted text"})

  map("n", "<CR>f", [[<cmd>Telescope dap frames<CR>]], {desc = "DAP: Explore stack frames"})
  map("n", "<CR>p", [[<cmd>Telescope dap list_breakpoints<CR>]], {desc = "DAP: Explore breakpoints"})
  map("n", "<CR>v", [[<cmd>Telescope dap variables<CR>]], {desc = "DAP: Explore variables"})
  map("n", "<CR>:", [[<cmd>Telescope dap commands<CR>]], {desc = "DAP: Explore commands"})

  ---------------
  -- Telescope --
  ---------------
  -- Files/buffers
  map("n", "<leader><space>", "<cmd>Telescope find_files hidden=true<cr>", {desc = "Search files in current workspace"})
  map("n", "<leader><cr>", "<cmd>Telescope buffers sort_lastused=true sort_mru=true<cr>", {desc = "Search currently open buffers"})
  -- I think I want to show the current buffer, but I'm not sure so I'm leaving this in for now.
  -- map("n", "<leader><cr>", "<cmd>Telescope buffers sort_lastused=true ignore_current_buffer=true sort_mru=true<cr>", {desc = "Search currently open buffers"})
  map("n", "<leader>h", "<cmd>Telescope oldfiles<cr>", {desc = "Search recently opened files"})
  -- Vim stuff
  map("n", "<leader>:", "<cmd>Telescope command_history theme=dropdown<cr>", {desc = "Search command history"})
  map("n", "<leader>::", "<cmd>Telescope commands theme=dropdown<cr>", {desc = "Search defined vim commands"})
  map("n", "<leader>//", "<cmd>Telescope search_history theme=dropdown<cr>", {desc = "Search vim search history"})
  map("n", "<leader>m", "<cmd>Telescope keymaps<cr>", {desc = "Search vim maps"})
  -- Git stuff
  map("n", "<leader>g", "<cmd>Telescope git_files<cr>", {desc = "Search git changed files"})
  map("n", "<leader>?", "<cmd>Telescope git_bcommits<cr>", {desc = "Search git commits for current buffer"})
  map("n", "<leader>??", "<cmd>Telescope git_commits<cr>", {desc = "Search git commits for current project"})
  -- Other
  map("n", "<leader><tab>", "<cmd>Telescope spell_suggest theme=dropdown<cr>", {desc = "Search spelling corrections"})
  map("n", "<leader>e", "<cmd>Telescope emoji theme=dropdown<cr>", {desc = "Search emojis (copied to clipboard"})
  map("n", "<leader>cs", "<cmd>Telescope cheatsheet theme=dropdown<cr>", {desc = "Search emojis (copied to clipboard)"})
  map("n", "<leader>sd", "<cmd>lua require'telescope'.extensions.scaladex.scaladex.search()<cr>", {desc = "Search scaladex packages"})
  -- LSP
  map("n", "<space>d", "<cmd>Telescope lsp_document_symbols<cr>", {desc = "Search document symbols"})
  map("n", "<space>gr", "<cmd>Telescope lsp_references<cr>", {desc = "Search references to current symbol"})
  map("n", "<space>s", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", {desc = "Search workspace symbols"})
  map("n", "<space>a", "<cmd>Telescope diagnostics<cr>", {desc = "Search lsp workspace diagnostics"})
  map("n", "<space>b", "<cmd>Telescope diagnostics bufnr=0<cr>", {desc = "Search lsp buffer diagnostics"})
  map("n", "<space>e", "<cmd>Telescope diagnostics severity=E<cr>", {desc = "Search lsp workspace error diagnostics"})
  map("n", "<space>w", "<cmd>Telescope diagnostics severity=W<cr>", {desc = "Search lsp workspace warning diagnostics"})
  map("n", "<space>gd", "<cmd>Telescope lsp_definitions<cr>", {desc = "Search lsp for definitions of current symbol"})
  map("n", "<space>gi", "<cmd>Telescope lsp_implementations<cr>", {desc = "Search lsp for implementations of current symbol"})
  map("n", "<space>gy", "<cmd>Telescope lsp_type_definitions<cr>", {desc = "Search lsp for type definitions of current symbol"})
  map("n", "<space>m", "<cmd>Telescope metals commands theme=dropdown<cr>", {desc = "Search metals commands"})


  --------------
  -- NVIM-CMP --
  --------------
  local cmp = require("cmp")
  local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
  end
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end
  cmp.setup({
    enabled = function()
      return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
    end,
    -- Reverses menu order when the menu is above the cursor.
    -- view = {
    --   entries = {
    --     name = 'custom',
    --     selection_order = 'near_cursor',
    --   }
    -- },
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    formatting = {
      format = function(_, vim_item)
        vim_item.abbr = string.sub(vim_item.abbr, 1, 100)
        return vim_item
      end
    },
    mapping = cmp.mapping.preset.insert({
      -- These make some editing weird, it might be worth looking into adding a delay or cancel in addition to directions.
      ['<Up>'] = cmp.mapping.select_prev_item(),
      ['<Down>'] = cmp.mapping.select_next_item(),
      -- ['<Left>'] = cmp.mapping.close(),
      -- ['<Right>'] = cmp.mapping.close(),
      ['<D-Up>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 's'}),
      ['<D-Down>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 's'}),
      ['<D-ESC>'] = cmp.mapping.abort(),
      ['<D-CR>'] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if vim.fn.pumvisible() == 1 then
          api.nvim_feedkeys(t"<C-n>", "n", "")
        elseif cmp.visible() then
          cmp.select_next_item()
        elseif vim.call("vsnip#available", 1) ~= 0 then
          vim.fn.feedkeys(t"<Plug>(vsnip-expand-or-jump)", "")
        elseif check_back_space() then
          fallback()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, {
        "i", "s",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if vim.fn.pumvisible == 1 then
          api.nvim_feedkey(t"<C-p>", "n", "")
        elseif cmp.visible() then
          cmp.select_prev_item()
        elseif vim.call("vsnip#available", -1) ~= 0 then
          vim.fn.feedkeys(t"<Plug>(vsnip-jump-prev)", "")
        else
          fallback()
        end
      end, {
        "i", "s",
      }),
    }),
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "vsnip" },
    }, {
      { name = "nvim_lua" },
      { name = "zsh" },
    }, {
      { name = 'buffer'},
    }, {
      { name = 'dap' },
    })
  })

  -- CMP settings per filetype
  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -------------
  -- CMP-ZSH --
  -------------
  require('cmp_zsh').setup {
    zshrc = true,
    filestypes = { "zsh" },
  }

  -------------------
  -- Metals Config --
  -------------------
  local metals_config = require("metals").bare_config()

  -- local ok, cone = pcall(require, 'cone')
  -- local metalsServerProps = {}
  -- if ok then
  --   metalsServerProps = cone.C1MetalsServerProperties
  -- end

  -- Example of settings
  metals_config.settings = {
    excludedPackages = {},
    -- scalafixConfigPath = "/Users/jacobbrouwer/.scalafix.conf",
    serverProperties = metalsServerProps,
    showImplicitArguments = true,
    showImplicitConversionsAndClasses = true,
    showInferredType = true,
    superMethodLensesEnabled = true,
    useGlobalExecutable = true,
  }

  -- *READ THIS*
  -- I *highly* recommend setting statusBarProvider to true, however if you do,
  -- you *have* to have a setting to display this in your statusline or else
  -- you'll not see any messages from metals. There is more info in the help
  -- docs about this
  metals_config.init_options.statusBarProvider = "on"


  ----------------
  -- LSP Status --
  ----------------
  local lsp_status = require('lsp-status')
  lsp_status.register_progress()
  lsp_status.config {
    current_function = true,
    diagnostics = false,
    status_symbol = '',
    select_symbol = function(cursor_pos, symbol)
      if symbol.valueRange then
        local value_range = {
          ["start"] = {
            character = 0,
            line = vim.fn.byte2line(symbol.valueRange[1])
          },
          ["end"] = {
            character = 0,
            line = vim.fn.byte2line(symbol.valueRange[2])
          }
        }

        return require("lsp-status.util").in_range(cursor_pos, value_range)
      end
    end
  }

  ---------
  -- LSP --
  ---------
  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- local capabilities = require('cmp_nvim_lsp').default_capabilities(lsp_status.capabilities)

  -- Scala Metals
  metals_config.capabilities = capabilities
  metals_config.on_attach = function(client, _)
    require('metals').setup_dap()
    lsp_status.on_attach(client)
  end

  -- See https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  -- Bash
  require('lspconfig')['bashls'].setup {
    on_attach = lsp_status.on_attach,
    capabilities = capabilities,
  }
  -- VIM
  require('lspconfig')['vimls'].setup {
    on_attach = lsp_status.on_attach,
    capabilities = capabilities,
    init_options = {
      isNeovim = truem
    },
  }
  -- Json
  require('lspconfig')['jsonls'].setup {
    on_attach = lsp_status.on_attach,
    capabilities = capabilities,
  }
  -- Yaml
  require('lspconfig')['yamlls'].setup {
    on_attach = lsp_status.on_attach,
    capabilities = capabilities,
    -- settings = {
    --   redhat = { telemetry = { enabled = false } },
    --   yaml = {
    --     schemas = {
    --       ["schema"] = 'files glob'
    --     },
    --   },
    -- }
  }
  -- Lua/NVIM
  require('neodev').setup {
    -- on_attach = lsp_status.on_attach,
    -- capabilities = capabilities,
  }
  require('lspconfig')['lua_ls'].setup {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        }
      }
    }
  }

  ---------
  -- DAP --
  ---------
  -- Enable virtual text variables contents.
  require("nvim-dap-virtual-text").setup {
    enabled = true,
    enabled_commands = true,
    highlight_changed_variables = true,
    highlight_new_as_changed = true,
    show_stop_reason = true,
    commented = true,
    only_first_definition = true,
  }
  local dapui = require("dapui")
  dapui.setup {
    layouts = {
      {
        elements = {
          "breakpoints",
          "scopes",
          "stacks",
        },
        size = 80,
        position = "left",
      },
      {
        elements = { 'repl' },
        size = 24,
        position = "bottom",
      },
    },
  }
  fn.sign_define("DapBreakpoint", {text='', texthl='DapBreakpointSign', linehl='DapBreakpointLine', numhl='DapBreakpointNum'})
  fn.sign_define("DapStopped", {text='', texthl='DapStoppedSign', linehl='DapStoppedLine', numhl='DapStoppedNum'})

  local dap = require("dap")

  dap.configurations.scala = {
    {
      type = "scala",
      request = "launch",
      name = "RunOrTest",
      metals = {
        runType = "runOrTestFile",
        --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
      },
    },
    -- {
    --   type = "scala",
    --   request = "launch",
    --   name = "Test Target",
    --   metals = {
    --     runType = "testTarget",
    --   },
    -- },
  }

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open({})
    vim.cmd("set cmdheight=2")
  end
  -- dap.listeners.after.event_terminated["dapui_config"] = function()
  --   dapui.close("sidebar")
  -- end
  -- dap.listeners.after.event_exited["dapui_config"] = function()
  --   dapui.close("sidebar")
  -- end


  ---------------
  -- Telescope --
  ---------------
  local actions = require("telescope.actions")
  require("telescope").load_extension("lsp_handlers")
  require("telescope").load_extension("emoji")
  require("telescope").load_extension("cheatsheet")
  require("telescope").load_extension("scaladex")
  require("telescope").load_extension("dap")

  require('telescope').setup {
    defaults = {
      path_display = { "smart" },
      -- Adds trim and no-stats to defaults
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--no-stats",
        "--trim",
      },
      mappings = {
        i = {
          -- Esc closes in insert mode instead of switching to normal mode.
          ["<esc>"] = actions.close
        },
      },
    },
  }


  ----------------
  -- TreeSitter --
  ----------------
  require("nvim-treesitter.install").prefer_git = true
  require('nvim-treesitter.configs').setup {
    ensure_installed = { 'scala', 'lua', 'vim', 'json5', 'hocon', 'bash', 'go' },
    -- Async install
    sync_install = true,
    -- A lot of these are way less mature than the vimscript syntax files.
    -- Try re-enabling in a year or two.
    highlight = { enable = false },
    incremental_selection = { enable = true },
    indent = { enable = true },
    -- textobjects basically doesn't work for scala at all :(
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [">f"] = "@function.outer",
            ["]c"] = "@class.outer",
          },
          goto_next_end = {
            [">F"] = "@function.outer",
            ["]C"] = "@class.outer",
          },
          goto_previous_start = {
            ["<f"] = "@function.outer",
            ["[c"] = "@class.outer",
          },
          goto_previous_end = {
            ["<f"] = "@function.outer",
            ["[C"] = "@class.outer",
          },
        },
        swap = {
          enable = true,
          swap_next = {
            [">p"] = "@parameter.inner",
          },
          swap_previous = {
            ["<p"] = "@parameter.inner",
          },
        },
      },
    },
  }
  require'treesitter-context'.setup {
    enable = true,
    max_lines = 0,
    patterns = {
      default = { "object", "class", "function", "method" }
    },
  }


  -------------------
  -- Odds and Ends --
  -------------------
  -- Metals autostart config
  local nvim_metals_group = api.nvim_create_augroup("nvim-metals", { clear = true })
  api.nvim_create_autocmd("FileType", {
    -- NOTE: You may or may not want java included here. You will need it if you
    -- want basic Java support but it may also conflict if you are using
    -- something like nvim-jdtls which also works on a java filetype autocmd.
    pattern = { "scala", "sbt", "java" },
    callback = function()
      require("metals").initialize_or_attach(metals_config)
    end,
    group = nvim_metals_group,
  })

  ------------
  -- Dadbod --
  ------------
  vim.g.db_ui_use_nerd_fonts = 1



  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
