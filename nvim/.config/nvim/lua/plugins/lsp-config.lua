return {
  { "mfussenegger/nvim-jdtls" },
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
      -- require("java").setup()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      lspconfig.clangd.setup({
        capabilities = capabilities,
      })

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })

      lspconfig.tsserver.setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          local bufopts = { noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
          vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, bufopts)
          vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, bufopts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
          vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
          vim.keymap.set("n", "<space>rf", vim.diagnostic.open_float, bufopts)
        end,
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

      --lspconfig.jdtls()
      --local root_files = vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })
      --
      --local root_dir = root_files and vim.fs.dirname(root_files[1]) or vim.fn.getcwd()
    end,
  },
}
