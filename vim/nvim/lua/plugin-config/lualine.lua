-- 底部信息显示栏
local status, lualine = pcall(require, "lualine")
if not status then 
  vim.notify("没有找到 lualine")
  return 
end 


--[[
--lualine 的配置参数主要有 options，extensions 和 sections 三块。
  options 用于设置样式， 其中 theme 设置主题配色，可以设置为 auto，
  也可以设置为主题列表中的一个， 我这里设置的是 tokyonight，是由 tokyonight 主题配色额外提供的支持。
  section_separators 设置分段分隔符， component_separators 设置分段中的组件分隔符。

  extensions 用于设置 lualine 支持的扩展，详见扩展列表 这里我们只会用到 nvim-tree 和 toggleterm 。

  sections 用于设置不同分段，所需显示的功能模块， 分段有 6 个，分别为： A B C X Y Z 。

-- link: https://juejin.cn/book/7051157342770954277/section/7060826296451858446
--]]


lualine.setup({
  options = {
    theme = "tokyonight",
    component_separators = { left = "|", right = "|" },
     -- https://github.com/ryanoasis/powerline-extra-symbols
    section_separators = { left = " ", right = "" },
  },

  extensions = { "nvim-tree", "toggleterm" },
  
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnosticd' },
    lualine_c = { 'filename' },
    
    lualine_x = { 'encodeing', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },

--[=[
  sections = {
    lualine_c = {
      "filename",
      {
        "lsp_progress",
        spinner_symbols = { " ", " ", " ", " ", " ", " " },
      },
    },

    lualine_x = {
      "filesize",
      --symbols = {
        --   unix = '', -- e712
        --   dos = '', -- e70f
        --   mac = '', -- e711
        -- },
      symbols = {
        unix = "LF",
        dos = "CRLF",
        mac = "CR",
      },
      "encoding",
      "filetype",
    },
  },
--]=]

})
