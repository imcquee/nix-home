-- Filetype detection
vim.filetype.add({
  extension = {
    djot = "djot",
    apns = "apns",
  },
})

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

-- Forward attention codes from terminal buffers (e.g. Claude Code in sidekick) to
-- the outer terminal. Neovim swallows them otherwise, so Zellij's inbox only sees
-- the pane go quiet. OSC 9 / 99 / 777 are notifications ("needs you"); OSC 9;4 is
-- progress ("working" / done).
local osc_forward = vim.api.nvim_create_augroup("osc_forward", { clear = true })
local progress_bufs = {}

vim.api.nvim_create_autocmd("TermRequest", {
  group = osc_forward,
  callback = function(ev)
    local seq = ev.data.sequence
    if seq:match("^\27%]9;") or seq:match("^\27%]99;") or seq:match("^\27%]777;notify;") then
      local state = seq:match("^\27%]9;4;(%d)")
      if state then progress_bufs[ev.buf] = state ~= "0" or nil end
      vim.api.nvim_ui_send(seq .. (ev.data.terminator or "\a"))
    end
  end,
})

-- A terminal that dies mid-task never sends "done", so clear its progress
vim.api.nvim_create_autocmd({ "TermClose", "BufWipeout" }, {
  group = osc_forward,
  callback = function(ev)
    if progress_bufs[ev.buf] then
      progress_bufs[ev.buf] = nil
      vim.api.nvim_ui_send("\27]9;4;0;\a")
    end
  end,
})
