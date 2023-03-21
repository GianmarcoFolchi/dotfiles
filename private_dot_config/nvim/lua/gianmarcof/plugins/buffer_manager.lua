-- import buffer_manager plugin safely
local setup, buffer_manager = pcall(require, "buffer_manager")
if not setup then
	return
end

-- enable buffer_manager
buffer_manager.setup()
