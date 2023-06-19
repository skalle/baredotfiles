return {
  {
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      require("oil").setup()
      vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
    end,
  },
}
