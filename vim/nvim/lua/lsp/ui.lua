
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  -- 输入模式下也更新提示， 设置为true 也许会影响性能
  update_in_insert = true,
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign"..type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })   
end

-- lspkind --常见小图标
local status, lspkind = pcall(require, 'lspkind')
if not status  then
  vim.notify("没有找到 lspkind")
end

lspkind.init({
  mode = 'symbol_text',

  perset = 'codicons',

  symbol_map = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "ﰠ",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "塞",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "פּ",
    Event = "",
    Operator = "",
    TypeParameter = "",
  },
})

local M  = {}
-- 为cmp.lua 提供参数格式
M.formatting = {
  format = lspkind.cmp_format({
    mode = 'symbol_text',

    maxwidth = 50,

    before = function (entry, vim_item)
      -- Source 显示提示来源 
      vim_item.menu = ('[%s]'):format(entry.source.name:upper())
      return vim_item
    end
  }),
}


return M


