ListLsps = function()
  local clients = vim.lsp.get_clients()
  local bufClients = vim.lsp.get_clients({ bufnr = 0 })
  local res = {}
  local bufRes = {}
  for _, bufClient in ipairs(bufClients) do
    table.insert(bufRes, bufClient.name)
  end
  for _, client in ipairs(clients) do
    if not TableContains(bufRes, client.name) then
      table.insert(res, client.name)
    end
  end
  if next(bufRes) == nil and next(res) == nil then
    return ""
  elseif next(res) == nil then
    return "(" .. table.concat(bufRes, ", ") .. ")"
  elseif next(bufRes) == nil then
    return "[" .. table.concat(res, ", ") .. "]"
  else
    return "(" .. table.concat(bufRes, ", ") .. ")[" .. table.concat(res, ", ") .. "]"
  end
end

TableContains = function(tabl, elem)
  for _, el in ipairs(tabl) do
    if el == elem then
      return true
    end
  end
  return false
end


LspCurrentFunc = function()
end

local severity = vim.diagnostic.severity

return {
  'w0rp/ale',                -- Display live linter output.
  {
    'neovim/nvim-lspconfig', -- Default lsp configs for a variety of languages.
    dependencies = {
      "williamboman/mason.nvim",
      {
        "nanotee/sqls.nvim",
        ft = "sql",
      },
    },
    event = { "BufReadPre" },
    keys = {
      -- This is handled in my vimrc.
      -- map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")

      -- Generally using <space> as a sort of lsp <leader>.
      { "<space>c",     function() vim.lsp.codelens.run() end,               mode = "n", desc = "Run current codelens" },
      { "<space>n",     function() vim.lsp.buf.rename() end,                 mode = "n", desc = "Rename symbol" },
      { "<space>f",     function() vim.lsp.buf.format({ async = true }) end, mode = "n", desc = "Format buffer" },
      { "<space>f",     function() vim.lsp.buf.format({ async = true }) end, mode = "v", desc = "Format buffer" },
      { "<space>;",     function() vim.lsp.buf.code_action() end,            mode = "n", desc = "Run available code action" },
      { "<space><tab>", function() vim.lsp.buf.signature_help() end,         mode = "n", desc = "Show docs for current function signature" },
      { "<M- >",        function() vim.lsp.buf.signature_help() end,         mode = "i", desc = "Show docs for current function signature" },
      {
        "[d",
        function()
          vim.diagnostic.goto_prev()
          vim.api.nvim_feedkeys('zz', 'm', false)
        end,
        mode = "n",
        desc = "Goto previous diagnostic"
      },
      {
        "]d",
        function()
          vim.diagnostic.goto_next()
          vim.api.nvim_feedkeys('zz', 'm', false)
        end,
        mode = "n",
        desc = "Goto next diagnostic"
      },
      {
        "[w",
        function()
          vim.diagnostic.goto_prev({ severity = { severity.WARN, severity.ERROR } })
          vim.api.nvim_feedkeys('zz', 'm', false)
        end,
        mode = "n",
        desc = "Goto previous warning or error diagnostic"
      },
      {
        "]w",
        function()
          vim.diagnostic.goto_next({ severity = { severity.WARN, severity.ERROR } })
          vim.api.nvim_feedkeys('zz', 'm', false)
        end,
        mode = "n",
        desc = "Goto next warning or error diagnostic"
      },
      {
        "[E",
        function()
          vim.diagnostic.goto_prev({ severity = severity.ERROR })
          vim.api.nvim_feedkeys('zz', 'm', false)
        end,
        mode = "n",
        desc = "Goto previous error diagnostic"
      },
      {
        "]E",
        function()
          vim.diagnostic.goto_next({ severity = severity.ERROR })
          vim.api.nvim_feedkeys('zz', 'm', false)
        end,
        mode = "n",
        desc = "Goto next error diagnostic"
      },
      -- Fallbacks where I prefer the telescope version.
      { "<space><space>d",  function() vim.lsp.buf.document_symbol() end,  mode = "n", desc = "Open document symbols in quickfix" },
      { "<space><space>gr", function() vim.lsp.buf.references() end,       mode = "n", desc = "Open references in quickfix" },
      { "<space><space>s",  function() vim.lsp.buf.workspace_symbol() end, mode = "n", desc = "Open all workspace symbols in quickfix" },
      { "<space><space>a",  function() vim.diagnostic.setqflist() end,     mode = "n", desc = "Show workspace diagnostics in quickfix" },
      { "<space><space>b",  function() vim.diagnostic.setloclist() end,    mode = "n", desc = "Set loc with buffer diagnostics" },
      { "<space><space>gd", function() vim.lsp.buf.definition() end,       mode = "n", desc = "Goto definition" },
      { "<space><space>gi", function() vim.lsp.buf.implementation() end,   mode = "n", desc = "Goto implementation" },
      { "<space><space>y",  function() vim.lsp.buf.type_definition() end,  mode = "n", desc = "Goto type definition" },
      {
        "<space><space>e",
        function()
          vim.diagnostic.setqflist({ severity = severity.ERROR })
        end,
        mode = "n",
        desc = "Show all errors in quickfix"
      },
      {
        "<space><space>w",
        function()
          vim.diagnostic.setqflist({ severity = severity.WARN })
        end,
        mode = "n",
        desc = "Show all warning in quickfix"
      },
      -- Other lsp functions I've seen mapped:
      -- vim.diagnostic.open_float()
      -- vim.lsp.buf.declaration
    },
    -- See https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    config = function()
      local lspconfig = require('lspconfig')
      -- import mason_lspconfig plugin
      local mason_lspconfig = require("mason-lspconfig")

      -- import cmp-nvim-lsp plugin
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      -- used to enable autocompletion (assign to every lsp server config)
      local capabilities = cmp_nvim_lsp.default_capabilities()

      mason_lspconfig.setup_handlers({
        -- default handler for installed servers
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end,
        ["sqls"] = function()
          lspconfig['sqls'].setup({
            on_attach = function(client, bufnr)
              require('sqls').on_attach(client, bufnr)
            end,
            capabilities = capabilities,
          })
        end,
        ["bashls"] = function()
          lspconfig['bashls'].setup({
            filetypes = { "sh", "zsh", "bash" },
            capabilities = capabilities,
          })
        end,
        ["dockerls"] = function()
          lspconfig["dockerls"].setup({
            settings = {
              docker = {
                languageserver = {
                  formatter = {
                    ignoreMultilineInstructions = true,
                  },
                },
              }
            }
          })
        end,
        ["vimls"] = function()
          lspconfig['vimls'].setup({
            capabilities = capabilities,
          })
        end,
        ["jsonls"] = function()
          lspconfig['jsonls'].setup({
            capabilities = capabilities,
          })
        end,
        ["yamlls"] = function()
          lspconfig['yamlls'].setup({
            capabilities = capabilities,
          })
        end,
        ["lua_ls"] = function()
          -- configure lua server (with special settings)
          lspconfig["lua_ls"].setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                runtime = {
                  -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                  version = 'LuaJIT',
                },
                diagnostics = {
                  -- Get the language server to recognize the `vim` global
                  globals = { 'vim' },
                },
                -- Make the server aware of Neovim runtime files
                workspace = {
                  library = {
                    vim.env.VIMRUNTIME,
                  },
                  checkThirdParty = false,
                }
              }
            },
          })
        end,
      })

      local lsp_defaults = lspconfig.util.default_config
      lsp_defaults.capabilities = vim.tbl_deep_extend('force', lsp_defaults.capabilities,
        cmp_nvim_lsp.default_capabilities())
    end,
  },
  -- Easy access to lsp status messages.
  -- {
  --   'nvim-lua/lsp-status.nvim',
  --   config = function()
  --     local lsp_status = require('lsp-status')
  --     lsp_status.register_progress()
  --     lsp_status.config {
  --       current_function = true,
  --       diagnostics = false,
  --       status_symbol = '',
  --       select_symbol = function(cursor_pos, symbol)
  --         if symbol.valueRange then
  --           local value_range = {
  --             ["start"] = {
  --               character = 0,
  --               line = vim.fn.byte2line(symbol.valueRange[1])
  --             },
  --             ["end"] = {
  --               character = 0,
  --               line = vim.fn.byte2line(symbol.valueRange[2])
  --             }
  --           }
  --           return require("lsp-status.util").in_range(cursor_pos, value_range)
  --         end
  --       end
  --     }
  --   end,
  -- },
  -- Handlers for lsp functions like codeActions, binds to vim.lsp.buf.* rather than :Telescope.
  {
    'gbrlsnchs/telescope-lsp-handlers.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
  },
  -- Better lua support.
  'folke/neodev.nvim',
  {
    "j-hui/fidget.nvim",
    opts = {},
  },
}
