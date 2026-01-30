local set = vim.keymap.set

-- Clipboard
set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })

-- Grug far
set("n", "<leader>g", "<CMD>GrugFar<CR>", { desc = "Open GrugFar" })

-- Testing
set("n", "<leader>tr", function()
  require("neotest").run.run()
end, { desc = "Run nearest test" })

-- Code
set('n', '<leader>aa', function() require("sidekick.cli").toggle() end,
  { desc = "sidekick toggle cli" })

set('n', '<leader>as', function() require("sidekick.cli").select({ filter = { installed = true } }) end,
  { desc = "Select CLI" })

set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions" })
set({ "n", "i", "v" }, "<tab>", function()
  if require("sidekick").nes_jump_or_apply() then
    return
  end

  if vim.lsp.inline_completion.get() then
    return
  end
  return "<tab>"
end, { expr = true, desc = "Goto/Apply Next Edit Suggestion" })

set("n", "g?", function() vim.diagnostic.open_float() end, { desc = "Show Diagnostic" })

-- Get file name
set('n', '<leader>cf', ":let @+=expand('%:.')<cr>", { desc = 'Copy relative path' })
set('n', '<leader>cF', ':let @+=@%<cr>', { desc = 'Copy absolute path' })


-- Mutli-cursor
set({ "v", "x" }, "<leader>s", function() require("multicursor-nvim").matchCursors() end,
  { desc = "[MULTC] All Search Matches" })
set("n", ",", function() require("multicursor-nvim").clearCursors() end, { desc = "[MULTC] Clear Cursors" })

-- Lazygit
-- Using JJ for now
-- set("n", "<M-g>", function() Snacks.lazygit.open() end, { desc = "Lazygit" })

-- Jujutsu UI
set("n", "<M-g>", function()
  Snacks.terminal("jjui", {
    win = {
      style = "lazygit",
    },
  })
end, { desc = "Jujutsu UI" })

-- Snacks
set("n", "<leader>sd", function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })
set("n", "<leader>j", function() require("jj.picker").status() end, { desc = "Jujutsu status" })
set("n", "<leader>h", function() require("jj.picker").file_history() end, { desc = "Jujutsu file history" })
set("n", "<leader>f", function() Snacks.picker.files() end, { desc = "Find Files" })
set("n", "<leader>/", function() Snacks.picker.grep() end, { desc = "Live Grep" })
set("n", "<leader>b", function()
  Snacks.picker.buffers({
    current = false,
    sort_lastused = true,
  })
end, { desc = "Live Grep" })
set("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Go to Definition" })
set("n", "gD", function() Snacks.picker.lsp_declarations() end, { desc = "Go to Declaration" })
set("n", "gR", function() Snacks.picker.lsp_references() end, { desc = "Go to References" })
set("n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "Go to Implementations" })
set("n", "<leader>.", function() Snacks.scratch() end, { desc = "Toggle Scratch Buffer" })
set("n", "<leader>S", function() Snacks.scratch.select() end, { desc = "Select Scratch Buffer" })

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
