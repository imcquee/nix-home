-- Clipboard
vim.keymap.set({"n", "v"}, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set({"n", "v"}, "<leader>p", '"+p', { desc = "Paste from system clipboard" })

-- Code
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action' })

-- Lazygit
vim.keymap.set("n", "<M-g>", "<cmd>LazyGit<cr>", { desc = "Lazygit" })

-- Fzf-lua
vim.keymap.set("n", "<leader>f", function() 
  require("fzf-lua").files()
end, {
  desc = "Open File in cwd"
})

-- Flash
vim.keymap.set({"n", "x", "o"}, "s", function() 
  require("flash").jump() 
end, { desc = "Flash" })

vim.keymap.set({"n", "x", "o"}, "S", function() 
  require("flash").treesitter() 
end, { desc = "Flash Treesitter" })

vim.keymap.set("o", "r", function() 
  require("flash").remote() 
end, { desc = "Remote Flash" })

vim.keymap.set({"o", "x"}, "R", function() 
  require("flash").treesitter_search() 
end, { desc = "Treesitter Search" })

vim.keymap.set("c", "<c-s>", function() 
  require("flash").toggle() 
end, { desc = "Toggle Flash Search" })

-- Yazi
vim.keymap.set({"n", "v"}, "<M-y>", "<cmd>Yazi<cr>", {
  desc = "Open yazi at the current file"
})

vim.keymap.set("n", "<leader>cw", "<cmd>Yazi cwd<cr>", {
  desc = "Open the file manager in nvim's working directory"
})

vim.keymap.set("n", "<c-up>", "<cmd>Yazi toggle<cr>", {
  desc = "Resume the last yazi session"
})
