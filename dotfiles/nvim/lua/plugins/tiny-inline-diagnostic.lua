vim.pack.add({
  { src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim.git" }
})

require("tiny-inline-diagnostic").setup({
  preset = "classic",
})
