return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")

      require("telescope").setup({
        defaults = {
          file_ignore_patterns = { "node_modules", ".git/", "%.lock" },
          layout_config = {
            horizontal = {
              preview_width = 0.55,
            },
          },
          mappings = {
            i = {
              ["<C-u>"] = false,
              ["<C-d>"] = false,
            },
          },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
        },
      })

      vim.keymap.set("n", "<leader>to", builtin.find_files, { desc = "Find Files" })
      vim.keymap.set("n", "<leader>tb", builtin.buffers, { desc = "Open Buffers" })
      vim.keymap.set("n", "<leader>tg", builtin.live_grep, { desc = "Live Grep" })
      vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Go to Definition (Telescope)" })
    end,
  },
}
