local map = vim.keymap.set

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

map("n", "<C-s>", "<cmd>w<CR>", { desc = "file save" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "file copy whole" })

map("v", "J", "<cmd>m '>+1<CR>gv=gv", { desc = "move lines down" })
map("v", "K", "<cmd>m '<-2<CR>gv=gv", { desc = "move lines up" })

map({ "n", "v" }, "<leader>y", '"+y', { desc = "copy to clipboard" })
map("n", "<leader>Y", '"+Y', { desc = "copy to clipboard" })
map({ "n", "v" }, "<leader>d", '"_d', { desc = "delete to void register" })

--map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
--map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
--map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
--map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })
