-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local is_git_dir = function()
  return os.execute("git rev-parse --is-inside-work-tree >> /dev/null 2>&1")
end

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local bufferPath = vim.fn.expand("%:p")
    if vim.fn.isdirectory(bufferPath) ~= 0 then
      local ts_builtin = require("telescope.builtin")
      if is_git_dir() == 0 then
        ts_builtin.git_files({ show_untracked = true })
      else
        ts_builtin.find_files()
      end
    end
  end,
})
