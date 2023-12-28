--[[ link: https://juejin.cn/book/7051157342770954277/section/7051536642238054430?scrollMenuIndex=2
--在 Neovim 中使用以下方法设置快捷键：
--    vim.api.nvim_set_keymap() 全局快捷键
--    vim.api.nvim_buf_set_keymap() Buffer 快捷键
--  一般情况下，都是定义使用全局快捷键， Buffer 快捷键一般是在某些异步回调函数里指定，
--  例如某插件初始化结束后，会有回调函数提供 Buffer，这个时候我们可以只针对这一个 Buffer 设置快捷键。
--  关于 Buffer 快捷键部分，我们后边课程会遇到，这里先看全局设置。

--  lua
--  复制代码
--  vim.api.nvim_set_keymap('模式', '按键', '映射为', 'options')
--  这里 模式 参数用一个字母表示，常见的有：
--    n Normal 模式
--    i Insert 模式
--    v Visual 模式
--    t Terminal 模式
--    c Command 模式
--    按键 就是你按下的键，没什么说的。

--  映射为 可以是多个按键组合，比如 5j 就是连续点击5和j， 也可以是一条命令比如 :q<CR>，表示退出。
--  options 大部分会设置为 { noremap = true, silent = true }。
--  noremap 表示不会重新映射，比如你有一个映射 A -> B , 还有一个 B -> C，
--  这个时候如果你设置 noremap = false 的话，表示会重新映射，那么 A 就会被映射为 C。
--  silent 为 true，表示不会输出多余的信息。
--]]

-- 设置 leader key，常用的前缀，通常设置为空格
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 由于要设置很多快捷键，先保存为本地变量
local map = vim.api.nvim_set_keymap
-- 复用 opt 参数
local opt = {noremap = true, silent = true}

-- -- -- -- -- 窗口管理快捷键映射 -- -- -- -- --
-- [[
-- 分屏相关的操作，都设置以 s 开头 (Split)，组成一系列命令， 
-- sh 代表水平分屏（Split Horizontally），
-- sv 代表垂直分屏 (Split Vertically），
-- sc 关闭窗口 (Close)，
-- so 关闭其他 (Others)。
-- 同时把 Alt + h/j/k/l 设置为在窗口之间跳转。
-- ]]

-- 取消 s 的默认功能
map("n", "s", "", opt)
-- link: https://www.volcengine.com/theme/6676375-R-7-1
-- 重新加载用Lua编写的Neovim配置
map("n", "<C-R>", ":luafile $MYVIMRC<CR>", opt)

-- windows 分屏快捷键
map("n", "sv", ":vsp<CR>", opt)
map("n", "sh", ":sp<CR>", opt)

-- 关闭当前
map("n", "sc", "<C-w>c", opt)

-- 关闭其他
map("n", "so", "<C-w>o", opt)

-- Alt + hjhl 窗口之间跳转
map("n", "<A-h>", "<C-w>h", opt)
map("n", "<A-j>", "<C-w>j", opt)
map("n", "<A-k>", "<C-w>k", opt)
map("n", "<A-l>", "<C-w>l", opt)

-- 窗口左右比例控制
map("n", "<C-Left>", ":vertical resize -2<CR>", opt)
map("n", "<C-Right>", ":vertical resize +2<CR>", opt)
map("n", "s,", ":vertical resize -20<CR>", opt)
map("n", "s.", ":vertical resize +20<CR>", opt)


-- 窗口上下比例控制
map("n", "<C-Down>", ":resize +2<CR>", opt)
map("n", "<C-Up>", ":resize -2<CR>", opt)
map("n", "sj", ":resize +10<CR>", opt)
map("n", "sk", ":resize -10<CR>", opt)

-- 等比例
map("n", "s=", "<C-w>=", opt)

-- Termial 相关
-- 水平分屏并打开终端
map("n", "<leader>t", ":sp | terminal<CR>", opt)
-- 竖直分屏并打开终端
map("n", "<leader>vt", ":vsp | terminal<CR>", opt)
-- termial 模式中的操作
map("t", "<Esc>", "<C-\\><C-n>", opt)
map("t", "<A-h>", [[ <C-\><C-N><C-w>h ]], opt)
map("t", "<A-j>", [[ <C-\><C-N><C-w>j ]], opt)
map("t", "<A-k>", [[ <C-\><C-N><C-w>k ]], opt)
map("t", "<A-l>", [[ <C-\><C-N><C-w>l ]], opt)

-- visual模式下缩进代码
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)

-- visual模式下 上下移动选中文本
map("v", "J", ":move '>+1<CR>gv-gv", opt)
map("v", "K", ":move '<-2<CR>gv-gv", opt)

-- visual模式里 粘贴 不要复制
map("v", "p", '"_dP', opt)

-- 退出
map("n", "q", ":q<CR>", opt)
map("n", "qq", ":q!<CR>", opt)
map("n", "Q", ":qa!<CR>", opt)

-- insert 模式下， 跳到行首行尾
map("i", "<C-h>", "<ESC>I", opt)
map("i", "<C-l>", "<ESC>A", opt)

