return {
  { "williamboman/mason.nvim", config = true },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local mason_lspconfig = require("mason-lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(_, bufnr)
        local buf_map = function(mode, lhs, rhs, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, lhs, rhs, opts)
        end

        -- Add buffer-local LSP mappings here when you want them.
        -- buf_map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
        -- buf_map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
        -- buf_map("n", "gr", vim.lsp.buf.references, { desc = "List References" })
        -- buf_map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
        -- buf_map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
        -- buf_map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
      end

      mason_lspconfig.setup({
        ensure_installed = { "pyright", "lua_ls", "clangd" },
        automatic_installation = true,
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({
              on_attach = on_attach,
              capabilities = capabilities,
            })
          end,
        },
      })
    end,
  },
  { "neovim/nvim-lspconfig" },
}
