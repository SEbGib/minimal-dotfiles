-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Load work-specific SSH remote configuration if available
local ssh_remote_config = vim.fn.stdpath("config") .. "/lua/config/ssh-remote.lua"
if vim.fn.filereadable(ssh_remote_config) == 1 then
  local ssh_remote = require("config.ssh-remote")
  if ssh_remote and ssh_remote.init then
    ssh_remote.init()
  end
end