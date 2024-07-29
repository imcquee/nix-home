require("conform").setup({
  formatters_by_ft = {
    elixir = { "mix" },
    nix = { "nixfmt" },
    gleam = { "gleam" },
    typescript = { "prettier" },
    python = { "black" },
  },
})
