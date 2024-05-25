local map = vim.keymap.set

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "General clear highlights" })

map("n", "<leader>ln", "<cmd>set nu!<CR>", { desc = "Toggle line number" })
map("n", "<leader>lrn", "<cmd>set rnu!<CR>", { desc = "Toggle relative number" })

-- Navigation while in insert mode
map("i", "<C-b>", "<ESC>^i", { desc = "Move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "Move end of line" })
map("i", "<C-h>", "<Left>", { desc = "Move left" })
map("i", "<C-l>", "<Right>", { desc = "Move right" })
map("i", "<C-j>", "<Down>", { desc = "Move down" })
map("i", "<C-k>", "<Up>", { desc = "Move up" })

-- File mappings
map("n", "<C-s>", "<cmd>w<CR>", { desc = "File save" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "File copy whole" })

-- Move lines of text
map("v", "J", "<cmd>m '>+1<CR>gv=gv", { desc = "Move lines down" })
map("v", "K", "<cmd>m '<-2<CR>gv=gv", { desc = "Move lines up" })

-- Copy and paste clipboard
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to clipboard" })
map("n", "<leader>Y", '"+Y', { desc = "Copy to clipboard" })
map({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete to void register" })

-- Buffer navigation
map("n", "<leader>[", ":bp!<CR>", { desc = "Previous buffer" })
map("n", "<leader>]", ":bn!<CR>", { desc = "Next buffer" })

-- Window splitting
map("n", "<leader>ss", ":split<Return><C-w>w", { desc = "[Window] Horisontal Split" })
map("n", "<leader>sv", ":vsplit<Return><C-w>w", { desc = "[Window] Vertical Split" })
map("n", "<leader>q", "<C-w>q", { desc = "[Window] Quit" })

-- Window navigations
map("n", "<C-h>", "<C-w>h", { desc = "[Window] Switch left" })
map("n", "<C-l>", "<C-w>l", { desc = "[Window] Switch right" })
map("n", "<C-j>", "<C-w>j", { desc = "[Window] Switch down" })
map("n", "<C-k>", "<C-w>k", { desc = "[Window] Switch up" })
