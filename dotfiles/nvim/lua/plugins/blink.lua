vim.pack.add({
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("*") }
})

require("blink.cmp").setup({
  keymap = {
    ['<CR>'] = { 'select_and_accept', 'fallback' },
    ["<Tab>"] = {
      "snippet_forward",
      function() -- sidekick next edit suggestion
        return require("sidekick").nes_jump_or_apply()
      end,
      function() -- if you are using Neovim's native inline completions
        return vim.lsp.inline_completion.get()
      end,
      "fallback",
    },
  }
})
