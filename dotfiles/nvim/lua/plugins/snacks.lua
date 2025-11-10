vim.pack.add({
  { src = "https://github.com/folke/snacks.nvim.git" }
})

require("snacks").setup({
  picker = {
    enabled = true,
    win = {
      input = {
        keys = {
          ["<c-z>"] = { "toggle_live", mode = { "i", "n" } },
        }
      }
    }
  },
  indent = { enabled = true },
  image = { enabled = true },
})
