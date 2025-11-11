vim.pack.add({
  { src = "https://github.com/folke/flash.nvim.git" }
})

require("flash").setup({
  jump = {
    autojump = true
  },
  modes = {
    char = {
      jump_labels = true,
    }
  }
})
