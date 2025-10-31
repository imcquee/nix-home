vim.pack.add({
  { src = "https://github.com/folke/snacks.nvim.git" }
})

require("snacks").setup({
  picker = { enabled = true },
  indent = { enabled = true }
})
