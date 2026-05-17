vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter.git", version = "main" }
})

require('nvim-treesitter').install({
  "tsx", "prisma", "html", "javascript", "typescript",
  "gleam", "graphql", "go", "djot", "nix",
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    "typescriptreact", "typescript", "javascript",
    "html", "prisma", "gleam", "graphql", "go", "djot", "nix",
  },
  callback = function()
    vim.treesitter.start()
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo.foldmethod = 'expr'
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
