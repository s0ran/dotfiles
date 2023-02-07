vim.cmd.packadd 'packer.nvim'
local packer = require 'packer'

packer.startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'rebelot/kanagawa.nvim'
    use 'github/copilot.vim'
end)
