vim.pack.add({
  { src = "https://github.com/mikavilpas/yazi.nvim.git" }
})

vim.g.loaded_netrwPlugin = 1

require("yazi").setup({
  open_for_directories = true,
})
-- Dependencies
-- Plenary
