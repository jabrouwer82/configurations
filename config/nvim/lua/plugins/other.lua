local vim = vim

return {
  -- Better Quick Fix window, adds a preview window.
  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
  },
  'junegunn/fzf',
  'junegunn/fzf.vim',
  'tpope/vim-characterize',
  'tpope/vim-unimpaired', -- Lots of really nice movement mappings.
  'w0rp/ale', -- Display live linter output.
  'tpope/vim-commentary', -- Quick comment toggle command.
  'chrisbra/Recover.vim',
  'gre/play2vim', -- Syntax, etc for play route/conf/scala.html.
  'sheerun/vim-polyglot', -- All the syntax plugins I could ever need.
  'markonm/traces.vim', -- Preview for substitute commands.
  'jeffkreeftmeijer/vim-numbertoggle', -- Toggle rnu/nu on insert vs normal modes.
  -- 'TaDaa/vimade', -- Fades inactive buffers.
  'qpkorr/vim-bufkill', -- Provides a command to close a buffer but keep its window.
  'regedarek/zoomwin', -- Provides a tmux-like zoom function.
  'andrewradev/bufferize.vim', -- Allows output of commands to be opened in their own normal buffer.
  'airblade/vim-rooter', -- Finds the root of the project for open files.
  'tpope/vim-markdown',
  'moll/vim-bbye', -- Dependency for vim-symlink.
  'aymericbeaumet/vim-symlink', -- Automatically follow symlinks.
  'tpope/vim-surround', -- cs/ds/ys/css/dss/yss to change/delete/surround a word/line.
  'tpope/vim-repeat', -- Allow . to work with (some) plugins.
  'glts/vim-magnum', -- Numeric library, dependency for radical.
  'glts/vim-radical', -- gA, crd/crx/cro/crb for decimal/hex/octal/binary conversions.
  'arthurxavierx/vim-caser', -- Change cases.
  'tpope/vim-rhubarb', -- Github plugin for fugitive
  'zdharma-continuum/zinit-vim-syntax', -- Syntax highlighting for zinit.
  'roman/golden-ratio', -- Automatically resize windows.
  -- 'jabrouwer82/vim-scala', -- My customized version of derekwyatt/vim-scala.
  'GEverding/vim-hocon', -- Syntax for lightbend/config hocon files.
  'chlorophyllin/jproperties.vim', -- Add syntax support for java properties files.
  'fatih/vim-go', -- Add full go support.
  'jesseleite/vim-agriculture', -- Adds :RgRaw, which can pass flags to ripgrep.
  'tpope/vim-endwise', -- Helps end structures like if/endif
  'tpope/vim-abolish', -- Case-aware find/replace :S
  {
    'lambdalisue/vim-suda', -- Adds :SudaWrite and :SudaRead for a workaround to :w !sudo tee... not working in nvim.
    config = function()
      vim.g.suda_smart_edit = 1
      vim.api.nvim_create_user_command('W', ':SudaWrite<CR>', { desc = 'Sudo write file using suda plugin.' })
    end,
  },
}
