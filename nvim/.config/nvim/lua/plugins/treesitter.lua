return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "HiPhish/nvim-ts-rainbow2" },
  enabled = true,
  config = function()
    require("nvim-treesitter.configs").setup({
      rainbow = {
        enable = true,
        query = "rainbow-parens",
        strategy = require("ts-rainbow").strategy.global,
      },
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "java",
        "go",
        "gomod",
      },
      sync_install = false,
      auto_install = true,
      ignore_install = { "python" },
      indent = { enable = true },
      highlight = { enable = true },
      playground = { enable = false },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["ib"] = "@block.inner",
          },
        },
      },
      modules = {},
    })
  end,
}
