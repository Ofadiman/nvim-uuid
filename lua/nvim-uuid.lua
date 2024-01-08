local M = {
  options = {
    should_move_cursor_after_generating_uuid = true,
    case = "lower",
  },
}

local function is_command_available(name)
  local command = nil

  if vim.fn.has("win32") == 1 then
    command = "where"
  else
    command = "which"
  end

  return os.execute(command .. " " .. name .. " > /dev/null 2>&1") == 0
end

function M.uuid()
  local command = "uuidgen"

  if is_command_available(command) == false then
    error("command \"" .. command .. "\" not available")
    return
  end

  local uuidgenOutput = ""
  local handle = io.popen(command, "r")
  if handle then
    uuidgenOutput = handle:read("*a")
    handle:close()
  else
    error("Something went wrong while opening file handle for " .. command .. " command")
    return
  end

  -- Trim whitespaces and new lines from generated uuid string
  local uuid = uuidgenOutput:gsub("^[%s\n]*(.-)[%s\n]*$", "%1")
  if M.options.case == "upper" then
    uuid = string.upper(uuid)
  elseif M.options.case == "lower" then
    uuid = string.lower(uuid)
  else
    error("case " .. M.options.case .. " not supported")
  end

  local win = vim.api.nvim_get_current_win()
  local row, col = unpack(vim.api.nvim_win_get_cursor(win))
  local line = vim.api.nvim_get_current_line()
  local new_line = line:sub(1, col) .. uuid .. line:sub(col + 1)
  vim.api.nvim_set_current_line(new_line)

  if M.options.should_move_cursor_after_generating_uuid == true then
    vim.api.nvim_win_set_cursor(win, { row, col + string.len(uuid) })
  end
end

function M.setup(opts)
  if opts.should_move_cursor_after_generating_uuid ~= nil then
    if type(opts.should_move_cursor_after_generating_uuid) ~= "boolean" then
      error("should_move_cursor_after_generating_uuid should be a boolean")
    end

    M.options.should_move_cursor_after_generating_uuid = opts.should_move_cursor_after_generating_uuid
  end

  if opts.case ~= nil then
    if type(opts.case) ~= "string" then
      error("case should be a string")
    end

    if not (opts.case == "lower" or opts.case == "upper") then
      error("case must be set to \"upper\" or \"lower\"")
    end

    M.options.case = opts.case
  end
end

return M
