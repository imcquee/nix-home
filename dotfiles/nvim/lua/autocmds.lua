-- Inlay hints and Copilot suggestions
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end
    if client and client.name == "copilot" then
      vim.lsp.inline_completion.enable(true)
    end
    if client and client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
      vim.keymap.set("i", "<tab>", function()
        local completion = vim.lsp.inline_completion.get()
        if completion then
          vim.lsp.inline_completion.select()
        else
          return "<tab>"
        end
      end, { buffer = args.buf, expr = true, desc = "Accept Copilot Suggestion" })
    end
  end,
})

-- Eslint auto fix on save
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
