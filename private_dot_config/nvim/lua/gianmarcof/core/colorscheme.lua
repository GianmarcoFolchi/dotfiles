-- set colorscheme to nightfly with protected call
-- in case it isn't installed
local status, _ = pcall(vim.cmd, "colorscheme oxocarbon")
if not status then
	print("Colorscheme not found! (Probably need to edit packer_compiled.lua)") -- print error if colorscheme not installed
	return
end
