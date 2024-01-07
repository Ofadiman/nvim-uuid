local M = {}

function M.uuid()
  print("uuid function called")
end

-- The `setup` function is a convention in the neovim plugin environment that allows to configure a plugin.
function M.setup(opts)
  local options = opts or {}
  print("configuring plugin with options:", options)
end

return M
