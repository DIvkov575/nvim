return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    keys = {
      { "<leader>a", nil, desc = "AI/Claude" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
    opts = {
      terminal = {
        split_side = "right",
        split_width_percentage = 0.40,
        provider = "snacks",
        snacks_win_opts = {
          position = "float",
          width = 0.85,
          height = 0.85,
          border = "rounded",
        },
      },
    },
  },
}
