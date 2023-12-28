
local status, cmp = pcall(require, "cmp")
if not status then 
  vim.notify("没有找到 cmp")
  return 
end 

cmp.setup({
  -- 指定 snipper 引擎
  snippet = {
    expand = function(args)
     -- For `vsnip` users.
      vim.fn["vsnip#anonymous"](args.body)

      -- For `luasnip` users.
      -- require('luasnip').lsp_expand(args.body)

      -- For `ultisnips` users.
      -- vim.fn["UltiSnips#Anon"](args.body)

      -- For `snippy` users.
      -- require'snippy'.expand_snippet(args.body)
    end,
  },

  sources = cmp.config.sources(
    {
        { name = "nvim_lsp" },
        -- For vsnip users.
        { name = "vsnip" },

      -- For luasnip users.
      -- { name = 'luasnip' },

      --For ultisnips users.
      -- { name = 'ultisnips' },

      -- -- For snippy users.
      -- { name = 'snippy' },
    },
    { 
      { name = "buffer" }, 
      { name = "path" },
    }
  ),

  -- 快捷键设置
  mapping = require('keybindings').cmp(cmp), 

  -- 使用 lspkind-nvim 显示类型图标
  -- formatting = require('lsp.ui').formatting,
})

--
-- / 查找模式使用buffer源
cmp.setup.cmdline("/", {
 -- mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})


-- : 命令模式下使用path和cmdline源
cmp.setup.cmdline(":", {
 -- mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources(
    {
      { name = "path" }, 
    },
    {
      { name = "cmdline" },
    }
  ),
})

