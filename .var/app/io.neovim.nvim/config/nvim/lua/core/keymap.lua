local M = {}

--[[
Ctrl  modifier --> <C-key>
Shift modifier --> <S-key>
Alt   modifier --> <A-key> / <M-key>
Super modifier --> <D-key>

<leader>       User defined, default: '\'

<BS>           Backspace
<Tab>          Tab
<CR>           Enter
<Enter>        Enter
<Return>       Enter
<Esc>          Escape
<Space>        Space
<Up>           Up arrow
<Down>         Down arrow
<Left>         Left arrow
<Right>        Right arrow
<F1> - <F12>   Function keys 1 to 12
#1, #2..#9,#0  Function keys F1 to F9, F10
<Insert>       Insert
<Del>          Delete
<Home>         Home
<End>          End
<PageUp>       Page-Up
<PageDown>     Page-Down
<bar>          the '|' character, which otherwise needs to be escaped '\|'
--]]

function M.load()
  local pinfo = require('core.plugin-info').infos
  local kmap = require('lib.kmap').domap
  local opts = { 'noremap' }

  kmap.nraw('<space>e', vim.diagnostic.open_float, opts)
  kmap.nraw('[d', vim.diagnostic.goto_prev, opts)
  kmap.nraw(']d', vim.diagnostic.goto_next, opts)
  kmap.nraw('<space>q', vim.diagnostic.setloclist, opts)
  kmap.ncmd('<C-t>', '<Cmd>exe v:count1 . "ToggleTerm"', opts)
  kmap.ncmd('<C-t>', '<Esc><Cmd>exe v:count1 . "ToggleTerm"', opts)
  kmap.ncmd('<leader>c', 'PackerCompile', opts)

  pinfo.cmp.keymap = {
    abort          = { '<C-e>' },
    scroll_back    = { '<C-b>' },
    scroll_forward = { '<C-f>' },
    confirm        = { '<CR>' },
    complete       = { '<C-Space>' },
    next_item      = { '<Tab>' },
    prev_item      = { '<S-Tab>' },
  }

  pinfo.lsp.keymap = {
    formatting  = { '<space>f' },
    definition  = { 'gd' },
    declaration = { 'gD' },
    references  = { 'gr' },
    hover       = { 'K' },
    help        = { '<C-k>' },
    rename      = { '<space>rn' }
  }

  pinfo.gitsigns.keymap = {
    diff_file       = { '<leader>hd' },
    preview_hunk    = { '<leader>hp' },
    stage_hunk_undo = { '<leader>hu' },
    stage_hunk      = { '<leader>hs' },
    reset_hunk      = { '<leader>hr' },
    next_diff       = { ']df' },
    prev_diff       = { '[df' }
  }

  pinfo.nvim_tree.keymap = {
    refresh = '<leader>r',
    toggle = '<C-n>',
  }
end

return M
