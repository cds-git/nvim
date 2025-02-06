vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- set.relative line numbers for jumping
vim.opt.relativenumber = true
-- Number of current line
vim.opt.number = true
-- Do not allow line wraping
vim.opt.wrap = false

-- Search settings
vim.opt.hlsearch = true
vim.opt.incsearch = true
-- Control searching. Ignore case during search, except if it includes a capital letter
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Create splits vertically by default
vim.opt.diffopt = "vertical"

-- set no swap files
vim.opt.swapfile = false
vim.opt.backup = false

-- And use undodir instead
-- Allow undo-ing even after save file
vim.opt.undodir = vim.fn.stdpath("config") .. "/.undo"
vim.opt.undofile = true

-- Hide 'No write since last change' error on switching buffers Keeps buffer open in the background.
vim.opt.hidden = true

vim.opt.backspace = "indent,eol,start"

-- Indenting
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = true
vim.opt.expandtab = true

-- filenames
vim.opt.fileformat = "unix"
vim.opt.fileformats = "unix,dos"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m"

--vim.opt.colorcolumn = "180"

vim.opt.updatetime = 250
vim.wo.signcolumn = "yes"

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"
