-- import comment plugin safely
local setup, buffer_manager = pcall(require, "buffer_manager")
if not setup then
	return
end
-- import telescope actions safely
local actions_setup, bmui = pcall(require, "buffer_manager.ui")
if not actions_setup then
	return
end

local map = vim.keymap.set
local opts = { noremap = true }

-- enable buffer manager
buffer_manager.setup({

	defaults = {
		mappings = {
			i = {
				["<leader>b"] = bmui.toggle_quick_menu,
				["<C-j>"] = bmui.nav_next,
				["<C-k>"] = bmui.nav_prev,
			},
		},
	},

	-- map({ 't', 'n' }, '<leader>b', bmui.toggle_quick_menu, opts)
	-- map('n', '<C-j>', bmui.nav_next, opts)
	-- map('n', '<C-k>', bmui.nav_prev, opts)
})
