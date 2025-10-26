vim.lsp.config("gleam", {
  cmd = { "gleam", "lsp" },
  root_markers = { "gleam.toml" },
})

vim.lsp.config("typescript", {
  cmd = { "bun", "typescript-language-server", "--stdio" },
  filetypes = { "typescript", "javascript" },
  root_markers = { ".git", "tsconfig.json", "package.json" },
})

vim.lsp.enable("gleam", "typescript")
