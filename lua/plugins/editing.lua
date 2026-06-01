return {
  {
    "stevearc/oil.nvim",
    keys = {
      {
        "<leader>1",
        function()
          if vim.bo.filetype == "oil" then
            vim.cmd("bd")
          else
            require("oil").open()
          end
        end,
        desc = "Toggle Oil",
      },
    },
    config = function()
      require("oil").setup({
        view_options = {
          show_hidden = true,
        },
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        disable_filetype = { "TelescopePrompt", "NvimTree", "mason" },
      })
    end,
  },
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
      local mc = require("multicursor-nvim")
      local set = vim.keymap.set

      mc.setup()

      set({ "n", "x" }, "<M-up>", function()
        mc.lineAddCursor(-1)
      end)
      set({ "n", "x" }, "<M-down>", function()
        mc.lineAddCursor(1)
      end)
      set({ "n", "x" }, "<leader><M-up>", function()
        mc.lineSkipCursor(-1)
      end)
      set({ "n", "x" }, "<leader><M-down>", function()
        mc.lineSkipCursor(1)
      end)

      set({ "n", "x" }, "<leader>n", function()
        mc.matchAddCursor(1)
      end)
      set({ "n", "x" }, "<leader>s", function()
        mc.matchSkipCursor(1)
      end)
      set({ "n", "x" }, "<leader>N", function()
        mc.matchAddCursor(-1)
      end)
      set({ "n", "x" }, "<leader>S", function()
        mc.matchSkipCursor(-1)
      end)

      set({ "n", "x" }, "<c-q>", mc.toggleCursor)

      mc.addKeymapLayer(function(layer_set)
        layer_set({ "n", "x" }, "<left>", mc.prevCursor)
        layer_set({ "n", "x" }, "<right>", mc.nextCursor)
        layer_set({ "n", "x" }, "<leader>x", mc.deleteCursor)

        layer_set("n", "<esc>", function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          else
            mc.clearCursors()
          end
        end)
      end)
    end,
  },
}
