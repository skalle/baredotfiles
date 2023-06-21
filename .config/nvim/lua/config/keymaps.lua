-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.api.nvim_set_keymap
local Util = require("lazyvim.util")
local lazyterm = function()
  Util.float_term(nil, { cwd = Util.get_root() })
end

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

keymap("n", "<A-h>", "<C-w>h", { desc = "Go to left window" })
keymap("n", "<A-j>", "<C-w>j", { desc = "Go to lower window" })
keymap("n", "<A-k>", "<C-w>k", { desc = "Go to upper window" })
keymap("n", "<A-l>", "<C-w>l", { desc = "Go to right window" })

-- The all-mighty figutigive Git command.
keymap("n", "<space>g", "<cmd>Git<cr>", { desc = "Fugitive Git" })

map("n", "<space>T", function()
  Util.float_term()
end, { desc = "Terminal (cwd)" })

map("n", "<space>t", lazyterm, { desc = "Terminal (root dir)" })

-- Some cool git stuff.
keymap("n", "<leader>gp", "<cmd>Git push<cr>", { desc = "Git push the current branch" })
