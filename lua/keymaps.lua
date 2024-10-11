local map = vim.keymap.set

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "General clear highlights" })

map("n", "<leader>ln", "<cmd>set nu!<CR>", { desc = "Toggle line number" })
map("n", "<leader>lrn", "<cmd>set rnu!<CR>", { desc = "Toggle relative number" })

-- File mappings
map("n", "<C-s>", "<cmd>w<CR>", { desc = "File save" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "File copy whole" })

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Copy and paste clipboard
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to clipboard" })
map("n", "<leader>Y", '"+Y', { desc = "Copy to clipboard" })
map({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete to void register" })

-- Buffer navigation
map("n", "[b", ":bp!<CR>", { desc = "Previous buffer" })
map("n", "]b", ":bn!<CR>", { desc = "Next buffer" })

-- Window splitting
map("n", "<leader>sx", ":split<Return><C-w>w", { desc = "[Window] Horisontal Split" })
map("n", "<leader>sv", ":vsplit<Return><C-w>w", { desc = "[Window] Vertical Split" })
map("n", "<leader>q", "<C-w>q", { desc = "[Window] Quit" })

-- Window navigations
map("n", "<C-h>", "<C-w>h", { desc = "[Window] Switch left" })
map("n", "<C-l>", "<C-w>l", { desc = "[Window] Switch right" })
map("n", "<C-j>", "<C-w>j", { desc = "[Window] Switch down" })
map("n", "<C-k>", "<C-w>k", { desc = "[Window] Switch up" })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Navigation while in insert mode
-- map("i", "<C-b>", "<ESC>^i", { desc = "Move beginning of line" })
-- map("i", "<C-e>", "<End>", { desc = "Move end of line" })
-- map("i", "<C-h>", "<Left>", { desc = "Move left" })
-- map("i", "<C-l>", "<Right>", { desc = "Move right" })
-- map("i", "<C-j>", "<Down>", { desc = "Move down" })
-- map("i", "<C-k>", "<Up>", { desc = "Move up" })
