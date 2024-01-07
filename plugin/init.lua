require("nvim-uuid")

-- This file will be executed automatically when the plugin is loaded, so all global functions declared in this file will be available to lua.
-- For example, `vim.api.nvim_set_keymap("n", "<leader>ut", "<cmd>lua GlobalFunction()<CR>", { noremap = true, silent = true })` will allow to execute global function.
function GlobalFunction()
  print("debugging...")
end