-- 滚动浏览 
map("n", "<C-j>", "4j", opt)
map("n", "<C-k>", "4k", opt)

-- ctrl u / ctrl d 设置只移动9行，默认时移动半屏
map("n", "<C-u>", "9k", opt)
map("n", "<C-d>", "9j", opt)

map("i", "jj", "<Esc>l", opt)
map("i", "<C-s>", "<Esc>:w<CR>i", opt)
map("n", "<C-s>", "<Esc>:w<CR>", opt)


-- bufferline
-- 左右Tab切换
map("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt)
map("n", "<C-l>", ":BufferLineCycleNext<CR>", opt)

-- 关闭
-- ”moll/vim-bbye"
map("n", "<C-w>", ":Bdelete!<CR>", opt)
map("n", "<leader>bl", ":BufferLineCloseRight<CR>", opt)
map("n", "<leader>bh", ":BufferLineCloseLeft<CR>", opt)
map("n", "<leader>bc", ":BufferLinePickClose<CR>", opt)


-- Telescope
-- 查找文件
map("n", "<C-p>", ":Telescope find_files<CR>", opt)
-- 全局搜索
map("n", "<C-f>", ":Telescope live_grep<CR>", opt)

------------------ 插件快捷键 ----------
local pluginKeys = {}

-- nvim-tree
-- alt + m 键打开关闭 tree
map("n", "<A-m>", ":NvimTreeToggle<CR>", opt)

-- 文件树 列表快捷键
pluginKeys.nvimTreeList = {
  -- 打开文件或文件夹
  { key = {"<CR>", "o", "<2-LeftMouse>"}, action = "edit"},
  -- 分屏打开文件
  { key = "v", action = "vsplit" },
  { key = "h", action = "split" },
  -- 显示隐藏文件
  { key = "i", action = "toggle_custom"}, -- 对应 filters 中的 custom (node_modules)
  { key = ".", action = "toggle_dotfiles"}, -- Hide (dotfiles)
  -- 文件操作
  { key = "<F5>", action = "refresh"},
  { key = "a", action = "create"},
  { key = "d", action = "remove"},
  { key = "r", action = "rename"},
  { key = "x", action = "cut"},
  { key = "c", action = "copy"},
  { key = "p", action = "paste"},
  { key = "s", action = "system_open"},
}

-- 搜索快捷键
pluginKeys.telescopeList = {
  i = {
    -- 上下移动
    ['<C-j>'] = "move_selection_next",
    ['<C-k>'] = "move_selection_previous",
    ['<Down>'] = "move_selection_next",
    ['<Up>'] = "move_selection_previous",

    -- 历史记录
    ['<C-n>'] = "cycle_history_next",
    ['<C-p>'] = "cycle_history_prev",

    -- 关闭窗口
    ['<C-c>'] = "close",

    -- 预览窗口上下滚动
    ['<C-u>'] = "preview_scrolling_up",
    ['<C-d>'] = "preview_scrolling_down",

  },
}

-- lsp 回调函数快捷键设置
pluginKeys.mapLSP = function(mapbuf)
  -- rename
  mapbuf("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opt)
  -- code action
  mapbuf("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opt)
  -- go xx
  mapbuf("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opt)
  mapbuf("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opt)
  
end 


-- nvim-cmp 自动补全
pluginKeys.cmp = function(cmp)

  local feedkey = function (key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true) 
  end

  local has_words_before = function ()
    local line, col = unpack(vim.api.nvin_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  return {
    -- 出现补全
    ["<A-.>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
    -- 取消
    ["<A-,>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close()
    }),
    -- 上一个 
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    -- 下一个 
    ["<C-j>"] = cmp.mapping.select_next_item(),
    -- 确认
    -- [==[ tips: 补全确认报错
    -- offset_encoding：预期的字符串，得到零
    -- fixed：打开此文件/usr/share/nvim/runtime/lua/vim/lsp/util.lua或系统上的等效文件
    --  并更改function M.apply_text_editsat行的开头
    -- ]==]
    ["<CR>"] = cmp.mapping.confirm({
      select = true,
      behavior = cmp.ConfirmBehavior.Replace,
    }),
    
    -- 如果窗口太多，可以滚动
    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),

    -- 自定义代码段跳转到下一个参数
    ["<C-l>"] = cmp.mapping(function (_)
      if vim.fn["vsnip#available"](1) == 1 then 
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      end 
    end, {"i", "s"}),

    -- 自定义代码段跳转到上一个参数
    ["<C-h>"] = cmp.mapping(function (_)
      if vim.fn["vsnip#jumpable"](-1) == 1 then 
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end 
    end, {"i", "s"}),

--[==[
    ["<Tab>"] = cmp.mapping(function (fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else 
        fallback()
      end 
    end, {"i", "s"}),
--]==]

    ["<S-Tab>"] = cmp.mapping(function ()
      if cmp.visible() then 
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then 
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, {"i", "s"}),
  }
end 


return pluginKeys
