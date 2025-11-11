vim.pack.add({
  { src = "https://github.com/nvim-neotest/neotest.git" }
})
vim.pack.add({
  { src = "https://github.com/arthur944/neotest-bun.git" }
})
vim.pack.add({
  { src = "https://github.com/nvim-neotest/nvim-nio.git" }
})
vim.pack.add({
  { src = "https://github.com/kikito/inspect.lua.git" }
})

-- I don't love this but it works
local inspect_path = vim.fn.stdpath("data") .. "/site/pack/core/opt/inspect.lua/inspect.lua"
if vim.fn.filereadable(inspect_path) == 1 then
  package.preload['inspect'] = function()
    return dofile(inspect_path)
  end
end

require("neotest").setup({
  adapters = {
    require("neotest-bun")
  }
})
