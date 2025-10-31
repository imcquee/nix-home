-- Options
vim.g.mapleader = " "
vim.g.localleader = " "
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.o.number = true
vim.o.undofile = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.smartindent = true
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.scrolloff = 999
vim.o.completeopt = "menuone,noinsert,noselect"
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.confirm = true
vim.o.list = true
vim.o.autocomplete = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldmethod = 'expr'
vim.o.foldtext = ""
vim.o.foldlevelstart = 1
vim.o.foldnestmax = 3
