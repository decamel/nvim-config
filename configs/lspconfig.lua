local base = require("plugins.configs.lspconfig")
local on_attach = base.on_attach
local capabilities = base.capabilities
local util = require "lspconfig/util"

local lspconfig = require("lspconfig")

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
  }
  vim.lsp.buf.execute_command(params)
end

-- ------------------------------------ C++ ---------------------------------

lspconfig.clangd.setup(
  {
    on_attach = function(client, bufnr)
      client.server_capabilities.signatureHelpProvider = false
      on_attach(client, bufnr)
    end,
    capabilities = vim.tbl_deep_extend("force", capabilities, { offsetEncoding = "utf-8" }),
  }
)

lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  },
  on_init = function(client)
    local uv = vim.uv or vim.loop
    local path = client.workspace_folders[1].name

    if uv.fs_stat(path .. '/.luarc.json')
        or uv.fs_stat(path .. '/.luarc.jsonc')
    then
      return
    end
    local lua_opts = lsp_zero.nvim_lua_ls()

    client.config.settings.lua = vim.tbl_deep_extend(
      'force',
      client.config.settings.lua,
      lua_opts.settings.Lua)
  end,
})


lspconfig.cmake.setup(
  {
    on_attach = on_attach,
    capabilities = capabilities,
  }
)

-- ----------------------------------- Python -----------------------------------

lspconfig.ruff_lsp.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "python" }
})

lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "python" },
  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        ignore = { '*' }
      }
    },
  },
})


-- --------------------------------- (Type/Java)script ---------------------------------

lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    preferences = {
      disableSuggestions = true,
    }
  },
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    }
  }
}

lspconfig.eslint.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- ----------------------------------- Golang -----------------------------------

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      }
    }
  }
}
