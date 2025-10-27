-- vim.lsp.config("tailwindcss", {
--   filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" }
--   -- settings = {
--   --   tailwindCSS = {
--   --     experimental = {
--   --       classRegex = {
--   --         { "cn\\(([^)]*)\\)", "\"([^\"]*)\"" },
--   --       },
--   --     },
--   --   },
--   -- },
-- })
-- --
local base_on_attach = vim.lsp.config.eslint.on_attach
vim.lsp.config("eslint", {
  on_attach = function(client, bufnr)
    if not base_on_attach then return end

    base_on_attach(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "LspEslintFixAll",
    })
  end,
})

vim.lsp.enable("gleam")
vim.lsp.enable("nil")
vim.lsp.enable("nixd")
vim.lsp.enable("codebook")
vim.lsp.enable("ts_ls")
vim.lsp.enable("tailwindcss")
vim.lsp.enable("eslint")
vim.lsp.enable("lua_ls")
vim.lsp.enable("prismals")
