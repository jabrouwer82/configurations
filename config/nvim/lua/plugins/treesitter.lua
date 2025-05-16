return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require("nvim-treesitter").setup()
      require("nvim-treesitter.install").prefer_git = true
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'bash',
          'hocon',
          'json5',
          'lua',
          'scala',
          'vim',
          'yaml',
        },
        -- Async install
        sync_install = true,
        -- A lot of these are way less mature than the vimscript syntax files.
        -- Try re-enabling in a year or two.
        highlight = { enable = true },
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
    end
  },
  'nvim-treesitter/playground',
  'nvim-treesitter/nvim-treesitter-textobjects',
  {
    'nvim-treesitter/nvim-treesitter-context',
    opts = {
      enable = true,
      max_lines = 12,
      patterns = {
        default = { "object", "class", "function", "method" }
      },
    },
  },
  'JoosepAlviste/nvim-ts-context-commentstring',
}

