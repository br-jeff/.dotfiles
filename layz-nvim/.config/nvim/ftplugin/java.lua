local home = os.getenv("HOME")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/workspace/" .. project_name
local java_path = vim.fn.systemlist("asdf which java")[1]
local lombok_jar = vim.fn.expand("~/.local/share/nvim/mason/share/jdtls/lombok.jar")
local jdtls = require("jdtls")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local client_capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = cmp_nvim_lsp.default_capabilities(client_capabilities)

local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local config = {
  capabilities = capabilities,
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
  on_attach = function(client, bufnr)
    -- https://github.com/mfussenegger/dotfiles/blob/833d634251ebf3bf7e9899ed06ac710735d392da/vim/.config/nvim/ftplugin/java.lua#L88-L94
    local opts = { silent = true, buffer = bufnr }
    vim.keymap.set("n", "<leader>lo", jdtls.organize_imports, { desc = "Organize imports", buffer = bufnr })
    -- Should 'd' be reserved for debug?
    vim.keymap.set("n", "<leader>df", jdtls.test_class, opts)
    vim.keymap.set("n", "<leader>dn", jdtls.test_nearest_method, opts)
    vim.keymap.set("n", "<leader>rv", jdtls.extract_variable_all, { desc = "Extract variable", buffer = bufnr })
    vim.keymap.set(
      "v",
      "<leader>rm",
      [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
      { desc = "Extract method", buffer = bufnr }
    )
    vim.keymap.set("n", "<leader>rc", jdtls.extract_constant, { desc = "Extract constant", buffer = bufnr })
  end,
  --    extendedClientCapabilities = capabilities,
  -- root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
  settings = {
    java = {
      extendedClientCapabilities = require("jdtls").extendedClientCapabilities,
      signatureHelp = { enabled = true },
      import = { enabled = true },
      rename = { enabled = true },
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

local mappings = {
  J = {
    name = "Java",
    o = { "<Cmd>lua require'jdtls'.organize_imports()<CR>", "Organize Imports" },
    v = { "<Cmd>lua require('jdtls').extract_variable()<CR>", "Extract Variable" },
    c = { "<Cmd>lua require('jdtls').extract_constant()<CR>", "Extract Constant" },
    t = { "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", "Test Method" },
    T = { "<Cmd>lua require'jdtls'.test_class()<CR>", "Test Class" },
    u = { "<Cmd>JdtUpdateConfig<CR>", "Update Config" },
  },
}

local vmappings = {
  J = {
    name = "Java",
    v = { "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", "Extract Variable" },
    c = { "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", "Extract Constant" },
    m = { "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", "Extract Method" },
  },
}

which_key.register(mappings, opts)
which_key.register(vmappings, vopts)

jdtls.start_or_attach(config)
