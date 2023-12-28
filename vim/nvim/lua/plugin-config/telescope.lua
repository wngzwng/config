
local status, telescope = pcall(require, "telescope")
if not status then 
  vim.notify("没有找到 telescope")
  return 
end 

--
telescope.setup({
  defaults = {
    -- 打开弹出口进入的初始模式， 默认为insert， 也可以时normal
    initial_mode = "insert",
    -- 窗口内快捷键
    mappings = require("keybindings").telescopeList,
    -- 打开预览模式
    layout_config = {
      horizontal = {
        width = 0.98,
        preview_cutoff = 0,
      },
    },
  },

  pickers = {
    -- 内置 pickers 配置
    find_files = {
      -- 查找文件换皮肤， 支持的参数有：dropdown, cursor, ivy
      -- theme = "dropdown", 
    },
  },

  extensions = {
    -- 拓展插件配置
  },

})
--]]
pcall(telescope.load_extension, "env")
