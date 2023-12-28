--[[ link: https://juejin.cn/book/7051157342770954278/section/7051844262287130638?scrollMenuIndex=2
--我们通常使用 use 'name/repo' 来安装插件，name/repo 对应github 的地址。
--例如上边代码中的 use 'wbthomason/packer.nvim'，
--对应的就是 https://github.com/wbthomason/packer.nvim 地址。
--我们之前说过，安装插件要求你有一个稳定可联通 Github 的网络环境，
--如果你的网络不好，可以尝试设置第二个 config 参数，使用代理站点。
--config 中还有很多参数，具体可参考帮助文档，比较实用的还有，以浮动窗口打开安装列表：
--config = {
--    display = {
--      open_fn = function()
--        return require("packer.util").float({ border = "single" })
--      end,
--  },
}

-- 插件相关命令
-- 配置生效后，Neovim 会增加以下命令。
    :PackerCompile： 每次改变插件配置时，必须运行此命令或 PackerSync, 重新生成编译的加载文件
    :PackerClean ： 清除所有不用的插件
    :PackerInstall ： 清除，然后安装缺失的插件
    :PackerUpdate ： 清除，然后更新并安装插件
    :PackerSync : 执行 PackerUpdate 后，再执行 PackerCompile
    :PackerLoad : 立刻加载 opt 插件

通过上边的说明，我们观察到 :PackerSync 命令包含了 :PackerUpdate 和:PackerCompile，
而 :PackerUpdate 又包含了 :PackerClean 和 :PackerInstall 流程。
所以通常情况下，无论安装还是更新插件，我只需要下边这一条命令就够了。
    :PackerSync

每次修改完 lua/plugins.lua 这个文件后，保存退出，
重新打开并调用 :PackerSync 就可以了，只要你的网络可以连接到 github，插件就会安装成功。

-- 安装位置
-- Neovim 推荐将数据存储在 标准数据目录下（:h base-directories 查看详细文档），
-- 标准数据目录默认是 ~/.local/share/nvim/ ，你可以通过调用 :echo stdpath("data") 命令查看你系统下的实际路径。
-- Packer 会将插件默认安装在 标准数据目录/site/pack/packer/start 中，
-- 完整目录也就是~/.local/share/nvim/site/pack/packer/start 目录下。

-- 你现在可以进入这个目录，查看一下安装的插件，应该看到只安装了 packer.nvim 一个插件，
-- 后续安装的插件也都会出现在这个目录中。

-- 之前我们讲了安装组件的流程为： 修改 lua/plugins.lua 文件，保存退出，重新打开并调用 :PackerSync
-- 其实如果你愿意的话，我们可以添加一条自动命令让每次保存 lua/plugins.lua 就自动安装组件
--
-- 添加自动安装
打开 lua/plugins.lua 文件，在最后添加：
-- 每次保存 plugins.lua 自动安装插件
  pcall(
    vim.cmd,
    [[
      augroup packer_user_config
      autocmd!
      autocmd BufWritePost plugins.lua source <afile> | PackerSync
      augroup end
    ]]
--)
--这里的 [[ ... ]] 中间的部分是 VIM 脚本，因为 Neovim 还没有实现自动命令的 API，
--所以我们需要使用 vim.cmd 命令来执行这段脚本。

--这段脚本的意思是 BufWritePost 事件时，如果改的是 lua/plugins.lua 文件，
--就自动重新加载并调用 :PackerSync 命令，这样就不用手动重启，可以自动安装插件了。
--pcall 命令是一个 Lua 函数，它的作用是检查一个函数是否执行成功，
--如果执行成功，则返回 true，否则返回 false ，防止报错，后边遇到的时候还会再详细解释
--]]

