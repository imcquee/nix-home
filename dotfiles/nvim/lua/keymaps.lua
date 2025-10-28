local set = vim.keymap.set

-- Clipboard
set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })

-- Code
set('n', '<leader>ca', function() require('fzf-lua').lsp_code_actions() end, { desc = 'Code action' })
set('n', '<leader>aa', function() require("sidekick.cli").toggle() end,
  { desc = "sidekick toggle cli" })

set('n', '<leader>as', function() require("sidekick.cli").select({ filter = { installed = true } }) end,
  { desc = "Select CLI" })


-- Mutli-cursor
set({ "v", "x" }, "<leader>s", function() require("multicursor-nvim").matchCursors() end,
  { desc = "[MULTC] All Search Matches" })
set("n", ",", function() require("multicursor-nvim").clearCursors() end, { desc = "[MULTC] Clear Cursors" })

-- Lazygit
set("n", "<M-g>", function() require("snacks").lazygit.open() end, { desc = "Lazygit" })

-- Fzf-lua
set("n", "<leader>f", function()
  require("fzf-lua").files()
end, {
  desc = "Open File in cwd"
})
set("n", "<leader>/", function()
  require("fzf-lua").live_grep()
end, {
  desc = "Live Grep in cwd"
})
set("n", "<leader>b", function()
  require("fzf-lua").buffers()
end, {
  desc = "Open Buffers"
})
set("n", "<leader>gr", function() require('fzf-lua').lsp_references() end, { desc = 'Find References' })
set("n", "<leader>gd", function() require('fzf-lua').lsp_definitions() end, { desc = 'Find Definitions' })

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
