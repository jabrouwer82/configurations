return {
  -- Fuzzy finder with great UI.
  'nvim-telescope/telescope.nvim',
  version = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'softinio/scaladex.nvim', -- Plugin for searching scaladex for packages
    'xiyaowong/telescope-emoji.nvim', -- Plugin for searching emojis
    {
      'sudormrfbin/cheatsheet.nvim', -- Plugin for searching cheatsheets
      requires = {
        'nvim-lua/popup.nvim',
      }
    },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
  },
  keys = {
    -- Files and buffers
    { "<leader><space>", "<cmd>Telescope find_files hidden=true<cr>", mode = "n", desc = "Search files in current workspace" },
    { "<leader><cr>", "<cmd>Telescope buffers sort_lastused=true sort_mru=true<cr>", mode = "n", desc = "Search currently open buffers" },
    -- I think I want to show the current buffer, but I'm not sure so I'm leaving this version that hides the current buffer in for now.
    -- { "<leader><cr>", "<cmd>Telescope buffers sort_lastused=true ignore_current_buffer=true sort_mru=true<cr>", mode = "n", desc = "Search currently open buffers" },
    { "<leader>h", "<cmd>Telescope oldfiles<cr>", mode = "n", desc = "Search recently opened files" },

    -- Vim stuff
    { "<leader>:", "<cmd>Telescope command_history theme=dropdown<cr>", mode = "n", desc = "Search command history" },
    { "<leader>::", "<cmd>Telescope commands theme=dropdown<cr>", mode = "n", desc = "Search defined vim commands" },
    { "<leader>//", "<cmd>Telescope search_history theme=dropdown<cr>", mode = "n", desc = "Search vim search history" },
    { "<leader>m", "<cmd>Telescope keymaps<cr>", mode = "n", desc = "Search vim maps" },

    -- Git stuff
    { "<leader>g", "<cmd>Telescope git_files<cr>", mode = "n", desc = "Search git changed files" },
    { "<leader>?", "<cmd>Telescope git_bcommits<cr>", mode = "n", desc = "Search git commits for current buffer" },
    { "<leader>??", "<cmd>Telescope git_commits<cr>", mode = "n", desc = "Search git commits for current project" },

    -- Other
    { "<leader><tab>", "<cmd>Telescope spell_suggest theme=dropdown<cr>", mode = "n", desc = "Search spelling corrections" },
    { "<leader>e", "<cmd>Telescope emoji theme=dropdown<cr>", mode = "n", desc = "Search emojis (copied to clipboard" },
    { "<leader>cs", "<cmd>Telescope cheatsheet theme=dropdown<cr>", mode = "n", desc = "Search emojis (copied to clipboard)" },
    { "<leader>sd", "<cmd>lua require'telescope'.extensions.scaladex.scaladex.search()<cr>", mode = "n", desc = "Search scaladex packages" },

    -- LSP
    { "<space>d", "<cmd>Telescope lsp_document_symbols<cr>", mode = "n", desc = "Search document symbols" },
    { "<space>gr", "<cmd>Telescope lsp_references<cr>", mode = "n", desc = "Search references to current symbol" },
    { "<space>s", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", mode = "n", desc = "Search workspace symbols" },
    { "<space>a", "<cmd>Telescope diagnostics<cr>", mode = "n", desc = "Search lsp workspace diagnostics" },
    { "<space>b", "<cmd>Telescope diagnostics bufnr=0<cr>", mode = "n", desc = "Search lsp buffer diagnostics" },
    { "<space>e", "<cmd>Telescope diagnostics severity=E<cr>", mode = "n", desc = "Search lsp workspace error diagnostics" },
    { "<space>w", "<cmd>Telescope diagnostics severity=W<cr>", mode = "n", desc = "Search lsp workspace warning diagnostics" },
    { "<space>gd", "<cmd>Telescope lsp_definitions<cr>", mode = "n", desc = "Search lsp for definitions of current symbol" },
    { "<space>gi", "<cmd>Telescope lsp_implementations<cr>", mode = "n", desc = "Search lsp for implementations of current symbol" },
    { "<space>gy", "<cmd>Telescope lsp_type_definitions<cr>", mode = "n", desc = "Search lsp for type definitions of current symbol" },

  },
  opts = {
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
          ["<esc>"] = "close",
          ["<C-u>"] = false,
        },
      },
    },
    pickers = {
      oldfiles = {
        tiebreak = function(current_entry, existing_entry, _)
          return current_entry.index < existing_entry.index
        end
      },
    },
  },
  config = function(self, config)
    require("telescope").setup(config)
    require("telescope").load_extension("lsp_handlers")
    require("telescope").load_extension("emoji")
    require("telescope").load_extension("cheatsheet")
    require("telescope").load_extension("scaladex")
    require("telescope").load_extension("dap")
    require('telescope').load_extension('fzf')
  end,
}
