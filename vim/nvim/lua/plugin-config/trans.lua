
local status, trans = pcall(require, "Trans")
if not status then 
  vim.notify("没有找到 trans")
  return 
end 

--
-- trans.setup({
--     ---@type string the directory for database file and password file
--     -- dir      = require 'Trans'.plugin_dir,
--     dir      = "~/.vim/dict",
-- })

trans.setup({
    strategy = {
        default = {
            frontend = 'hover',
            backend = '*'
        }
    },
    view = {
        i = 'float',
        n = 'hover',
        v = 'hover',
    },
    hover = {
        width = 37,
        height = 27,
        border = 'rounded',
        title = title,
        keymap = {
            pageup = '[[',
            pagedown = ']]',
            pin = '<leader>[',
            close = '<leader>]',
            toggle_entry = '<leader>;',
            play = '_',
        },
        animation = {
            -- open = 'fold',
            -- close = 'fold',
            open = 'slid',
            close = 'slid',
            interval = 12,
        },
        auto_close_events = {
            'InsertEnter',
            'CursorMoved',
            'BufLeave',
        },
        auto_play = true,
        timeout = 3000,
        spinner = 'dots', -- 查看所有样式: /lua/Trans/util/spinner
        -- spinner = 'moon'
    },
    float = {
        width = 0.8,
        height = 0.8,
        border = 'rounded',
        title = title,
        keymap = {
            quit = 'q',
        },
        animation = {
            open = 'fold',
            close = 'fold',
            interval = 10,
        },
        tag = {
            wait = '#519aba',
            fail = '#e46876',
            success = '#10b981',
        },
        engine = {
            '本地',
        }
    },
    order = { -- only work on hover mode
        'title',
        'tag',
        'pos',
        'exchange',
        'translation',
        'definition',
    },
    icon = {
        star = '',
        notfound = ' ',
        yes = '✔',
        no = '',
    -- --- char: ■ | □ | ▇ | ▏ ▎ ▍ ▌ ▋ ▊ ▉ █
    -- --- ◖■■■■■■■◗▫◻ ▆ ▆ ▇⃞ ▉⃞
        cell = '■',
        -- star = '⭐',
        -- notfound = '❔',
        -- yes = '✔️',
        -- no = '❌'
    },
    theme = 'default',
    -- theme = 'dracula',
    -- theme = 'tokyonight',

    db_path = '$HOME/.vim/dict/ultimate.db',

    engine = {
        -- baidu = {
        --     appid = '',
        --     appPasswd = '',
        -- },
        -- -- youdao = {
        --     appkey = '',
        --     appPasswd = '',
        -- },
    },

    -- TODO :
    -- register word
    -- history = {
    --     -- TOOD
    -- }

    -- TODO :add online translate engine
})

