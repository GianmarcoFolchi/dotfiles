-- set colorscheme to nightfly with protected call
-- in case it isn't installed
local status, _ = pcall(vim.cmd, "colorscheme nightfly")
if not status then
	print("Colorscheme not found! (Probably need to edit colorscheme.lua)") -- print error if colorscheme not installed
	return
end
