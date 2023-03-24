-- import comment plugin safely
local setup, scrollbar = pcall(require, "scrollbar")
if not setup then
	return
end

-- enable scrollbar
scrollbar.setup()
