-- import harpoon plugin safely
local setup, harpoon = pcall(require, "harpoon")
if not setup then
	return
end

-- enable harpoon
harpoon.setup()
