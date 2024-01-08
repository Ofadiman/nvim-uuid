local M = {}

local function is_command_available(name)
  local command = nil

  if vim.fn.has("win32") == 1 then
    command = "where"
  else
    command = "which"
  end

  return os.execute(command .. " " .. name) == 0
end

function M.uuid()
  local command = "uuidgen"

  if is_command_available(command) == false then
    print("Error: command \"" .. command .. "\" not available.")
    return
  end

  local uuidgenOutput = ""
  local handle = io.popen(command, "r")
  if handle then
    uuidgenOutput = handle:read("*a")
    handle:close()
  else
    print("Error: something went wrong while opening file handle for " .. command .. " command.")
    return
  end

  -- Trim whitespaces and new lines from generated uuid string
  local uuid = uuidgenOutput:gsub("^[%s\n]*(.-)[%s\n]*$", "%1")
  local _, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  local new_line = line:sub(1, col) .. uuid .. line:sub(col + 1)
  vim.api.nvim_set_current_line(new_line)
end

-- The `setup` function is a convention in the neovim plugin environment that allows to configure a plugin.
function M.setup(opts)
  local options = opts or {}
  print("configuring plugin with options:", options)
end

return M
