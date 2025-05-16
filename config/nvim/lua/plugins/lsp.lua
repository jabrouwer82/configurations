local vim = vim
local lsp = vim.lsp
local api = vim.api
local diagnostic = vim.diagnostic

ListLsps = function()
  local clients = lsp.get_clients()
  local bufClients = lsp.get_clients({ bufnr = 0 })
  local res = {}
  local bufRes = {}
  for _, bufClient in ipairs(bufClients) do
    local name = bufClient.name
    if not TableContains(bufRes, name) then
      table.insert(bufRes, name)
    end
  end
  for _, client in ipairs(clients) do
    local name = client.name
    if not TableContains(bufRes, name) and not TableContains(res, name) then
      table.insert(res, name)
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

local severity = diagnostic.severity

return {
  {
    'neovim/nvim-lspconfig', -- Default lsp configs for a variety of languages.
    dependencies = {
      "mason-org/mason.nvim",
      {
        "nanotee/sqls.nvim",
        ft = "sql",
      },
    },
    event = { "BufReadPre" },
    keys = {
      -- This is handled in my vimrc.
      -- map("n", "K", "<cmd>lua lsp.buf.hover()<CR>")

      -- Generally using <space> as a sort of lsp <leader>.
      { "<space>c",     function() lsp.codelens.run() end,               mode = "n", desc = "Run current codelens" },
      { "<space>n",     function() lsp.buf.rename() end,                 mode = "n", desc = "Rename symbol" },
      { "<space>f",     function() lsp.buf.format({ async = true }) end, mode = "n", desc = "Format buffer" },
      { "<space>f",     function() lsp.buf.format({ async = true }) end, mode = "v", desc = "Format buffer" },
      { "<space>;",     function() lsp.buf.code_action() end,            mode = "n", desc = "Run available code action" },
      { "<space><tab>", function() lsp.buf.signature_help() end,         mode = "n", desc = "Show docs for current function signature" },
      { "<M- >",        function() lsp.buf.signature_help() end,         mode = "i", desc = "Show docs for current function signature" },
      {
        "[d",
        function()
          diagnostic.jump({count = -1})
          api.nvim_feedkeys('zz', 'm', false)
        end,
        mode = "n",
        desc = "Goto previous diagnostic"
      },
      {
        "]d",
        function()
          diagnostic.jump({count = 1})
          api.nvim_feedkeys('zz', 'm', false)
        end,
        mode = "n",
        desc = "Goto next diagnostic"
      },
      {
        "[w",
        function()
          diagnostic.jump({ count = -1, severity = { severity.WARN, severity.ERROR } })
          api.nvim_feedkeys('zz', 'm', false)
        end,
        mode = "n",
        desc = "Goto previous warning or error diagnostic"
      },
      {
        "]w",
        function()
          diagnostic.jump({ count = 1, severity = { severity.WARN, severity.ERROR } })
          api.nvim_feedkeys('zz', 'm', false)
        end,
        mode = "n",
        desc = "Goto next warning or error diagnostic"
      },
      {
        "[E",
        function()
          diagnostic.jump({ count = -1, severity = severity.ERROR })
          api.nvim_feedkeys('zz', 'm', false)
        end,
        mode = "n",
        desc = "Goto previous error diagnostic"
      },
      {
        "]E",
        function()
          diagnostic.jump({ count = 1, severity = severity.ERROR })
          api.nvim_feedkeys('zz', 'm', false)
        end,
        mode = "n",
        desc = "Goto next error diagnostic"
      },
      -- Fallbacks where I prefer the telescope version.
      { "<space><space>d",  function() lsp.buf.document_symbol() end,  mode = "n", desc = "Open document symbols in quickfix" },
      { "<space><space>gr", function() lsp.buf.references() end,       mode = "n", desc = "Open references in quickfix" },
      { "<space><space>s",  function() lsp.buf.workspace_symbol() end, mode = "n", desc = "Open all workspace symbols in quickfix" },
      { "<space><space>a",  function() diagnostic.setqflist() end,     mode = "n", desc = "Show workspace diagnostics in quickfix" },
      { "<space><space>b",  function() diagnostic.setloclist() end,    mode = "n", desc = "Set loc with buffer diagnostics" },
      { "<space><space>gd", function() lsp.buf.definition() end,       mode = "n", desc = "Goto definition" },
      { "<space><space>gi", function() lsp.buf.implementation() end,   mode = "n", desc = "Goto implementation" },
      { "<space><space>y",  function() lsp.buf.type_definition() end,  mode = "n", desc = "Goto type definition" },
      {
        "<space><space>e",
        function()
          diagnostic.setqflist({ severity = severity.ERROR })
        end,
        mode = "n",
        desc = "Show all errors in quickfix"
      },
      {
        "<space><space>w",
        function()
          diagnostic.setqflist({ severity = severity.WARN })
        end,
        mode = "n",
        desc = "Show all warning in quickfix"
      },
      -- Other lsp functions I've seen mapped:
      -- diagnostic.open_float()
      -- lsp.buf.declaration
    },
    -- See https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    config = function()
      local lspconfig = require('lspconfig')

      -- used to enable autocompletion (assign to every lsp server config)
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      local referencesGroup = vim.api.nvim_create_augroup("highlight_usage", { clear = true })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI", }, {
        group = referencesGroup,
        callback = function ()
          local supported = false
          for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
            if client then
              supported = client:supports_method('textDocument/documentHighlight')
            end
            if supported then
              break
            end
          end
          if supported then
            vim.lsp.buf.document_highlight()
          end
        end
      })
      vim.api.nvim_create_autocmd({ "CursorMoved" }, {
        group = referencesGroup,
        callback = function ()
          vim.lsp.buf.clear_references()
        end
      })

      local lsp_defaults = lspconfig.util.default_config
      lsp_defaults.capabilities = vim.tbl_deep_extend('force', lsp_defaults.capabilities,
        cmp_nvim_lsp.default_capabilities())
    end,
  },
  -- Handlers for lsp functions like codeActions, binds to lsp.buf.* rather than :Telescope.
  {
    'gbrlsnchs/telescope-lsp-handlers.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
  },
  {
    "folke/lazydev.nvim", -- Better lua support.
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "j-hui/fidget.nvim",
    opts = {
      progress = {
        display = {
          done_style = "FidgetProgressDone",
          progress_style = "FidgetProgress",
          group_style = "FidgetGroup",
          icon_style = "FidgetIcon",
        },
      },
      notification = {
        view = {
          group_separator_hl = "FidgetGroupSeparator",
        },
        window = {
          normal_hl = "FidgetNormal",
          -- border = { "▗", "▄" ,"▖", "▌", "▘", "▀", "▝", "▐" },
          -- border = { "▄", "▄" ,"▄", "█", "▀", "▀", "▀", "█" },
          -- border = { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" },
          -- border = { "▛", "▔" ,"▜", "▕", "▟", "▁", "▙", "▏" },
          border = { "▛", "▀" ,"▜", "▐", "▟", "▄", "▙", "▌" },
          border_hl = "FidgetBorder",
          winblend = 0,
        },
      }
    },
  },
}
