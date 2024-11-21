set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath


source ~/.config/nvim/vimrc.vim


lua require("config.lazy")

