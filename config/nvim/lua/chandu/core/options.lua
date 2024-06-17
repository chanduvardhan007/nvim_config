vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- Tabs & Indentations
opt.tabstop = 2 -- 2 spaces for tabs
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tabs to spaces
opt.autoindent = true -- copy indent from current line when starting a new one

opt.wrap = false

-- Search Settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed casing in search, assumes you want it case-sensitive

opt.cursorline = true

-- TermGUI
opt.termguicolors = true
opt.background = "dark" -- make background dark for both colorschemes (dark or light)
opt.signcolumn = "yes" -- show sign column so text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as deafult register

-- split windows
opt.splitright = true -- split vertical windows to right
opt.splitbelow = true -- split horizontal windows to bottom

