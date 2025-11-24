vim.pack.add({
  { src = "https://github.com/folke/snacks.nvim.git" }
})

require("snacks").setup({
  picker = {
    enabled = true,
    win = {
      input = {
        keys = {
          ["<c-y>"] = { "toggle_live", mode = { "i", "n" } },
          ["<C-o>"] = { "history_back", mode = { "i", "n" } },
          ["<C-i>"] = { "history_forward", mode = { "i", "n" } },
        }
      }
    }
  },
  scratch = {
    enabled = true,
  },
  indent = { enabled = true },
  image = { enabled = true },
  scroll = { enabled = true },
})
