-- import indentLine plugin safely
local setup, indentLine = pcall(require, "indentLine")
if not setup then
	return
end

-- enable indentLine
indentLine.setup()

vim.api.nvim_command("autocmd Filetype json let g:indentLine_enabled = 0")
