vim.pack.add({
  { src = "https://github.com/NicolasGB/jj.nvim.git" }
})

require("jj").setup({
  picker = {
    snacks = {}
  }
})
