-- import comment plugin safely
local setup, buffer_manager = pcall(require, "buffer_manager")
if not setup then
  return
end
local map = vim.keymap.set
local opts = {noremap = true}
-- enable buffer manager
buffer_manager.setup({
  local bmui = require("buffer_manager.ui")

  map({ 't', 'n' }, '<leader>b', bmui.toggle_quick_menu, opts)
  map('n', '<C-j>', bmui.nav_next, opts)
  map('n', '<C-k>', bmui.nav_prev, opts) 
})
