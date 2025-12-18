vim.pack.add({
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("*") }
})

require("blink.cmp").setup({
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
    per_filetype = {
      sql = { 'snippets', 'dadbod', 'buffer' },
    },
    -- add vim-dadbod-completion to your completion providers
    providers = {
      dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
    },
  },
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
