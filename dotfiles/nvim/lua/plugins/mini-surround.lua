vim.pack.add({
  { src = "https://github.com/nvim-mini/mini.surround.git" }
})

require("mini.surround").setup({
  mappings = {
    add = "gsa",
  },
})
