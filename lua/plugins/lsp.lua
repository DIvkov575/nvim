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

      local on_attach = function(_, bufnr) end

      mason_lspconfig.setup({
        ensure_installed = { "pyright", "lua_ls", "clangd", "jdtls", "kotlin_language_server", "rust_analyzer" },
        automatic_installation = true,
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({
              on_attach = on_attach,
              capabilities = capabilities,
            })
          end,
          ["kotlin_language_server"] = function()
            local kt_caps = vim.deepcopy(capabilities)
            kt_caps.workspace = kt_caps.workspace or {}
            kt_caps.workspace.configuration = false

            require("lspconfig").kotlin_language_server.setup({
              on_attach = on_attach,
              capabilities = kt_caps,
              init_options = {
                storagePath = vim.fn.stdpath("cache") .. "/kotlin-language-server",
              },
              settings = {
                kotlin = {
                  compiler = {
                    jvm = {
                      target = "21",
                    },
                  },
                },
              },
            })
          end,
        },
      })
    end,
  },
  { "neovim/nvim-lspconfig" },
}
