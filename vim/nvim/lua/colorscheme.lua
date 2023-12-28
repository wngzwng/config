
-- vim.o.background = 'dark'
-- vim.g.tokyonight_style = "storm"
-- -- 半透明
-- vim.g.tokyonight_transparent = true 
-- vim.g.tokyonight_transparent_sidebar = true
local colorscheme = "tokyonight"
-- gruvbox
-- zephyr
-- nord
-- onedark
-- tokyonight
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " 没有找到！")
  return 
end
vim.o.background = 'dark'
vim.g.tokyonight_style = "storm"
-- 半透明
vim.g.tokyonight_transparent = true 
vim.g.tokyonight_transparent_sidebar = true 
vim.cmd('au FileType * hi Normal guibg=NONE ctermbg=NONE')
