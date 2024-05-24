local map = vim.keymap.set

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "General clear highlights" })

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
map("n", "<leader>sq", "<C-w>q", { desc = "[Window] Quit" })

-- Window navigations
--map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
--map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
--map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
--map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })
