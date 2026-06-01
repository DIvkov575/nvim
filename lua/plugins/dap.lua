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

      local function launch_config(program)
        return {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = program,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        }
      end

      local function prompt_for_program()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end

      local function launch_program(program)
        if program == nil or program == "" then
          return
        end

        dap.run(launch_config(program))
      end

      local function pick_and_launch_program()
        local ok, builtin = pcall(require, "telescope.builtin")
        if not ok then
          launch_program(prompt_for_program())
          return
        end

        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")

        builtin.find_files({
          prompt_title = "Debug executable",
          hidden = true,
          attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
              local selection = action_state.get_selected_entry()
              actions.close(prompt_bufnr)

              if selection ~= nil then
                launch_program(selection.path or selection.filename or selection.value)
              end
            end)

            return true
          end,
        })
      end

      dap.configurations.cpp = {
        launch_config(prompt_for_program),
      }

      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp

      dapui.setup()

      dap.listeners.after.event_initialized["dapui"] = function()
        dapui.open()
      end

      vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP continue" })
      vim.keymap.set("n", "<leader>dr", dap.continue, { desc = "DAP start/continue" })
      vim.keymap.set("n", "<leader>df", pick_and_launch_program, { desc = "DAP pick file and launch" })
      vim.keymap.set("n", "<F8>", dap.step_over, { desc = "DAP step over" })
      vim.keymap.set("n", "<F9>", dap.step_into, { desc = "DAP step into" })
      vim.keymap.set("n", "<F10>", dap.step_out, { desc = "DAP step out" })
      vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "DAP toggle breakpoint" })
      vim.keymap.set("n", "<leader>dui", dapui.toggle, { desc = "DAP UI toggle" })
    end,
  },
}
