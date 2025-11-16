vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter.git" }
})
require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
  },
  ensure_installed = { "tsx", "prisma", "html", "javascript", "typescript", "gleam", "graphql", "go", "djot" },
})
