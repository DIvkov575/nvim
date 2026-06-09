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
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "lua_ls", "clangd", "jdtls", "kotlin_language_server", "rust_analyzer" },
        automatic_installation = true,
      })

      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "kotlin",
        once = true,
        callback = function(ev)
          local root = vim.fs.root(ev.buf, { "build.gradle.kts", "settings.gradle.kts" })
          if not root then return end
          local bp = root .. "/.gradle/brazil-path-location"
          if vim.uv.fs_stat(bp) then return end
          local ws = vim.fs.root(root, { "packageInfo", "release-info" })
          if not ws then return end
          vim.notify("KLS: package not built — run brazil-build release in " .. vim.fs.basename(root), vim.log.levels.WARN)
        end,
      })

      vim.lsp.config("kotlin_language_server", {
        root_markers = { "gradlew", "settings.gradle.kts", "settings.gradle", "build.gradle.kts" },
        handlers = {
          ["workspace/configuration"] = function(_, params, ctx)
            local client = vim.lsp.get_client_by_id(ctx.client_id)
            local settings = client and client.config.settings or {}
            local items = params.items or {}
            if #items == 0 then
              return vim.NIL
            end
            local item = items[1]
            if item.section then
              local keys = vim.split(item.section, ".", { plain = true })
              return vim.tbl_get(settings, unpack(keys)) or vim.NIL
            end
            return settings
          end,
          ["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
            result.diagnostics = vim.tbl_filter(function(d)
              local msg = d.message or ""
              if msg:find("incompatible version of Kotlin") then return false end
              if msg:find("actual metadata version") then return false end
              return true
            end, result.diagnostics)
            vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
          end,
        },
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
  { "neovim/nvim-lspconfig", commit = "229b79051b380377664edc4cbd534930154921a1" },
}
