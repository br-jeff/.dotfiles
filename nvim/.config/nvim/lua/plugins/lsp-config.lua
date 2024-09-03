return {
  {
    "nvim-java/nvim-java",
    dependencies = {
      "nvim-java/lua-async-await",
      "nvim-java/nvim-java-core",
      "nvim-java/nvim-java-test",
      "nvim-java/nvim-java-dap",
      "MunifTanjim/nui.nvim",
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
      {
        "williamboman/mason.nvim",
        opts = {
          registries = {
            "github:nvim-java/mason-registry",
            "github:mason-org/mason-registry",
          },
        },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({})
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "gradle_ls",
          "tsserver",
          "html",
          "cssls",
          "jdtls",
          "prismals",
          "gopls",
        },
        automatic_installation = true,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      lspconfig.clangd.setup({
        capabilities = capabilities,
      })

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })

      lspconfig.tsserver.setup({
        on_attach = function(client, bufnr)
          local bufopts = { noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
          vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, bufopts)
          vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, bufopts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
          vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
          vim.keymap.set("n", "<space>rf", vim.diagnostic.open_float, bufopts)
        end,
        capabilities = capabilities,
        settings = { documentFormatting = true },
      })

      lspconfig.gopls.setup({
        on_attach = function(client, bufnr)
          local bufopts = { noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
          vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, bufopts)
          vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, bufopts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
          vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
          vim.keymap.set("n", "<space>rf", vim.diagnostic.open_float, bufopts)
        end,
        capabilities = capabilities,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
          },
        },
      })

     --local root_files = vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })
     --local root_dir = root_files and vim.fs.dirname(root_files[1]) or vim.fn.getcwd()

      local home = os.getenv("HOME")
      local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
      local workspace_dir = home .. "/workspace/" .. project_name
      local java_path = vim.fn.systemlist("asdf which java")[1]
      local lombok_jar = vim.fn.expand("~/.local/share/nvim/mason/share/jdtls/lombok.jar")

      local config = {
        cmd = {
          java_path,
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.protocol=true",
          "-Dlog.level=ALL",
          "-Xmx1g",
          "--add-modules=ALL-SYSTEM",
          "--add-opens",
          "java.base/java.util=ALL-UNNAMED",
          "--add-opens",
          "java.base/java.lang=ALL-UNNAMED",
          "-javaagent:" .. lombok_jar,
          "-jar",
          -- vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
          vim.fn.expand(
            "~/.local/share/nvim/mason/share/jdtls/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar"
          ),
          "-configuration",
          vim.fn.expand("~/.local/share/nvim/mason/packages/jdtls/config_linux"),
          "-data",
          workspace_dir,
        },

        -- root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
        settings = {
          java = {
            signatureHelp = { enabled = true },
            extendedClientCapabilities = capabilities,
            maven = {
              downloadSources = true,
            },
            referencesCodeLens = {
              enabled = true,
            },
            references = {
              includeDecompiledSources = true,
            },
            inlayHints = {
              parameterNames = {
                enabled = "all", -- literals, all, none
              },
            },
            format = {
              enabled = false,
            },
          },
          init_options = {
            bundles = {},
          },
        },
      }

      lspconfig.jdtls.setup(config)
    end,
  },
}
