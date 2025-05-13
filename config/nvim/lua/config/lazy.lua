local vim = vim
local fn = vim.fn
local map = vim.keymap.set

-- Bootstrap lazy.nvim
local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ";"
vim.g.maplocalleader = "//"

-- Highlight debugging.
-- noremap <leader>` :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
--   \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
--   \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
map("n", "<leader>`", ":Inspect<cr>", { desc = "Debug highlight group." })

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "jacob" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
