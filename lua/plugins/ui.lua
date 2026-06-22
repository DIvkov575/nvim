return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night",
      })
      vim.cmd.colorscheme("tokyonight")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = { "java", "python", "c", "cpp", "rust", "lua", "javascript", "typescript" },
      })
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = { theme = "tokyonight" },
      })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = function()
      require("gitsigns").setup({
        on_attach = function(bufnr)
          local gs = require("gitsigns")
          local map = function(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          map("n", "]h", gs.next_hunk, { desc = "Next hunk" })
          map("n", "[h", gs.prev_hunk, { desc = "Previous hunk" })
          map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
          map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
          map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
          map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, { desc = "Blame line" })
          map("n", "<leader>hd", gs.diffthis, { desc = "Diff this" })
        end,
      })
    end,
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          diagnostics = "nvim_lsp",
          offsets = { { filetype = "NvimTree", text = "Explorer", padding = 1 } },
          show_close_icon = false,
          show_buffer_close_icons = false,
          custom_filter = function(buf)
            local bt = vim.bo[buf].buftype
            return bt == "" or bt == "acwrite"
          end,
        },
      })

      local function cycle(direction)
        local bufs = require("bufferline").get_elements().elements
        if #bufs == 0 then return end
        local current = vim.api.nvim_get_current_buf()
        local idx
        for i, b in ipairs(bufs) do
          if b.id == current then idx = i; break end
        end
        if not idx then
          vim.api.nvim_set_current_buf(bufs[1].id)
          return
        end
        local target = ((idx - 1 + direction) % #bufs) + 1
        vim.api.nvim_set_current_buf(bufs[target].id)
      end

      vim.keymap.set("n", "]b", function() cycle(1) end, { desc = "Next buffer" })
      vim.keymap.set("n", "[b", function() cycle(-1) end, { desc = "Prev buffer" })
      vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup({
        preset = "modern",
      })
      wk.add({
        { "<leader>t", group = "Telescope/Terminal" },
        { "<leader>d", group = "Debug" },
        { "<leader>h", group = "Git Hunk" },
      })
    end,
  },
}
