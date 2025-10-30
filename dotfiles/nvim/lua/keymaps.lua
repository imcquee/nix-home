local set = vim.keymap.set

-- Clipboard
set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })

-- Code
set('n', '<leader>aa', function() require("sidekick.cli").toggle() end,
  { desc = "sidekick toggle cli" })

set('n', '<leader>as', function() require("sidekick.cli").select({ filter = { installed = true } }) end,
  { desc = "Select CLI" })

set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions" })


-- Mutli-cursor
set({ "v", "x" }, "<leader>s", function() require("multicursor-nvim").matchCursors() end,
  { desc = "[MULTC] All Search Matches" })
set("n", ",", function() require("multicursor-nvim").clearCursors() end, { desc = "[MULTC] Clear Cursors" })

-- Lazygit
set("n", "<M-g>", function() Snacks.lazygit.open() end, { desc = "Lazygit" })



-- Snacks
vim.keymap.set("n", "<leader>f", function() Snacks.picker.files() end, { desc = "Find Files" })
vim.keymap.set("n", "<leader>/", function() Snacks.picker.grep() end, { desc = "Live Grep" })
vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Go to Definition" })
vim.keymap.set("n", "gD", function() Snacks.picker.lsp_declarations() end, { desc = "Go to Definition" })
vim.keymap.set("n", "gr", function() Snacks.picker.lsp_references() end, { desc = "Go to Definition" })
vim.keymap.set("n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "Go to Definition" })

-- Flash
set({ "n", "x", "o" }, "gw", function()
  require("flash").jump()
end, { desc = "Flash" })

set({ "n", "x", "o" }, "S", function()
  require("flash").treesitter()
end, { desc = "Flash Treesitter" })

set("o", "r", function()
  require("flash").remote()
end, { desc = "Remote Flash" })

set({ "o", "x" }, "R", function()
  require("flash").treesitter_search()
end, { desc = "Treesitter Search" })

set("c", "<c-s>", function()
  require("flash").toggle()
end, { desc = "Toggle Flash Search" })

-- Yazi
set({ "n", "v" }, "<M-y>", "<cmd>Yazi<cr>", {
  desc = "Open yazi at the current file"
})

set("n", "<leader>cw", "<cmd>Yazi cwd<cr>", {
  desc = "Open the file manager in nvim's working directory"
})

set("n", "<c-up>", "<cmd>Yazi toggle<cr>", {
  desc = "Resume the last yazi session"
})
