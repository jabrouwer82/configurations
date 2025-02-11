local vim = vim
local fn = vim.fn
local cmd = vim.cnd

return {
  'mfussenegger/nvim-dap',
  'nvim-telescope/telescope.nvim',
  'nvim-telescope/telescope-dap.nvim',
  {
    -- Enable virtual text variables contents.
    'theHamsta/nvim-dap-virtual-text',
    opts = {
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = true,
      show_stop_reason = true,
      commented = true,
      only_first_definition = true,
    }
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "nvim-neotest/nvim-nio"
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup({
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
      })
      fn.sign_define("DapBreakpoint", {text='', texthl='DapBreakpointSign', linehl='DapBreakpointLine', numhl='DapBreakpointNum'})
      fn.sign_define("DapStopped", {text='', texthl='DapStoppedSign', linehl='DapStoppedLine', numhl='DapStoppedNum'})
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
        cmd("set cmdheight=2")
      end
      -- dap.listeners.after.event_terminated["dapui_config"] = function()
      --   dapui.close("sidebar")
      -- end
      -- dap.listeners.after.event_exited["dapui_config"] = function()
      --   dapui.close("sidebar")
      -- end
    end,
    keys = {
      { "<CR>c", [[<cmd>lua require"dap".continue()<CR>]], mode = "n", desc = "DAP: Continue" },
      { "<CR>s", [[<cmd>lua require"dap".close()<CR>]], mode = "n", desc = "DAP: Stop" },
      { "<CR>l", [[<cmd>lua require"dap".run_last()<CR>]], mode = "n", desc = "DAP: Run Last" },

      { "<CR>b", [[<cmd>lua require"dap".toggle_breakpoint()<CR>]], mode = "n", desc = "DAP: Toggle breakpoint" },
      { "<CR>e", [[<cmd>lua require"dap".set_exception_breakpoints({"all"})<CR>]], mode = "n", desc = "DAP: Set exception breakpoints" },

      { "<CR><Left>", [[<cmd>lua require"dap".step_back()<CR>]], mode = "n", desc = "DAP: Step back" },
      { "<CR><Right>", [[<cmd>lua require"dap".step_over()<CR>]], mode = "n", desc = "DAP: Step over" },
      { "<CR><Up>", [[<cmd>lua require"dap".step_out()<CR>]], mode = "n", desc = "DAP: Step out" },
      { "<CR><Down>", [[<cmd>lua require"dap".step_into()<CR>]], mode = "n", desc = "DAP: Step into" },
      { "<CR>.", [[<cmd>lua require"dap".run_to_cursor()<CR>]], mode = "n", desc = "DAP: Continue to cursor" },

      { "<CR><S-Up>", [[<cmd>lua require"dap".up()<CR>]], mode = "n", desc = "DAP: Go up the call stack" },
      { "<CR><S-Down>", [[<cmd>lua require"dap".down()<CR>]], mode = "n", desc = "DAP: Go down the call stack" },

      { "<CR>r", [[<cmd>lua require"dap".repl.toggle({}, 'vsplit')<CR>]], mode = "n", desc = "DAP: Toggle repl/results" },
      { "<CR>k", [[<cmd>lua require"dap.ui.widgets".hover()<CR>]], mode = "n", desc = "DAP: Show hover widget" },
      { "<CR>?", [[<cmd>lua local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes)<CR>]], mode = "n", desc = "DAP: Show hover widget" },
      { "<CR>ui", [[<cmd>lua require"dapui".toggle();cmd("set cmdheight=2")<CR>]], mode = "n", desc = "DAP: Toggle ui" },
      { "<CR>;", [[<cmd>lua require'dapui'.eval();cmd("set cmdheight=2")<CR>]], mode = "v", desc = "DAP: Evaluate highlighted text" },

      { "<CR>f", [[<cmd>Telescope dap frames<CR>]], mode = "n", desc = "DAP: Explore stack frames" },
      { "<CR>p", [[<cmd>Telescope dap list_breakpoints<CR>]], mode = "n", desc = "DAP: Explore breakpoints" },
      { "<CR>v", [[<cmd>Telescope dap variables<CR>]], mode = "n", desc = "DAP: Explore variables" },
      { "<CR>:", [[<cmd>Telescope dap commands<CR>]], mode = "n", desc = "DAP: Explore commands" },
    },
  },
}
