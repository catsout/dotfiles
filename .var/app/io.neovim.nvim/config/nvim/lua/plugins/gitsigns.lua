local M = {}

---@class Plugin.gitsigns.keymap
---@field next_diff Array<string>
---@field prev_diff       Array<string>
---@field stage_hunk      Array<string>
---@field stage_hunk_undo Array<string>
---@field reset_hunk      Array<string>
---@field preview_hunk    Array<string>
---@field diff_file       Array<string>

function M.info()
  return {
    name = 'gitsigns.nvim',
    ---@type Plugin.gitsigns.keymap
    keymap = {},
    module = 'plugins.gitsigns',
    fullname = 'lewis6991/gitsigns.nvim',
  }
end

function M.register(info)
  require('lib.kmap').dump_cfg(info.module, info.keymap)

  return {
    info.fullname,

    config = function()
      local kmap = require('lib.kmap').domap
      ---@type Plugin.gitsigns.keymap | nil
      local keys = require('lib.kmap').load_cfg('plugins.gitsigns')
      local gs = require('gitsigns')

      gs.setup {
        on_attach = function(buf)
          if not keys then return end
          local opts = { 'noremap' }
          kmap.nraw(keys.next_diff, function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, { 'expr', 'noremap' }, buf)

          kmap.nraw(keys.prev_diff, function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, { 'expr', 'noremap' }, buf)

          kmap.nvcmd(keys.stage_hunk, 'Gitsigns stage_hunk', opts, buf)
          kmap.nvcmd(keys.reset_hunk, 'Gitsigns reset_hunk', opts, buf)
          kmap.ncmd(keys.stage_hunk_undo, 'Gitsigns undo_stage_hunk', opts, buf)
          kmap.ncmd(keys.preview_hunk, 'Gitsigns preview_hunk', opts, buf)
          kmap.ncmd(keys.diff_file, 'Gitsigns diffthis', opts, buf)
        end
      }
    end
  }
end

return M

--[[

require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
}

--]]
