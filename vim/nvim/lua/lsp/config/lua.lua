-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local common = require 'lsp.common-config'

local opts = {
  settings = {
    Lua = {
      runtime = {
         -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path,
        path = runtime_path,
      },

      diagnostics = {
        -- Get the language server to recognize the 'vim' global
        globals = { 'vim' },
      },

      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = true,
        --checkThirdParty = false,
      },

      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },

  flags = common.flags,

  on_attach = function(client, bufnr)
    -- 禁用格式化功能， 交给专门的插件处理
    common.disableFormat(client)
    common.keyAttach(bufnr)
    -- 保存时自动格式化
    vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')
  end 
}

-- 查看目录信息
return {
  on_setup = function(server)
    server:setup(opts)
  end,
}  
