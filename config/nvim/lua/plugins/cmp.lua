local vim = vim
local fn = vim.fn
local api = vim.api
local lsp = vim.lsp

return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- Pulls in some preexisting vscode snippets for vsnip.
      "rafamadriz/friendly-snippets",
      -- Completions from LSP.
      {
        "hrsh7th/cmp-nvim-lsp",
        config = function()
          -- used to enable autocompletion (assign to every lsp server config)
          local cmp_nvim_lsp = require("cmp_nvim_lsp")
          local capabilities = cmp_nvim_lsp.default_capabilities()

          lsp.config('*', {
            capabilities = capabilities,
          })

          cmp_nvim_lsp.setup()
        end
      },
      -- Completions from buffer.
      "hrsh7th/cmp-buffer",
      -- Completions from path.
      "hrsh7th/cmp-path",
      -- Completions from cmd history.
      "hrsh7th/cmp-cmdline",
      -- Completions from vsnip.
      "hrsh7th/cmp-vsnip",
      -- VSCode compatible snippets.
      "hrsh7th/vim-vsnip",
      -- Expands lsp compat with snippets.
      "hrsh7th/vim-vsnip-integ",
      -- Completions for zsh.
      {
        "tamago324/cmp-zsh",
        opts = {
          zshrc = true,
          filestypes = { "zsh" },
        },
      },
      -- Completions for nvim lua.
      "hrsh7th/cmp-nvim-lua",
      -- Completions for dap prompts.
      "rcarriga/cmp-dap",
    },
    config = function()
      local t = function(str) return api.nvim_replace_termcodes(str, true, true, true) end
      local cmp = require("cmp")
      local check_back_space = function()
        local col = fn.col('.') - 1
        return col == 0 or fn.getline('.'):sub(col, col):match('%s') ~= nil
      end
      local has_words_before = function()
        local line, col = unpack(api.nvim_win_get_cursor(0))
        return col ~= 0 and api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
      cmp.setup({
        enabled = function()
          return api.nvim_get_option_value("buftype", {buf = 0}) ~= "prompt" or require("cmp_dap").is_dap_buffer()
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
            fn["vsnip#anonymous"](args.body)
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
          -- ['<Up>'] = cmp.mapping.select_prev_item(),
          -- ['<Down>'] = cmp.mapping.select_next_item(),
          -- ['<Left>'] = cmp.mapping.close(),
          -- ['<Right>'] = cmp.mapping.close(),
          ['<D-Up>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 's'}),
          ['<D-Down>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 's'}),
          ['<D-ESC>'] = cmp.mapping.abort(),
          ['<D-CR>'] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() and cmp.get_selected_entry() ~= nil then
              cmp.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
              })
            else
              cmp.abort()
              fallback()
            end
          end, {
              "i", "s"
          }),
          ["<ESC>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.abort()
            end
            fallback()
          end, {
              "i", "s"
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if fn.pumvisible() == 1 then
              api.nvim_feedkeys(t"<C-n>", "n", false)
            elseif cmp.visible() then
              cmp.select_next_item()
            elseif vim.call("vsnip#available", 1) ~= 0 then
              fn.feedkeys(t"<Plug>(vsnip-expand-or-jump)", "")
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
            if fn.pumvisible == 1 then
              api.nvim_feedkey(t"<C-p>", "n", false)
            elseif cmp.visible() then
              cmp.select_prev_item()
            elseif vim.call("vsnip#available", -1) ~= 0 then
              fn.feedkeys(t"<Plug>(vsnip-jump-prev)", "")
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
    end
  },
}
