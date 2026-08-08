local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.termguicolors = true

-- Mouse
opt.mouse = "a"

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Editing
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2

-- Windows
opt.splitbelow = true
opt.splitright = true

-- Performance / responsiveness
opt.updatetime = 200
opt.timeoutlen = 300

-- Persistent undo
opt.undofile = true

-- Don't create swap files
opt.swapfile = false

-- Display
opt.wrap = false
opt.scrolloff = 4

-- System clipboard
opt.clipboard = "unnamedplus"
