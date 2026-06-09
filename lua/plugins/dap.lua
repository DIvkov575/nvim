return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
      "williamboman/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
      require("mason-nvim-dap").setup({
        ensure_installed = { "codelldb" },
        automatic_setup = true,
      })

      local dap = require("dap")
      local dapui = require("dapui")
      local mason_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
      local adapter_path = mason_path .. "adapter/codelldb"

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = adapter_path,
          args = { "--port", "${port}" },
        },
      }

      local function prompt_for_program()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end

      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = prompt_for_program,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp

      dapui.setup()

      dap.listeners.after.event_initialized["dapui"] = function()
        dapui.open()
      end

      vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP continue" })
      vim.keymap.set("n", "<F8>", dap.step_over, { desc = "DAP step over" })
      vim.keymap.set("n", "<F9>", dap.step_into, { desc = "DAP step into" })
      vim.keymap.set("n", "<F10>", dap.step_out, { desc = "DAP step out" })
      vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "DAP UI toggle" })
    end,
  },
}
