return {
  {
    "williamboman/mason.nvim",
    -- lazy = false,
    config = function()
      require("mason").setup({
        "typescript-language-server",
        "eslint-lsp"
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    -- lazy = false,
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "eslint",
          "tsserver",
          "stylua",
          "shellcheck",
          "shfmt",
          "flake8",
        }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      lspconfig.clangd.setup({
        capabilities = capabilities
      })

      lspconfig.lua_ls.setup({capabilities = capabilities})

      lspconfig.tsserve.setup({
        on_attach =  lspconfig.on_attach,
        capabilities = capabilities,
        init_options = {
          preferences = {
            disabpeSuggestions = false,
          }
        }
      })

      lspconfig.java_language_server.setup({
        capabilities = capabilities
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, {})
      vim.keymap.set('n', '<space>rf', vim.diagnostic.open_float)
    end,
  },
}
