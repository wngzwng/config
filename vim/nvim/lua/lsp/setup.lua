

local status, mason = pcall(require, "mason")
if not status then 
  vim.notify("没有找到 mason")
  return 
end 

local status, mason_config = pcall(require, "mason-lspconfig")
if not status then 
  vim.notify("没有找到 mason-lspconfign")
  return 
end 

local status, lspconfig = pcall(require, "lspconfig")
if not status then 
  vim.notify("没有找到 lspconfign")
  return 
end 

-- :h mason-default-settings
-- ~/.local/share/nvim/mason
mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

-- mason-lspconfig uses the `lspconfig` server names in the APIs it exposes - not `mason.nvim` package names
-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
mason_config.setup({
  -- 确保安装，根据需要填写
  ensure_installed = {
--    "sumneko_lua",
--    "tsserver",
--    "tailwindcss",
    "lua_ls",
    "bashls",
    "jsonls",
    "html",
    "cssls",
    "clangd",
--    "dockerls",
--    "emmet_ls",
--    "pyright",
--    "rust_analyzer",
--    "taplo",
--    "yamlls",
--    "gopls",
  },

})

-- 安装列表
-- { key: 服务器名， value: 配置文件 }
-- key 必须为下列网址列出的 server name，不可以随便写
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
local servers = {
    lua_ls = require 'lsp.config.lua',  -- lua/lsp/config/lua.lua
--  bashls = require 'lsp.config.bash',
--  jsonls = require 'lsp.config.json',
--  html = require 'lsp.config.html',
--  cssls = require 'lsp.config.css',

--  yamlls = require("lsp.config.yamlls"),
--  dockerls = require("lsp.config.docker"),
--  tailwindcss = require("lsp.config.tailwindcss"),
--  rust_analyzer = require("lsp.config.rust"),
--  taplo = require("lsp.config.taplo"), -- toml
--  gopls = require("lsp.config.gopls"),
  -- remark_ls = require("lsp.config.markdown"),
    clangd = require("lsp.config.clangd"),
--  cmake = require("lsp.config.cmake"),
}


for name, config in pairs(servers) do 
  if config ~= nil and type(config) == "table" then 
    -- 自定义初始化配置必须实现 on_setup 方法
    config.on_setup(lspconfig[name])
  else
    -- 使用默认参数
    lspconfig[name].setup({})
  end 
end 

--require 'lsp.ui'