local packer = require("packer")
packer.startup({
  function(use)
    -- Packer 可以管理自己本身
    use 'wbthomason/packer.nvim'

    -- 插件列表
    --------------------- colorschemes --------------------
    -- tokyonight
    use({ "folke/tokyonight.nvim",
          opts = { transparent = true }
        })
    -- OceanicNext
    use("mhartington/oceanic-next")
    -- gruvbox
    use({ "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } })
    -- zephyr 暂时不推荐，详见上边解释
    -- use("glepnir/zephyr-nvim")
    -- nord
    use("shaunsingh/nord.nvim")
    -- onedark
    use("ful1e5/onedark.nvim")
    -- nightfox
    use("EdenEast/nightfox.nvim")

    -- nvim-tree
    use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })
--[[
    use({ "nvim-tree/nvim-tree.lua", 
          requires = "nvim-tree/nvim-web-devicons",
          config = function()
            return "plugin-config.nvim-tree"
          end,
    })
--]]
    -- bufferLine
    -- [[这里我增加了一个 vim-bbye 依赖，
    -- 因为这个插件安装后会增加一个 :Bdelete 命令，
    -- 相比内置的 :bdelete, 它删除 buffer 的同时，并不会搞乱布局 。 
    -- 待会儿我们会配置 Bdelete 为关闭 Tab 的命令。]]
    use({ "akinsho/bufferline.nvim",
          requires = { "kyazdani42/nvim-web-devicons",
                       "moll/vim-bbye",
          },
    })

    -- lualine 
    use({ "nvim-lualine/lualine.nvim",
          --requires = { "kyazdani42/nvim-web-devicons" },
          requires = { "nvim-tree/nvim-web-devicons", opt = true },
    })
    use 'arkav/lualine-lsp-progress'

    -- telescope  模糊查询
    use({ "nvim-telescope/telescope.nvim",
          requires = { "nvim-lua/plenary.nvim" },
    })

    -- 列出环境变量
    use 'LinArcX/telescope-env.nvim'

    -- dashboard-nvim 初始界面
    use({ 'glepnir/dashboard-nvim',
           requires = { 'nvim-tree/nvim-web-devicons' },
        --   commit = "a36b3232c98616149784f2ca2654e77caea7a522",
    })

    -- project
    use 'ahmedkhalf/project.nvim'

    -- 语法高亮
    use({ "nvim-treesitter/nvim-treesitter", 
          run = ":TSUpdate",
    }) 

    -- LSP (语言服务协议）
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    -- lspconfig
    use 'neovim/nvim-lspconfig'
    
    -- 补全引擎
    use 'hrsh7th/nvim-cmp'
    -- snipper 引擎
    use 'hrsh7th/vim-vsnip'
    -- 补全源
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/cmp-nvim-lsp'  -- { name = 'nvim_lsp' }
    use 'hrsh7th/cmp-buffer'    -- { name = 'buffer' }
    use 'hrsh7th/cmp-path'      -- { name = 'patt' }
    use 'hrsh7th/cmp-cmdline'   -- { name = 'cmdline' }

    -- 常见编程语言代码段
    use 'rafamadriz/friendly-snippets'

    -- ui 
    use 'onsails/lspkind-nvim'

    -- 对齐竖线
    -- indent-blankline
    use("lukas-reineke/indent-blankline.nvim")

    -- 自动括号匹配
    use 'jiangmiao/auto-pairs'

    -- 注释
    use { 'numToStr/Comment.nvim',
        config = function ()
            require('Comment').setup()
        end
    }

    use { 'kylechui/nvim-surround', 
        config = function ()
                require("nvim-surround").setup({

                })
        end
    }
    use {
        'JuanZoran/Trans.nvim',
        keys = {
            { 'v', 'mm' }, -- 换成其他你想用的key即可
            { 'n', 'mm' },
            { 'n', 'mi' },
        },
        -- run = 'bash ./install.sh',
        run = function () require("Trans").install() end,
        requires = 'kkharji/sqlite.lua',
        dependencies = { 'kkharji/sqlite.lua'},
        -- 如果你不需要任何配置的话, 可以直接按照下面的方式启动

        config = function ()
                require('Trans').setup({
                    dir = "$HOME/.vim/dict"
                })
            -- require('plugin-config.trans')
            vim.keymap.set({"v", 'n'}, "mm", '<Cmd>Translate<CR>', { desc = ' Translate' }) -- 自动判断virtual 还是 normal 模式
            vim.keymap.set("n", "mi", "<Cmd>TranslateInput<CR>", { desc = ' Translate' })

    end
}

  end,

  config = {
    -- 并发数限制
    max_jobs =16,

    -- 自定义源
    git = {
      -- default_url_format = "https://hub.fastgit.xyz/%s",
     -- default_url_format = "https://mirror.ghproxy.com/https://github.com/%s",
     -- default_url_format = "https://gitcode.net/mirrors/%s",
    -- default_url_format = "https://gitclone.com/github.com/%s",

    },

    display = {
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end,
    },

  },
})

pcall(
  vim.cmd,
  [[
    augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
  ]]
)
