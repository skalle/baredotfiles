-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.api.nvim_set_keymap

keymap("n", "<A-h>", "<C-w>h", { desc = "Go to left window" })
keymap("n", "<A-j>", "<C-w>j", { desc = "Go to lower window" })
keymap("n", "<A-k>", "<C-w>k", { desc = "Go to upper window" })
keymap("n", "<A-l>", "<C-w>l", { desc = "Go to right window" })

keymap("n", "<A-l>", "<C-w>l", { desc = "Go to right window" })

-- Some cool git stuff.
keymap("n", "<leader>gp", "<cmd>Git push<cr>", { desc = "Git push the current branch" })
keymap("n", "<leader>gc", "<cmd>Git<cr>", { desc = "Git command" })
