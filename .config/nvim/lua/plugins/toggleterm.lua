local M = {}


---@class Plugin.toggleterm.keymap
---@field toggle Key

function M.info()
  return {
    name = 'toggleterm.nvim',
    module = 'plugins.toggleterm',
    fullname = 'akinsho/toggleterm.nvim',
    tag = '*',
    ---@type Plugin.toggleterm.keymap
    keymap = {},
  }
end

function M.register(info)
  require('lib.kmap').dump_cfg(info.module, info.keymap)

  return {
    info.fullname,
    tag = info.tag,
    config = function()
      ---@type Plugin.toggleterm.keymap|nil
      local keys = require('lib.kmap').load_cfg('plugins.toggleterm')
      if not keys then keys = {} end

      require('toggleterm').setup {
        hide_numbers = true, -- hide the number column in toggleterm buffers
        direction = 'float', -- 'vertical' | 'horizontal' | 'tab' | 'float',
        close_on_exit = true,
        auto_scroll = true,
        float_opts = {
          -- The border key is *almost* the same as 'nvim_open_win'
          -- see :h nvim_open_win for details on borders however
          border = 'rounded' -- 'single'/'rounded' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
          -- like `size`, width and height can be a number or function which is passed the current terminal
          -- width = <value>,
          -- height = <value>,
          -- winblend = 3,
        },
        --- map
        open_mapping = keys.toggle,
        start_in_insert = true,
        insert_mappings = true, -- whether or not the open mapping applies in insert mode
        terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
        --[[
        on_open = fun(t: Terminal), -- function to run when the terminal opens
        on_close = fun(t: Terminal), -- function to run when the terminal closes
        on_stdout = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stdout
        on_stderr = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stderr
        on_exit = fun(t: Terminal, job: number, exit_code: number, name: string) -- function to run when terminal process exits
        --]]
      }
    end
  }
end

return M
