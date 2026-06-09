return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")

      local ignore = {
        "node_modules", ".git/", "%.lock",
        "build/", "env/", ".gradle/", "brazil%-pkg%-cache",
        "%.class", "%.jar", "%.so", "%.dylib",
      }

      require("telescope").setup({
        defaults = {
          file_ignore_patterns = ignore,
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
          find_files = { hidden = true },
        },
      })

      vim.keymap.set("n", "<leader>to", builtin.find_files, { desc = "Find Files" })
      vim.keymap.set("n", "<leader>tO", function()
        builtin.find_files({ file_ignore_patterns = {} })
      end, { desc = "Find Files (unfiltered)" })
      vim.keymap.set("n", "<leader>tb", builtin.buffers, { desc = "Open Buffers" })
      vim.keymap.set("n", "<leader>tg", builtin.live_grep, { desc = "Live Grep" })
      vim.keymap.set("n", "<leader>tG", function()
        builtin.live_grep({ additional_args = function() return { "--no-ignore" } end })
      end, { desc = "Live Grep (unfiltered)" })
      vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Go to Definition (Telescope)" })
    end,
  },
}
