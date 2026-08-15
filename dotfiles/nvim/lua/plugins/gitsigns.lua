vim.pack.add({
  { src = "https://github.com/lewis6991/gitsigns.nvim.git" }
})

require("gitsigns").setup({
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text_pos = "eol",
    delay = 300,
  },
  current_line_blame_formatter = "<abbrev_sha> <author>, <author_time:%R> - <summary>",
  on_attach = function(bufnr)
    local gs = require("gitsigns")
    local set = vim.keymap.set

    set("n", "<leader>hb", function() gs.blame_line({ full = true }) end,
      { buffer = bufnr, desc = "Blame line (full)" })

    set("n", "<leader>ho", function()
      local cache = require("gitsigns.cache").cache
      local bcache = cache[bufnr]
      if not bcache or not bcache.blame then return end
      local lnum = vim.api.nvim_win_get_cursor(0)[1]
      local entry = bcache.blame.entries[lnum]
      if entry and entry.commit and entry.commit.sha and entry.commit.sha ~= string.rep("0", 40) then
        Snacks.gitbrowse({ what = "commit", commit = entry.commit.sha })
      end
    end, { buffer = bufnr, desc = "Open commit in browser" })
  end,
})
