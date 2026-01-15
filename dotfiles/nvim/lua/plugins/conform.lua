vim.pack.add({
  { src = "https://github.com/stevearc/conform.nvim.git" }
})
require("conform").setup({
  formatters_by_ft = {
    nix = { "nixfmt" },
    gleam = { "gleam" },
    prisma = { "prisma" },
    rust = { "rustfmt" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
  formatters = {
    prisma = {
      command = "bunx",
      args = { "prisma", "format", "--schema", "$FILENAME" },
      stdin = false,
      exit_codes = { 0 },
      require_cwd = false,
    },
  },
})
