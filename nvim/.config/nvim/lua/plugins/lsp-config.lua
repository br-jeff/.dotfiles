return {
  {
    require("java").setup(),
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        -- Configurações adicionais para Mason
      })
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
          -- "jdtls",
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

      -- Configuração para clangd (C/C++)
      lspconfig.clangd.setup({
        capabilities = capabilities,
      })

      -- Configuração para lua_ls (Lua)
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })

      -- Configuração para tsserver (TypeScript/JavaScript)
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
      lspconfig.jdtls.setup({})

      -- Adicione outras configurações de servidores de linguagem aqui
    end,
  },
}
