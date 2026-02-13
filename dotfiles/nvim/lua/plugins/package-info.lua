vim.pack.add({
  { src = "https://github.com/vuki656/package-info.nvim" }
})
vim.pack.add({
  { src = "https://github.com/MunifTanjim/nui.nvim" }
})

require("package-info").setup({
  package_manager = "bun"
})
