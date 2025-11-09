vim.pack.add({
  { src = "https://github.com/rebelot/kanagawa.nvim.git", name = "kanagawa" }
})

require("kanagawa").setup({
  transparent = true,
})

vim.cmd.colorscheme "kanagawa"
