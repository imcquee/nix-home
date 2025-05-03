return {
  -- LSP
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nil_ls = {
          mason = false,
        },
        nixd = {
          mason = false,
        },
        ts_ls = {
          mason = false,
        },
      },
    },
  },
  -- Format
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        elixir = { "mix" },
        nix = { "nixfmt" },
        gleam = { "gleam" },
        typescript = { "prettier" },
        python = { "black" },
      },
    },
  },
}
