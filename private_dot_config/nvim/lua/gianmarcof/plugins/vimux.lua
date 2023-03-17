-- import comment plugin safely
local setup, vimux = pcall(require, "vimux")
if not setup then
	return
end

-- enable comment
vimux.setup()
