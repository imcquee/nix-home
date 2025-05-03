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
        prismals = {},
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
        typescript = { "prettierd", "prettier", stop_after_first = true },
        graphql = { "prettierd", "prettier", stop_after_first = true },
        python = { "black" },
        prisma = { "prisma" },
      },
      formatters = {
        prisma = {
          command = "bunx",
          args = { "prisma", "format", "--schema", "$FILENAME" },
          stdin = false,
        },
      },
    },
  },
}
