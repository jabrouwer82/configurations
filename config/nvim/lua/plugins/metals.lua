local vim = vim

return {
  "jabrouwer82/nvim-metals",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    -- 'nvim-lua/lsp-status.nvim',
    'nvim-telescope/telescope.nvim',
    {
      "mfussenegger/nvim-dap",
      config = function()
        local dap = require("dap")
        dap.configurations.scala = {
        }
      end,
    }
  },
  cmd = { "MetalsInstall", "MetalsInfo" },
  ft = { "scala", "sbt", "java" },
  keys = {
    { "<space>i", "<cmd>MetalsOrganizeImports<CR>", mode = "n", desc = "Organize imports" },
    { "<space>t", '<cmd>lua require"metals.tvp".toggle_tree_view()<CR>', mode = "n", desc = "Toggle tree view" },
    { "<space>rt", '<cmd>lua require"metals.tvp".reveal_in_tree()<CR>', mode = "n", desc = "Show current symbol in tree view" },
    { "<space>m", "<cmd>Telescope metals commands theme=dropdown<cr>", mode = "n", desc = "Search metals commands" },
  },
  opts = function()
    -- local lsp_status = require('lsp-status')
    local metals_config = require("metals").bare_config()
    metals_config.settings = {
      excludedPackages = {
        "akka.actor.typed.javadsl",
      },
      showImplicitArguments = true,
      showImplicitConversionsAndClasses = true,
      showInferredType = true,
      superMethodLensesEnabled = true,
      useGlobalExecutable = true,
    }

    -- *READ THIS*
    -- I *highly* recommend setting statusBarProvider to either "off" or "on"
    --
    -- "off" will enable LSP progress notifications by Metals and you'll need
    -- to ensure you have a plugin like fidget.nvim installed to handle them.
    --
    -- "on" will enable the custom Metals status extension and you *have* to have
    -- a have settings to capture this in your statusline or else you'll not see
    -- any messages from metals. There is more info in the help docs about this
    metals_config.init_options.statusBarProvider = "off"

    -- Example if you are using cmp how to make sure the correct capabilities for snippets are set
    metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

    metals_config.on_attach = function()
      require("metals").setup_dap()
      -- lsp_status.on_attach(client)
    end

    return metals_config
  end,
  config = function(self, metals_config)
    local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = self.ft,
      callback = function()
        require("metals").initialize_or_attach(metals_config)
      end,
      group = nvim_metals_group,
    })
  end,
}
