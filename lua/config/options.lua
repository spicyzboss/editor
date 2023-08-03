local opt = vim.opt
local glob = vim.g

glob.python3_host_prog = "/usr/local/bin/python3"
glob.ruby_host_prog = "/usr/local/lib/ruby/gems/3.1.0/bin/neovim-ruby-host"

glob.loaded_netrw = 1
glob.loaded_netrwPlugin = 1
glob.loaded_zipPlugin = 1
glob.loaded_zip = 1

glob.netrw_keepdir = 0
glob.netrw_winsize = 15
glob.netrw_banner = 0

-- control
opt.virtualedit = "block"
opt.completeopt = "menu,menuone,noselect"

-- search
opt.ignorecase = true
opt.smartcase = true
opt.wildignore = { ".git/*", "node_modules/*", "target/*", "dist/*" }
opt.wildignorecase = true

-- substitution
opt.inccommand = "split"

-- perf
opt.ttyfast = true
opt.lazyredraw = true
opt.updatetime = 100

-- ui
opt.cursorline = true
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.wrap = false
opt.ruler = false
opt.showmode = false
opt.signcolumn = "yes"
opt.pumheight = 8
opt.scrolloff = 8
opt.splitbelow = true
opt.splitright = true

-- clipboard
opt.clipboard = "unnamedplus"

-- tabs
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true

-- backup
opt.backup = false
opt.writebackup = false
opt.swapfile = false
