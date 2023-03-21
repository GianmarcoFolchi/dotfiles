-- import buffer_manager plugin safely
local setup, buffer_manager = pcall(require, "buffer_manager")
if not setup then
	return
end

-- enable buffer_manager
buffer_manager.setup({
	select_menu_item_commands = {
		v = {
			key = "<C-v>",
			command = "vsplit",
		},
		h = {
			key = "<C-h>",
			command = "split",
		},
	},
	short_file_names = true,
	short_term_names = true,
})

vim.api.nvim_command([[
autocmd FileType buffer_manager vnoremap K :m '<-2<CR>gv=gv
autocmd FileType buffer_manager vnoremap J :m '>+1<CR>gv=gv
]])
