return {
  {
    "nvim-neorg/neorg",
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "~/neorg",
              },
              default_workspace = "notes",
            },
          },
        },
      })
      vim.keymap.set("n", "<leader>nn", "<cmd>Neorg workspace notes<CR>")
    end,
    run = ":Neorg sync-parsers",
    requires = "nvim-lua/plenary.nvim",
  },
}
