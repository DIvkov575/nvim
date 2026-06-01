return {
  {
    "hkupty/iron.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local iron = require("iron.core")
      local view = require("iron.view")
      local common = require("iron.fts.common")

      iron.setup({
        config = {
          scratch_repl = true,
          repl_definition = {
            sh = { command = { "zsh" } },
            python = {
              command = { "python3" },
              format = common.bracketed_paste_python,
              block_dividers = { "# %%", "#%%" },
              env = { PYTHON_BASIC_REPL = "1" },
            },
          },
          repl_filetype = function(_, ft)
            return ft
          end,
          dap_integration = true,
          repl_open_cmd = view.bottom(40),
        },
        keymaps = {
          toggle_repl = "<space>rr",
          restart_repl = "<space>rR",
          send_file = "<space>sf",
          send_line = "<space>sl",
          send_code_block = "<space>sb",
          send_code_block_and_move = "<space>sn",
          interrupt = "<space>s<space>",
          exit = "<space>sq",
          clear = "<space>clc",
        },
        highlight = { italic = true },
        ignore_blank_lines = true,
      })

      vim.keymap.set("n", "<space>rf", "<cmd>IronFocus<cr>")
      vim.keymap.set("n", "<space>rh", "<cmd>IronHide<cr>")
    end,
  },
}
