-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.conform")
require("lspconfig").nixd.setup({})
