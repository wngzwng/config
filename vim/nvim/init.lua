
-- link https://juejin.cn/book/7051157342770954277/section/7051157342846451748?scrollMenuIndex=2
require('basic')
--- Packer 插件管理
require('plugins')
-- 快捷键映射
require('keybindings')
-- 主题设计
require('colorscheme')
-- 插件配置
require('plugin-config.nvim-tree')
-- 顶部标签页 
require('plugin-config.bufferline')
-- 搜索
require('plugin-config.telescope')
-- 初始界面
require('plugin-config.dashboard')
-- 项目
require('plugin-config.project')
-- 底部信息显示栏
require('plugin-config.lualine')
-- 语法高亮
require('plugin-config.nvim-treesitter')
-- lsp
require('lsp.setup')
-- cmp
require('lsp.cmp')
require('lsp.ui')
-- indent-blankline
require('plugin-config.indent-blankline')


--[[
[NvimTree]
Unknown option: open_on_setup_file
Unknown option: view.mappings
Unknown option: view.hide_root_folder

see :help nvim-tree-opts for available configuration options
--]]
