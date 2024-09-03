--[[ local home = os.getenv("HOME")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.expand("~/Documents/javaprojects/") .. project_name
local java_path = vim.fn.systemlist("asdf which java")[1]

local status, jdtls = pcall(require, "jdtls")
if not status then
  return
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities

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
    "-jar",
    vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
    --    vim.fn.expand(
    --     "~/.local/share/nvim/mason/share/jdtls/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar"
    --  ),
    "-configuration",
    vim.fn.expand("~/.local/share/nvim/mason/packages/jdtls/config_linux"),
    "-data",
    workspace_dir,
  },
  root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
  settings = {
    java = {
      signatureHelp = { enabled = true },
      extendedClientCapabilities = extendedClientCapabilities,
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

require("jdtls").start_or_attach(config)
 ]]